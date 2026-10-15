import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Reads the lit digits on a 7-segment counter photo.
///
/// Aimed at meters like the samples: a dark face, glowing digits (white, red,
/// green, blue, or amber), and blank leading positions that are not part of
/// the number.
String? readCounterNumber(Uint8List bytes) {
  return decodeCounter(bytes).value;
}

class CounterDecodeResult {
  const CounterDecodeResult(this.value, this.log);

  final String? value;
  final String log;
}

CounterDecodeResult decodeCounter(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    return const CounterDecodeResult(null, 'Could not decode image');
  }

  final source = _downscale(img.bakeOrientation(decoded), 1100);
  final upright = _decodeStill(source);
  if (upright.value != null) {
    return upright;
  }

  // A tilted photo of the same kind of meter: try a few small rotations
  // only when the upright pass cannot see a digit row.
  final log = StringBuffer()..writeln(upright.log);
  for (final angle in const [-8, 8, -16, 16]) {
    final rotated = img.copyRotate(
      source,
      angle: angle,
      interpolation: img.Interpolation.linear,
    );
    final hit = _decodeStill(rotated);
    log.writeln('angle=$angle');
    log.writeln(hit.log);
    if (hit.value != null) {
      return CounterDecodeResult(hit.value, log.toString());
    }
  }
  return CounterDecodeResult(null, log.toString());
}

CounterDecodeResult _decodeStill(img.Image source) {
  final width = source.width;
  final height = source.height;
  final count = width * height;
  final channel = Uint8List(count);
  final excess = Uint8List(count);
  var maxChannel = 0;
  var maxExcess = 0;

  for (var y = 0, i = 0; y < height; y++) {
    for (var x = 0; x < width; x++, i++) {
      final pixel = source.getPixel(x, y);
      final r = pixel.r.round().clamp(0, 255);
      final g = pixel.g.round().clamp(0, 255);
      final b = pixel.b.round().clamp(0, 255);
      final bright = _ledScore(r, g, b);
      final colored = _excessScore(r, g, b);
      channel[i] = bright;
      excess[i] = colored;
      if (bright > maxChannel) {
        maxChannel = bright;
      }
      if (colored > maxExcess) {
        maxExcess = colored;
      }
    }
  }

  if (maxChannel < 40 && maxExcess < 40) {
    return const CounterDecodeResult(null, 'No lit display found');
  }

  final log = StringBuffer()
    ..writeln('size=${width}x$height channel=$maxChannel excess=$maxExcess');
  final hits = <_Hit>[];

  void collect(Uint8List score, int maxScore, List<double> fractions, String label) {
    if (maxScore < 40) {
      return;
    }
    for (final fraction in fractions) {
      final threshold = math.max(18, (maxScore * fraction).round());
      final hit = _readAtThreshold(
        score: score,
        width: width,
        height: height,
        threshold: threshold,
        fraction: fraction,
        log: log,
        label: label,
      );
      if (hit != null) {
        hits.add(hit);
        log.writeln('hit=${hit.text} gap=${hit.gap.toStringAsFixed(2)}');
      }
    }
  }

  // Brightness catches white-hot cores. Color excess opens holes in red
  // digits whose bloom is still bright but less saturated than the stroke.
  collect(channel, maxChannel, const [0.995, 0.98, 0.97, 0.93, 0.88], 'c');
  collect(excess, maxExcess, const [0.84, 0.74, 0.64, 0.54, 0.46], 'e');

  final best = _chooseHit(hits);
  if (best == null) {
    return CounterDecodeResult(null, log.toString());
  }
  log.writeln('chosen=${best.text}');
  return CounterDecodeResult(best.text, log.toString());
}

