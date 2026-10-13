import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

mixin AttahcmentSelectionMixin {
  Future<File?> captureImage() async {
    final XFile? selectedXFile =
        await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 70);
    if (selectedXFile != null) return File(selectedXFile.path);
    return null;
  }

  Future<File?> selectImageFromGallery() async {
    final XFile? selectedXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedXFile != null) return File(selectedXFile.path);
    return null;
  }

  Future<File?> selectImageFromLocal() async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      withReadStream: true,
      allowMultiple: false,
      allowedExtensions: <String>["jpg", "png", "jpeg"],
    );
    if (pickerResult != null && pickerResult.files.isNotEmpty) {
      final file = pickerResult.files.first;
      return File(file.path!);
    }
    return null;
  }
}
