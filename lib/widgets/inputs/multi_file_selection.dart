import 'dart:io';

import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/utils/attachment_selection_mixin.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/caption_text.dart';
import 'package:svs_operations/widgets/inputs/photo_selection_widget.dart';
import 'package:svs_operations/widgets/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class MultiFileSelectionWidget extends StatefulWidget {
  const MultiFileSelectionWidget({
    super.key,
    this.title,
    this.helperText,
    required this.onImage,
    this.readOnly = false,
    this.height = 150,
    this.width = 150,
    this.focusNode,
    this.initialValue = const [],
    this.icon,
    required this.borderColor, 
    required this.removeFile,
    required this.initialFiles,
  });

  final String? title;
  final FocusNode? focusNode;
  final String? helperText;
  final Function(File files) onImage;
  final Function(int index) removeFile;
  final double height;
  final double width;
  final Color borderColor;
  final List<String> initialValue;
  final List<File> initialFiles;
  final bool readOnly;
  final Widget? icon;

  @override
  State<MultiFileSelectionWidget> createState() =>
      _MultiFileSelectionWidgetState();
}

class _MultiFileSelectionWidgetState extends State<MultiFileSelectionWidget>
    with AttahcmentSelectionMixin {
  final _selectedImages = <File>[];

  @override
  void initState() {
    super.initState();
    _selectedImages..addAll(widget.initialFiles)..toSet()..toList();
  }
  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      defaultHeight: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CaptionText(title: widget.title.valueOrEmpty),
        if (widget.helperText.containsValidValue) ...[
          Text(
            widget.helperText.valueOrEmpty,
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        Focus(
          focusNode: widget.focusNode,
          child: Container(
            height: 48,
            width: context.sizeOfWidth,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: widget.borderColor, width: 1),
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: [
                BoxShadow(
                  color: widget.borderColor,
                  blurRadius: 2,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: widget.readOnly 
                    ? null : () async => await _capture(),
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 24,
                    color: widget.readOnly 
                      ? AppColors.grey : widget.borderColor,
                  ),
                ),
                if (widget.initialValue.isNotEmpty ||
                    _selectedImages.isNotEmpty) ...[
                  Positioned(
                    right: 8.0,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.himlayaPeeks,
                      ),
                      onPressed: _showImageDialog,
                      child: Text('VIEW', 
                        style: context.textTheme.labelLarge?.copyWith(
                          color: AppColors.vibrantBlue,
                          fontWeight: FontWeight.bold,
                          decorationStyle: TextDecorationStyle.dashed
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          title: const Text("Invoice Images"),
          content: _InvoiceImagesListView(
            files: _selectedImages, 
            urls: widget.initialValue, 
            removeFile: (index) {
              setState(() {
                _selectedImages.removeAt(index);
              });
              widget.removeFile(index);
            },
          ),
        );
      },
    );
  }

  Future<void> _capture() async {
    final index = [..._selectedImages, ...{widget.initialValue}].length;
    final capturedFile = await captureImage();
    if (capturedFile != null) {
      final directoryPath = capturedFile.parent.path;
      final exten = path.extension(capturedFile.path);
      final newFileName = 'Invoice_DC_Image_$index$exten';
      final newPath = path.join(directoryPath, newFileName);
      final renamedFile = await capturedFile.rename(newPath);
      setState(() {
        _selectedImages.add(renamedFile);
      });
      widget.onImage(renamedFile);
    }
  }
}


class _InvoiceImagesListView extends StatefulWidget {
  const _InvoiceImagesListView({
    required this.files, 
    required this.urls, 
    required this.removeFile,
  });

  final List<File> files;
  final List<String> urls;
  final Function(int index) removeFile;

  @override
  State<_InvoiceImagesListView> createState() => __InvoiceImagesListViewState();
}

class __InvoiceImagesListViewState extends State<_InvoiceImagesListView> {
  final images = [];

  @override
  void initState() {
    super.initState();
    images.addAll([...widget.files, ...widget.urls]);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: images.map((image) {
          final imageName = image is File
            ? image.path.split('/').last
            : image.toString().split('/').last;
          final indx = image is File 
            ? widget.files.indexOf(image) 
            : 0;
            
          return Container(
            padding: const EdgeInsets.all(0),
            height: 45,
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey.withOpacity(0.3)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              onTap: () {
                context
                  ..exit()
                  ..goToPage(ImagePreviewPage(
                    image: image is File ? image : null,
                    imageUrl: image is String ? image : null,
                    title: imageName,
                  ));
              },
              contentPadding: const EdgeInsets.only(left: 8.0),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image is File
                    ? _buildImage(image)
                    : _buildNetworkImage(image),
                ),
              ),
              title: Text(
                imageName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.black,
                ),
                maxLines: 1,
              ),
              trailing: image is File 
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        images.remove(image);
                      });
                      widget.removeFile(indx);
                      if(images.isEmpty) context.exit();
                    },
                    icon: const Icon(Icons.delete_outline, color: AppColors.red),
                  )
                : null,
            ),
          );
        }).toList(),
      ),
    );
  }

  Image _buildNetworkImage(image) {
    return Image.network(Urls.filepath(image.toString()), width: 50, height: 50, fit: BoxFit.cover);
  }

  Image _buildImage(File image) => Image.file(image, width: 50, height: 50, fit: BoxFit.cover);
}