/// The same number showing up at several brightness levels is the display.
_Hit? _chooseHit(List<_Hit> hits) {
  final usable = hits.where((hit) {
    return hit.text.length <= 6 && !_looksFragmented(hit.text);
  }).toList();
  final hasReal = usable.any((hit) => !RegExp(r'^8+$').hasMatch(hit.text) && hit.text.length >= 2);
  final counts = <String, int>{};
  final bestFraction = <String, double>{};
  final bestGap = <String, double>{};
  for (final hit in usable) {
    if (hasReal && RegExp(r'^8+$').hasMatch(hit.text)) {
      continue;
    }
    counts[hit.text] = (counts[hit.text] ?? 0) + 1;
    final previous = bestFraction[hit.text] ?? 0;
    if (hit.fraction > previous) {
      bestFraction[hit.text] = hit.fraction;
    }
    final previousGap = bestGap[hit.text] ?? -1;
    if (hit.gap > previousGap) {
      bestGap[hit.text] = hit.gap;
    }
  }
  if (counts.isEmpty) {
    return null;
  }
  final stable = counts.keys.where((text) => counts[text]! >= 2).toList();
  final pool = stable.isNotEmpty ? [...stable] : counts.keys.toList();
  if (stable.isNotEmpty) {
    final bestStableGap = stable.map((text) => bestGap[text]!).reduce(math.max);
    for (final text in counts.keys) {
      final gap = bestGap[text] ?? 0;
      if (counts[text] == 1 &&
          text.length >= 2 &&
          gap >= 0.75 &&
          gap - bestStableGap >= 0.25) {
        pool.add(text);
      }
    }
  }
  final ranked = pool..sort((a, b) {
      final gapA = bestGap[a] ?? 0;
      final gapB = bestGap[b] ?? 0;
      if ((gapA - gapB).abs() > 0.05) {
        return gapB.compareTo(gapA);
      }
      if (_extends(b, a)) {
        return 1;
      }
      if (_extends(a, b)) {
        return -1;
      }
      final byCount = counts[b]!.compareTo(counts[a]!);
      if (byCount != 0) {
        return byCount;
      }
      final byLength = b.length.compareTo(a.length);
      if (byLength != 0) {
        return byLength;
      }
      return bestFraction[b]!.compareTo(bestFraction[a]!);
    });
  final text = ranked.first;
  return _Hit(text, 0, bestFraction[text]!, bestGap[text] ?? 0);
}

bool _extends(String longer, String shorter) {
  return longer.length > shorter.length &&
      (longer.startsWith(shorter) || longer.endsWith(shorter));
}

bool _looksFragmented(String text) {
  if (text.length < 4) {
    return false;
  }
  final ones = text.split('').where((digit) => digit == '1').length;
  return ones >= text.length - 1;
}

int _ledScore(int r, int g, int b) {
  final brightest = math.max(r, math.max(g, b));
  final darkest = math.min(r, math.min(g, b));
  var score = 0;
  // White segments are bright in every channel. Colored segments are bright
  // in one channel, so that channel's level is the stroke brightness.
  if (brightest - darkest < 85) {
    score = brightest;
  }
  if (r > g + 10 && r > b + 10 && r > score) {
    score = r;
  }
  if (g > r + 10 && g > b + 8 && g > score) {
    score = g;
  }
  if (b > r + 10 && b > g + 10 && b > score) {
    score = b;
  }
  return score;
}

int _excessScore(int r, int g, int b) {
  final brightest = math.max(r, math.max(g, b));
  final darkest = math.min(r, math.min(g, b));
  var score = 0;
  if (brightest - darkest < 45) {
    score = darkest;
  }
  final red = r - (g > b ? g : b);
  if (red > score) {
    score = red;
  }
  final green = g - (r > b ? r : b);
  if (green > score) {
    score = green;
  }
  final blue = b - (r > g ? r : g);
  if (blue > score) {
    score = blue;
  }
  return score;
}

img.Image _downscale(img.Image source, int maxSide) {
  final side = math.max(source.width, source.height);
  if (side <= maxSide) {
    return source;
  }
  final scale = maxSide / side;
  return img.copyResize(
    source,
    width: (source.width * scale).round(),
    height: (source.height * scale).round(),
    interpolation: img.Interpolation.linear,
  );
}

