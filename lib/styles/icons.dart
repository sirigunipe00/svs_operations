import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';

class AppIcons {
  static const basePath = 'assets';
  static const imagesPath = '$basePath/images';
  static const iconsPath = '$basePath/icons';
  static const info = AppIcon('$iconsPath/info.png');
  static const confirm = AppIcon('$iconsPath/confirm.png');

  static const aparnaLogo = AppIcon('$basePath/images/svs_logo.png');
  static const easycloudLogo = AppIcon('$basePath/images/easycloud_logo.jpeg');

  static const tubeCutting = AppIcon('$iconsPath/tube_cutting.png');
  static const meshInsertion = AppIcon('$iconsPath/mesh_insertion.png');

  static const molecularIcon = AppIcon('$iconsPath/molecular.png');
  static const qtyInspection = AppIcon('$iconsPath/qty_inspection.png');
  static const spinningIcon = AppIcon('$iconsPath/spinning.png');
  static const brazingIcon = AppIcon('$iconsPath/brazing.png');
  static const vaccumePacking = AppIcon('$iconsPath/vaccum_packing.png');
  static const visualInspection = AppIcon('$iconsPath/visual_inspection.png');
}

class AppIcon {
  const AppIcon(this.path);

  final String path;

  Widget toWidget({
    double width = 30,
    double height = 30,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    final fileextension = extension(path);
    if (fileextension == '.svg') {
      return SvgPicture.asset(path,
          width: width, height: height, color: color, fit: fit);
    }
    return Image.asset(path,
        width: width, height: height, color: color, fit: fit);
  }
}
