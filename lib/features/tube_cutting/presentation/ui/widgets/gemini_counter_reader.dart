import 'dart:developer';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image/image.dart' as img;
import 'package:svs_operations/core/consts/api_keys.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/counter_reader.dart';

/// Service that utilizes Google Gemini Vision AI to read industrial counter displays
/// with high accuracy.
class GeminiCounterReader {
  static const String _prompt = '''
You are an expert industrial meter reading system.
Look at this industrial meter photo (such as SELEC XC 22B, Etsilon CNT701).

STRICT EXTRACTION RULES:
1. Locate the main illuminated digital 7-segment LED display.
2. Read ONLY the actively illuminated (bright glowing red/cyan/white) digits on that display.
3. CRITICAL: Unlit, blank, or dark digit positions can faintly show unlit segments in the dark glass (which look like faint dark gray '8's). DO NOT read unlit or dark digits! Omit them completely. For example, if the first two digits are dark and the last two are glowing '33', the answer is 33.
4. Ignore mechanical thumbwheels, rotary dials, or push-buttons (such as '5000' or '8000') below the display.
5. Ignore printed labels, brand names, and model numbers (such as SELEC, XC 22B, RST, RLY).
6. Output ONLY the raw active digits as a plain number (e.g. 128, 132, 208, 33, 28, 2080, 234, 1962, 2038).
7. Do NOT include any spaces, words, punctuation, explanation, or markdown formatting.
8. If the display is completely unreadable, dark, or no lit digital counter is visible, return 'NONE'.
''';

  static const List<String> _candidateModels = [
    'gemini-3.5-flash-lite',
    'gemini-3.5-flash',
    'gemini-flash-latest',
    'gemini-1.5-flash',
  ];

  /// Reads the counter value from [imageBytes] using Gemini Vision AI.
  ///
  /// Falls back to local [decodeCounter] if Gemini is unavailable, offline,
  /// or if no API key is configured.
  static Future<String?> readCounter(Uint8List imageBytes) async {
    final apiKey = ApiKeys.geminiApiKey;

    if (apiKey.isNotEmpty) {
      final optimizedBytes = _optimizeImageForVision(imageBytes);

      for (final modelName in _candidateModels) {
        try {
          log('GeminiCounterReader: Trying model $modelName...');
          final model = GenerativeModel(
            model: modelName,
            apiKey: apiKey,
            generationConfig: GenerationConfig(
              temperature: 0.0,
              maxOutputTokens: 20,
            ),
          );

          final content = [
            Content.multi([
              TextPart(_prompt),
              DataPart('image/jpeg', optimizedBytes),
            ]),
          ];

          final response = await model.generateContent(content);
          final rawText = response.text?.trim() ?? '';
          log('GeminiCounterReader ($modelName): Raw response = "$rawText"');

          final cleaned = _sanitizeReading(rawText);
          if (cleaned != null && cleaned.isNotEmpty) {
            log('GeminiCounterReader ($modelName): Succeeded with $cleaned');
            return cleaned;
          }
        } catch (e) {
          log('GeminiCounterReader ($modelName) failed: $e. Trying next model...');
          continue;
        }
      }
      log('GeminiCounterReader: All Gemini models failed or returned empty.');
    } else {
      log('GeminiCounterReader: No Gemini API key configured. Using local fallback.');
    }

    // Fallback to on-device heuristic counter reader
    try {
      log('GeminiCounterReader: Running local fallback decoder...');
      final localResult = decodeCounter(imageBytes);
      if (localResult.value != null && localResult.value!.isNotEmpty) {
        log('GeminiCounterReader: Local fallback succeeded with ${localResult.value}');
        return localResult.value;
      }
    } catch (e) {
      log('GeminiCounterReader: Local fallback error: $e');
    }

    return null;
  }

  /// Cleans the LLM output to strictly extract digits.
  static String? _sanitizeReading(String raw) {
    if (raw.isEmpty) return null;
    if (raw.toUpperCase().contains('NONE')) return null;

    // Remove any markdown code blocks, backticks, or extra whitespace
    var text = raw.replaceAll('`', '').trim();

    // Match the primary continuous digit string
    final match = RegExp(r'\b\d+\b').firstMatch(text);
    if (match != null) {
      return match.group(0);
    }

    // Fallback: strip all non-digits
    final digits = text.replaceAll(RegExp(r'\D'), '');
    return digits.isNotEmpty ? digits : null;
  }

  /// Downscales very large camera images to ~1280px to speed up network transmission
  /// while preserving high-contrast 7-segment details.
  static Uint8List _optimizeImageForVision(Uint8List bytes) {
    if (bytes.lengthInBytes <= 500 * 1024) {
      return bytes;
    }

    try {
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return bytes;

      final baked = img.bakeOrientation(decoded);
      final maxDim = baked.width > baked.height ? baked.width : baked.height;

      if (maxDim <= 1280) {
        return Uint8List.fromList(img.encodeJpg(baked, quality: 85));
      }

      final resized = baked.width >= baked.height
          ? img.copyResize(baked, width: 1280, interpolation: img.Interpolation.linear)
          : img.copyResize(baked, height: 1280, interpolation: img.Interpolation.linear);

      return Uint8List.fromList(img.encodeJpg(resized, quality: 85));
    } catch (_) {
      return bytes;
    }
  }
}