_Hit? _readAtThreshold({
  required Uint8List score,
  required int width,
  required int height,
  required int threshold,
  required double fraction,
  required StringBuffer log,
  required String label,
}) {
  final mask = Uint8List(score.length);
  var lit = 0;
  for (var i = 0; i < score.length; i++) {
    if (score[i] >= threshold) {
      mask[i] = 1;
      lit++;
    }
  }
  if (lit < 40) {
    log.writeln('t=$threshold lit=$lit skip');
    return null;
  }

  final components = _components(mask, score, width, height).where((component) {
    final onBorder = component.minX <= 2 ||
        component.minY <= 2 ||
        component.maxX >= width - 3 ||
        component.maxY >= height - 3;
    final slab = component.width > component.height * 2.4 && component.fill > 0.35;
    final tooTall = component.height > height * 0.48;
    if (onBorder || slab || tooTall || component.fill > 0.86 || component.area < 30) {
      return false;
    }
    return component.height >= 10;
  }).toList();

  if (components.isEmpty) {
    log.writeln('t=$threshold no components');
    return null;
  }

  final tallest = components.map((c) => c.height).reduce(math.max);
  final sized = components.where((c) => c.height >= tallest * 0.5).toList();
  if (sized.isEmpty) {
    return null;
  }
  final brightest = sized.map((c) => c.mean).reduce(math.max);
  final kept = sized.where((c) => c.mean >= brightest * 0.55).toList();
  if (kept.isEmpty) {
    return null;
  }

  final band = _bestBand(kept);
  if (band == null) {
    log.writeln('t=$threshold no band');
    return null;
  }

  final digits = _digitsInBand(mask, score, width, band);
  if (digits.isEmpty) {
    log.writeln('t=$threshold no digits in band ${band.minY}-${band.maxY}');
    return null;
  }

  final text = digits.map((d) => d.char).join();
  if (text.length > 6) {
    log.writeln('t=$threshold reject long $text');
    return null;
  }
  final meanGap = digits.map((digit) => digit.gap).reduce((a, b) => a + b) / digits.length;
  log.writeln(
    '$label t=$threshold h=${band.height} -> $text  ${digits.map((d) => '${d.char} ${d.detail}').join(' | ')}',
  );
  return _Hit(text, band.height, fraction, meanGap);
}

_Band? _bestBand(List<_Comp> components) {
  final rows = _clusterRows(components);
  _Band? best;
  var bestScore = -1;
  for (final row in rows) {
    final expanded = _expandVertically(row, components);
    final maxHeight = expanded.map((c) => c.height).reduce(math.max);
    final core = expanded.where((c) => c.height >= maxHeight * 0.45).toList();
    if (core.isEmpty) {
      continue;
    }
    final top = core.map((c) => c.minY).reduce(math.min);
    final bottom = core.map((c) => c.maxY).reduce(math.max);
    final bandHeight = bottom - top + 1;
    // A row of several glyphs is the display. One taller blob is usually
    // a lamp, a button, or a bright patch of wall.
    final score = core.length * 100000 + bandHeight;
    if (score <= bestScore) {
      continue;
    }
    bestScore = score;
    best = _Band(top, bottom);
  }
  return best;
}

List<_Comp> _expandVertically(List<_Comp> row, List<_Comp> all) {
  final chosen = <_Comp>[...row];
  var changed = true;
  while (changed) {
    changed = false;
    for (final candidate in all) {
      if (chosen.any((member) => identical(member, candidate))) {
        continue;
      }
      for (final member in chosen) {
        final overlap = math.min(candidate.maxX, member.maxX) -
            math.max(candidate.minX, member.minX);
        final xOverlap = overlap > 0.3 * math.min(candidate.width, member.width);
        final verticalGap = candidate.minY > member.maxY
            ? candidate.minY - member.maxY
            : member.minY > candidate.maxY
                ? member.minY - candidate.maxY
                : 0;
        final close = verticalGap < math.max(candidate.height, member.height);
        if (xOverlap && close) {
          chosen.add(candidate);
          changed = true;
          break;
        }
      }
    }
  }
  return chosen;
}

List<_Digit> _digitsInBand(
  Uint8List mask,
  Uint8List value,
  int width,
  _Band band,
) {
  final bandHeight = band.height;
  final projection = List<int>.filled(width, 0);
  for (var y = band.minY; y <= band.maxY; y++) {
    final row = y * width;
    for (var x = 0; x < width; x++) {
      if (mask[row + x] != 0) {
        projection[x]++;
      }
    }
  }

  final runs = <List<int>>[];
  var x = 0;
  while (x < width) {
    if (projection[x] < 2) {
      x++;
      continue;
    }
    final start = x;
    while (x < width && projection[x] >= 2) {
      x++;
    }
    runs.addAll(_splitWideRun(start, x - 1, projection, bandHeight));
  }

  final boxes = <_Comp>[];
  for (final run in runs) {
    final measured = _measure(mask, value, width, run[0], band.minY, run[1], band.maxY);
    if (measured == null) {
      continue;
    }
    if (measured.height < bandHeight * 0.55 || measured.width < 2) {
      continue;
    }
    boxes.add(measured);
  }

  final digits = <_Digit>[];
  for (final box in boxes) {
    final digit = _classify(value, width, box);
    if (digit != null) {
      digits.add(digit);
    }
  }
  if (digits.isEmpty) {
    return digits;
  }
  final brightest = digits.map((digit) => digit.peak).reduce(math.max);
  digits.retainWhere((digit) => digit.peak >= brightest * 0.62);
  digits.sort((a, b) => a.x.compareTo(b.x));
  return digits;
}

