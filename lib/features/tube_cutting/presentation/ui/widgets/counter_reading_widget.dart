
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/counter_reader.dart';

// Import the file containing readCounterNumber.
// import '../utils/counter_reader.dart';

class CounterReaderService {
  Future<CounterReadingResult> readFile(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final reading = await compute(readCounterNumber, bytes);

      log('reading...:$reading');

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
    } catch (_) {
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
