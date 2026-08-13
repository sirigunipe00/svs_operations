import 'dart:convert';

import 'package:svs_operations/core/model/pair.dart';
import 'package:svs_operations/core/utils/utils.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScrn extends StatelessWidget {
  const ImagePreviewScrn({
    super.key,
    required this.base64,
    required this.title,
  });

  final String title;
  final String base64;

  static Widget fromPair(Pair<String, String?> data) {
    return ImagePreviewScrn(
      title: data.first,
      base64: data.second.valueOrEmpty,
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text(title)),
        body: Container(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: PhotoView(
            imageProvider: Image.memory(base64Decode(base64)).image,
            loadingBuilder: (context, event) {
              if (event == null) {
                return const Center(child: LoadingIndicator());
              }
              final value = event.cumulativeBytesLoaded /
                  (event.expectedTotalBytes ?? event.cumulativeBytesLoaded);

              final percentage = (100 * value).floor();
              return Center(child: Text('$percentage%'));
            },
          ),
        ),
      );
    } on Exception catch (_) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(
            child: Icon(Icons.local_shipping,
                size: 64, color: AppColors.chimneySweep)),
      );
    }
  }
}