List<List<int>> _splitWideRun(
  int x0,
  int x1,
  List<int> projection,
  int bandHeight,
) {
  final runWidth = x1 - x0 + 1;
  if (runWidth < bandHeight * 0.90) {
    return [
      [x0, x1],
    ];
  }

  final margin = math.max(4, (bandHeight * 0.28).round());
  if (x0 + margin >= x1 - margin) {
    return [
      [x0, x1],
    ];
  }

  var peak = 0;
  for (var x = x0; x <= x1; x++) {
    if (projection[x] > peak) {
      peak = projection[x];
    }
  }
  var valleyAt = x0 + runWidth ~/ 2;
  var valley = 1 << 30;
  for (var x = x0 + margin; x <= x1 - margin; x++) {
    if (projection[x] < valley) {
      valley = projection[x];
      valleyAt = x;
    }
  }
  if (peak == 0 || valley > peak * 0.30) {
    return [
      [x0, x1],
    ];
  }

  return [
    ..._splitWideRun(x0, valleyAt - 1, projection, bandHeight),
    ..._splitWideRun(valleyAt + 1, x1, projection, bandHeight),
  ];
}

List<_Comp> _components(Uint8List mask, Uint8List value, int width, int height) {
  final seen = Uint8List(mask.length);
  final found = <_Comp>[];
  final stack = <int>[];

  for (var start = 0; start < mask.length; start++) {
    if (mask[start] == 0 || seen[start] != 0) {
      continue;
    }
    stack.add(start);
    seen[start] = 1;
    var minX = width;
    var minY = height;
    var maxX = 0;
    var maxY = 0;
    var area = 0;
    var sumV = 0;

    while (stack.isNotEmpty) {
      final index = stack.removeLast();
      final x = index % width;
      final y = index ~/ width;
      area++;
      sumV += value[index];
      if (x < minX) minX = x;
      if (y < minY) minY = y;
      if (x > maxX) maxX = x;
      if (y > maxY) maxY = y;

      if (x > 0) _push(stack, seen, mask, index - 1);
      if (x + 1 < width) _push(stack, seen, mask, index + 1);
      if (y > 0) _push(stack, seen, mask, index - width);
      if (y + 1 < height) _push(stack, seen, mask, index + width);
    }

    if (area < 25) {
      continue;
    }
    found.add(
      _Comp(
        minX: minX,
        minY: minY,
        maxX: maxX,
        maxY: maxY,
        area: area,
        sumV: sumV,
      ),
    );
  }
  return found;
}

void _push(List<int> stack, Uint8List seen, Uint8List mask, int index) {
  if (mask[index] != 0 && seen[index] == 0) {
    seen[index] = 1;
    stack.add(index);
  }
}

List<List<_Comp>> _clusterRows(List<_Comp> components) {
  final parent = List<int>.generate(components.length, (i) => i);
  int find(int i) {
    while (parent[i] != i) {
      parent[i] = parent[parent[i]];
      i = parent[i];
    }
    return i;
  }

  for (var i = 0; i < components.length; i++) {
    for (var j = i + 1; j < components.length; j++) {
      final a = components[i];
      final b = components[j];
      final heightRatio = math.min(a.height, b.height) / math.max(a.height, b.height);
      final dy = (a.cy - b.cy).abs();
      final limit = 0.55 * math.max(a.height, b.height);
      if (heightRatio > 0.42 && dy <= limit) {
        parent[find(i)] = find(j);
      }
    }
  }

  final groups = <int, List<_Comp>>{};
  for (var i = 0; i < components.length; i++) {
    groups.putIfAbsent(find(i), () => []).add(components[i]);
  }
  return groups.values.toList();
}

