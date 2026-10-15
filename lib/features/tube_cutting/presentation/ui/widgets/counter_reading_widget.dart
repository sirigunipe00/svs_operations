
import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/gemini_counter_reader.dart';

class CounterReaderService {
  Future<CounterReadingResult> readFile(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final reading = await GeminiCounterReader.readCounter(bytes);

      log('CounterReaderService reading: $reading');

      if (reading == null) {
        return CounterReadingResult(
          imageBytes: bytes,
          error: 'No counter number found. Use a straight-on photo of the lit display.',
        );
      }

      return CounterReadingResult(
        imageBytes: bytes,
        reading: reading,
      );
    } catch (e, stack) {
      log('CounterReaderService error: $e\n$stack');
      return const CounterReadingResult(
        error: 'Could not read that image.',
      );
    }
  }
}

class CounterReadingResult {
  final Uint8List? imageBytes;
  final String? reading;
  final String? error;

  const CounterReadingResult({
    this.imageBytes,
    this.reading,
    this.error,
  });
}
