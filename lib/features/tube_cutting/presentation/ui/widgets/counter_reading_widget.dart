import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/gemini_counter_reader.dart';

class CounterReaderService {
  Future<CounterReadingResult> readFile(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final result = await GeminiCounterReader.readCounterResult(bytes);

      log('CounterReaderService reading: ${result.reading}, error: ${result.error}');

      if (result.reading != null && result.reading!.isNotEmpty) {
        return CounterReadingResult(
          imageBytes: bytes,
          reading: result.reading,
        );
      }

      return CounterReadingResult(
        imageBytes: bytes,
        error: result.error ??
            'Invalid or non-detectable image. Please take a clear photo of the machine counter.',
        isInvalidImage: result.isInvalid,
      );
    } catch (e, stack) {
      log('CounterReaderService error: $e\n$stack');
      return const CounterReadingResult(
        error: 'Could not read image. Please take a valid photo.',
        isInvalidImage: true,
      );
    }
  }
}

class CounterReadingResult {
  final Uint8List? imageBytes;
  final String? reading;
  final String? error;
  final bool isInvalidImage;

  const CounterReadingResult({
    this.imageBytes,
    this.reading,
    this.error,
    this.isInvalidImage = false,
  });
}