_Comp? _measure(
  Uint8List mask,
  Uint8List value,
  int width,
  int minX,
  int minY,
  int maxX,
  int maxY,
) {
  var left = maxX;
  var top = maxY;
  var right = minX;
  var bottom = minY;
  var area = 0;
  var sumV = 0;
  for (var y = minY; y <= maxY; y++) {
    final row = y * width;
    for (var x = minX; x <= maxX; x++) {
      if (mask[row + x] == 0) {
        continue;
      }
      area++;
      sumV += value[row + x];
      if (x < left) left = x;
      if (y < top) top = y;
      if (x > right) right = x;
      if (y > bottom) bottom = y;
    }
  }
  if (area < 15) {
    return null;
  }
  return _Comp(
    minX: left,
    minY: top,
    maxX: right,
    maxY: bottom,
    area: area,
    sumV: sumV,
  );
}

class _Digit {
  const _Digit(this.char, this.x, this.detail, this.peak, this.gap);

  final String char;
  final int x;
  final String detail;
  final int peak;
  final double gap;
}

_Digit? _classify(Uint8List score, int imageWidth, _Comp box) {
  final peak = _boxPeak(score, imageWidth, box);
  if (peak < 20) {
    return null;
  }

  if (box.width < box.height * 0.50) {
    final spine = _coverage(
      score,
      imageWidth,
      box,
      math.max(12, (peak * 0.62).round()),
      0.15,
      0.06,
      0.85,
      0.94,
      horizontal: false,
    );
    if (spine >= 0.5) {
      return _Digit('1', box.minX, 'narrow ${box.width}x${box.height}', peak, 0.8);
    }
  }

  // Side segments stay clear of the top, middle, and bottom bars so a thick
  // stroke does not light the gap of a 2, 3, 5, 6, or 9.
  const regions = <List<double>>[
    [0.26, 0.02, 0.74, 0.18],
    [0.74, 0.20, 1.00, 0.40],
    [0.74, 0.62, 1.00, 0.80],
    [0.26, 0.82, 0.74, 0.98],
    [0.00, 0.62, 0.26, 0.80],
    [0.00, 0.20, 0.26, 0.40],
    [0.26, 0.42, 0.74, 0.58],
  ];

  String? bestChar;
  var bestGap = -1.0;
  var bestDetail = '';
  for (final level in const [0.64, 0.76, 0.86, 0.93, 0.97]) {
    final localThreshold = math.max(12, (peak * level).round());
    final coverage = <double>[];
    for (var i = 0; i < regions.length; i++) {
      final region = regions[i];
      coverage.add(
        _coverage(
          score,
          imageWidth,
          box,
          localThreshold,
          region[0],
          region[1],
          region[2],
          region[3],
          horizontal: i == 0 || i == 3 || i == 6,
        ),
      );
    }
    if (coverage.reduce(math.max) < 0.35) {
      continue;
    }
    final cutoff = _segmentCutoff(coverage);
    final bits = StringBuffer();
    for (final amount in coverage) {
      bits.write(amount >= cutoff ? '1' : '0');
    }
    final pattern = bits.toString();
    final gap = _largestGap(coverage);
    var match = _patterns[pattern];
    if (match == null && gap >= 0.30 && level <= 0.93) {
      match = _matchPattern(pattern);
    }
    if (match == null || gap <= bestGap) {
      continue;
    }
    bestGap = gap;
    bestChar = match;
    bestDetail = '$pattern g=${gap.toStringAsFixed(2)} ${box.width}x${box.height}';
  }
  if (bestChar == null) {
    return null;
  }
  return _Digit(bestChar, box.minX, bestDetail, peak, bestGap);
}

double _largestGap(List<double> coverage) {
  final sorted = [...coverage]..sort();
  var largest = 0.0;
  for (var i = 0; i < sorted.length - 1; i++) {
    final gap = sorted[i + 1] - sorted[i];
    if (gap > largest) {
      largest = gap;
    }
  }
  return largest;
}

