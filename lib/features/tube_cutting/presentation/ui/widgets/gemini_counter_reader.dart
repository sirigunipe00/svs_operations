import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image/image.dart' as img;
import 'package:svs_operations/core/consts/api_keys.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/counter_reader.dart';

class GeminiCounterResult {
  final String? reading;
  final String? error;
  final bool isInvalid;

  const GeminiCounterResult({
    this.reading,
    this.error,
    this.isInvalid = false,
  });
}

/// Service that utilizes Google Gemini Vision AI to read industrial counter displays
/// with high accuracy, fast validation, and immediate rejection of non-counter images.
class GeminiCounterReader {
  static const String _prompt = '''
You are an expert industrial OCR meter reading system.
Your job is to read dedicated physical 7-segment digital machine counter meters (e.g. SELEC XC 22B, Etsilon CNT701, Autonics).

CRITICAL EXTRACTION RULES:
1. Is this a physical 7-segment digital machine counter meter?
   If NO (for example: it is a computer monitor, graphical touchscreen/HMI, CNC display screen, paper, floor, or unrelated machinery), reply ONLY with: INVALID_IMAGE
2. Read ONLY the actively illuminated (GLOWING RED/CYAN/WHITE) digits on the 7-segment LED display.
3. CRITICAL RULE FOR UNLIT LEADING DIGITS:
   - Inactive/unlit digit positions appear as faint dark gray or black '8's etched on the glass.
   - THEY ARE POWERED OFF. DO NOT READ THEM AS '8'!
   - For example: if position 1 is dark/unlit and positions 2, 3, 4 are glowing '1', '2', '4', the reading is 124 (NEVER 8124).
   - If position 1 is dark and positions 2, 3, 4 are glowing '1', '2', '8', the reading is 128 (NEVER 8128).
   - If positions 1 & 2 are dark and positions 3, 4 are glowing '3', '3', the reading is 33 (NEVER 8833).
   - If positions 1 & 2 are dark and positions 3, 4 are glowing '2', '8', the reading is 28 (NEVER 8828).
   - A segment is ONLY lit if it emits active bright glowing colored light.
4. Ignore preset dials/thumbwheels below (such as 5000 or 8000).
5. Ignore printed labels/text (such as SELEC, XC 22B, RST, RLY).
6. Output ONLY the raw active digits as a plain number (e.g. 124, 128, 132, 208, 33, 28, 2080, 234).
7. If the display is dark, blank, unreadable, or no lit counter digits are found, reply ONLY with: INVALID_IMAGE
''';

  static const List<String> _candidateModels = [
    'gemini-3.5-flash-lite',
    'gemini-3.5-flash',
    'gemini-flash-latest',
  ];

  /// Reads the counter value from [imageBytes] using Gemini Vision AI.
  static Future<String?> readCounter(Uint8List imageBytes) async {
    final result = await readCounterResult(imageBytes);
    return result.reading;
  }

  /// Full result including error reason and invalid-image detection.
  static Future<GeminiCounterResult> readCounterResult(
      Uint8List imageBytes) async {
    final apiKey = ApiKeys.geminiApiKey;

    if (apiKey.isNotEmpty) {
      final optimizedBytes = _optimizeImageForVision(imageBytes);

      for (final modelName in _candidateModels) {
        try {
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

          // 6-second timeout per model to prevent long hangs
          final response = await model
              .generateContent(content)
              .timeout(const Duration(seconds: 6));

          final rawText = response.text?.trim() ?? '';

          final upper = rawText.toUpperCase();
          if (upper.contains('INVALID') ||
              upper.contains('NONE') ||
              rawText.isEmpty) {
            return const GeminiCounterResult(
              isInvalid: true,
              error:
                  'Invalid or non-detectable image. Please take a clear photo of the 7-segment machine counter meter.',
            );
          }

          final cleaned = _sanitizeReading(rawText);
          if (cleaned != null && cleaned.isNotEmpty) {
            return GeminiCounterResult(reading: cleaned);
          }

          // If the model replied with text but no digits were extracted
          return const GeminiCounterResult(
            isInvalid: true,
            error:
                'No counter numbers detected. Please take a valid photo of the machine counter.',
          );
        } on TimeoutException {
          log('GeminiCounterReader ($modelName) timed out after 6s. Trying next...');
          continue;
        } catch (e) {
          log('GeminiCounterReader ($modelName) network/API error: $e');
          // Only retry if network / server issue
          continue;
        }
      }
      log('GeminiCounterReader: All Gemini models failed due to network/API.');
    } else {
      log('GeminiCounterReader: No Gemini API key configured.');
    }

    // Only fallback to local CV if offline or no API key configured
    try {
      log('GeminiCounterReader: Running fast local fallback...');
      final localResult = decodeCounter(imageBytes);
      if (localResult.value != null && localResult.value!.isNotEmpty) {
        return GeminiCounterResult(reading: localResult.value);
      }
    } catch (e) {
      log('GeminiCounterReader: Local fallback error: $e');
    }

    return const GeminiCounterResult(
      isInvalid: true,
      error:
          'No counter reading detected. Please take a valid photo of the machine counter.',
    );
  }

  /// Cleans the LLM output to strictly extract digits.
  static String? _sanitizeReading(String raw) {
    if (raw.isEmpty) return null;
    final upper = raw.toUpperCase();
    if (upper.contains('NONE') || upper.contains('INVALID')) return null;

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
    if (bytes.lengthInBytes <= 400 * 1024) {
      return bytes;
    }

    try {
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return bytes;

      final baked = img.bakeOrientation(decoded);
      final maxDim = baked.width > baked.height ? baked.width : baked.height;

      if (maxDim <= 1280) {
        return Uint8List.fromList(img.encodeJpg(baked, quality: 80));
      }

      final resized = baked.width >= baked.height
          ? img.copyResize(baked,
              width: 1280, interpolation: img.Interpolation.linear)
          : img.copyResize(baked,
              height: 1280, interpolation: img.Interpolation.linear);

      return Uint8List.fromList(img.encodeJpg(resized, quality: 80));
    } catch (_) {
      return bytes;
    }
  }
}
