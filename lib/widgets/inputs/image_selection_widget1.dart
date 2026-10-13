import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/utils/attachment_selection_mixin.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/widgets.dart';

class ImageSelectionWidget1 extends StatefulWidget {
  const ImageSelectionWidget1({
    super.key,
    this.defaultVal,
    this.readOnly = false,
    this.isRequired = false,
    required this.onImage,
    required this.title,
    required this.placeholder,
    this.borderColor = AppColors.black,
    this.onView,
  });

  final String title;
  final bool readOnly;
  final bool isRequired;
  final Color borderColor;
  final String? defaultVal;
  final Function(File? file) onImage;
  final VoidCallback? onView;
  final Widget placeholder;

  @override
  State<ImageSelectionWidget1> createState() => _GateEntryImageWidget1State();
}

class _GateEntryImageWidget1State extends State<ImageSelectionWidget1>
    with AttahcmentSelectionMixin {
  File? _selectedImage;
 @override

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CaptionText(title: widget.title),
        AppSpacer.p4(),
        Stack(
          children: [
            GestureDetector(
            onTap: widget.defaultVal.containsValidValue || _selectedImage != null
    ? widget.onView
    : widget.readOnly
        ? null
        : () async {
            final capturedFile = await captureImage();
            if (capturedFile.isNull) return;

            // int fileSizeInBytes = await capturedFile!.length();
            // double fileSizeInKB = fileSizeInBytes / 1024;
            // double fileSizeInMB = fileSizeInKB / 1024;


            _selectedImage = capturedFile;
            widget.onImage(capturedFile);
            setState(() {});
          },

              child: Container(
                height: 100,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: context.sizeOfWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.black),
                  boxShadow: [
                    BoxShadow(
                      color: widget.borderColor,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: widget.defaultVal.containsValidValue
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: _isValidFile(),
                      )
                    : _selectedImage.isNull
                        ? widget.placeholder
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child:
                                Image.file(_selectedImage!, fit: BoxFit.cover),
                          ),
              ),
            ),
            if (_selectedImage != null ||
                widget.defaultVal.containsValidValue) ...[
              Positioned(
                right: 6,
                top: 6,
                child: Row(
                  children: [
                    if (!widget.readOnly) ...[
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                              widget.onImage(null);
                            });
                          },
                          icon: const Icon(Icons.clear, color: Colors.white),
                        ),
                      ),
                      AppSpacer.p4(),
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          onPressed: () async {
                            final capturedFile = await captureImage();
                            if (capturedFile.isNull) return;
                            _selectedImage = capturedFile;
                            widget.onImage(capturedFile);
                            setState(() {});
                          },
                          icon: const Icon(Icons.add_a_photo_outlined,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _isValidFile() {
    try {
      return Image.memory(base64Decode(widget.defaultVal!));
    } on Exception catch (_) {
      return const SizedBox();
    }
  }
}