double _segmentCutoff(List<double> coverage) {
  final sorted = [...coverage]..sort();
  var largestGap = 0.0;
  var gapAfter = 0;
  for (var i = 0; i < sorted.length - 1; i++) {
    final gap = sorted[i + 1] - sorted[i];
    if (gap > largestGap) {
      largestGap = gap;
      gapAfter = i;
    }
  }
  if (largestGap >= 0.22) {
    return (sorted[gapAfter] + sorted[gapAfter + 1]) / 2;
  }
  return 0.55;
}

int _boxPeak(Uint8List score, int imageWidth, _Comp box) {
  var peak = 0;
  for (var y = box.minY; y <= box.maxY; y++) {
    final row = y * imageWidth;
    for (var x = box.minX; x <= box.maxX; x++) {
      if (score[row + x] > peak) {
        peak = score[row + x];
      }
    }
  }
  return peak;
}

double _coverage(
  Uint8List score,
  int imageWidth,
  _Comp box,
  int localThreshold,
  double x0,
  double y0,
  double x1,
  double y1, {
  required bool horizontal,
}) {
  final imageHeight = score.length ~/ imageWidth;
  final left = (box.minX + box.width * x0).floor().clamp(0, imageWidth - 1);
  final right = (box.minX + box.width * x1).ceil().clamp(0, imageWidth - 1);
  final top = (box.minY + box.height * y0).floor().clamp(0, imageHeight - 1);
  final bottom = (box.minY + box.height * y1).ceil().clamp(0, imageHeight - 1);
  if (right < left || bottom < top) {
    return 0;
  }

  if (horizontal) {
    var hits = 0;
    // Horizontal strokes on a white display are only a couple of pixels thick,
    // so one lit pixel in the column is enough to count the stroke.
    const need = 1;
    for (var x = left; x <= right; x++) {
      var lit = 0;
      for (var y = top; y <= bottom; y++) {
        if (score[y * imageWidth + x] >= localThreshold) {
          lit++;
        }
      }
      if (lit >= need) {
        hits++;
      }
    }
    return hits / (right - left + 1);
  }

  var hits = 0;
  final span = right - left + 1;
  final need = math.max(1, (span * 0.18).ceil());
  for (var y = top; y <= bottom; y++) {
    var lit = 0;
    final row = y * imageWidth;
    for (var x = left; x <= right; x++) {
      if (score[row + x] >= localThreshold) {
        lit++;
      }
    }
    if (lit >= need) {
      hits++;
    }
  }
  return hits / (bottom - top + 1);
}

const Map<String, String> _patterns = {
  '1111110': '0',
  '0110000': '1',
  '0000110': '1',
  '1101101': '2',
  '1111001': '3',
  '0110011': '4',
  '1011011': '5',
  '1011111': '6',
  '1110000': '7',
  '1111111': '8',
  '1111011': '9',
  // A 9 whose bottom bar is faint, and a 6 whose top bar is faint.
  '1110011': '9',
  '0011111': '6',
};

String? _matchPattern(String bits) {
  final exact = _patterns[bits];
  if (exact != null) {
    return exact;
  }
  String? nearest;
  var nearestDistance = 3;
  var tied = false;
  _patterns.forEach((pattern, digit) {
    var distance = 0;
    for (var i = 0; i < 7; i++) {
      if (pattern[i] != bits[i]) {
        distance++;
      }
    }
    if (distance < nearestDistance) {
      nearestDistance = distance;
      nearest = digit;
      tied = false;
    } else if (distance == nearestDistance && digit != nearest) {
      tied = true;
    }
  });
  if (nearestDistance == 1 && !tied) {
    return nearest;
  }
  return null;
}

class _Hit {
  const _Hit(this.text, this.bandHeight, this.fraction, this.gap);

  final String text;
  final int bandHeight;
  final double fraction;
  final double gap;
}

class _Band {
  const _Band(this.minY, this.maxY);

  final int minY;
  final int maxY;

  int get height => maxY - minY + 1;
}

class _Comp {
  const _Comp({
    required this.minX,
    required this.minY,
    required this.maxX,
    required this.maxY,
    required this.area,
    required this.sumV,
  });

  final int minX;
  final int minY;
  final int maxX;
  final int maxY;
  final int area;
  final int sumV;

  int get width => maxX - minX + 1;
  int get height => maxY - minY + 1;
  double get cy => (minY + maxY) / 2;
  double get mean => sumV / area;
  double get fill => area / (width * height);
}
