import 'dart:io';

import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/utils/attachment_selection_mixin.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/caption_text.dart';
import 'package:svs_operations/widgets/spaced_column.dart';
import 'package:flutter/material.dart';

class ImageSelectionWidget extends StatefulWidget {
  const ImageSelectionWidget({
    super.key,
    this.title,
    this.helperText,
    required this.onImage,
    this.height = 150,
    this.width = 150,
    this.initialValue,
    this.readOnly = false,
    this.icon,
  });

  final String? title;
  final String? helperText;
  final Function(File? file) onImage;
  final double height;
  final double width;
  final String? initialValue;
  final bool readOnly;
  final Widget? icon;

  @override
  State<ImageSelectionWidget> createState() => _ImageSelectionWidgetState();
}

class _ImageSelectionWidgetState extends State<ImageSelectionWidget>
    with AttahcmentSelectionMixin {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      defaultHeight: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CaptionText(title: widget.title.valueOrEmpty),
        if(widget.helperText.containsValidValue)...[
          Text(widget.helperText.valueOrEmpty, 
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        AbsorbPointer(
          absorbing: widget.readOnly,
          child: Stack(
            children: [
              if (_selectedImage.isNull &&
                  widget.initialValue.doesNotHaveValue) ...[
                GestureDetector(
                  onTap: _selectFile,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.black, width: 0),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Stack(
                          children: [
                            if (widget.icon.isNotNull) ...[
                              Align(
                                alignment: Alignment.center,
                                child: widget.icon,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  height: widget.height,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.black, width: 0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blue,
                        blurRadius: 0.8,
                        offset: Offset(4, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: _selectedImage.isNotNull
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(_selectedImage!.readAsBytesSync(),
                            fit: BoxFit.cover),
                      )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(Urls.filepath(widget.initialValue!)),
                      ),
                ),
              ],
            ],
          ),
        ),
        
      ],
    );
  }

  Future<void> _selectFile() async {
    final capturedFile = await captureImage();
    if (capturedFile.isNull) return;
    setState(() {
      _selectedImage = capturedFile;
    });
    widget.onImage(capturedFile);
  }
}
