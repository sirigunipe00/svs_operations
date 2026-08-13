import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:flutter/material.dart';


abstract class AppTextStyles {
  static TextStyle featureLabelStyle(BuildContext context) => titleLarge(context).copyWith(
    fontSize: 20,
    color: AppColors.black,
  );

  static TextStyle textEntryStyle(BuildContext context) => context.textTheme.titleMedium!.copyWith(
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontSize: 15
  );

  static TextStyle titleLarge(BuildContext context) => context.textTheme.titleMedium!.copyWith(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle labelLarge(BuildContext context) => context.textTheme.labelLarge!.copyWith(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle titleMedium(BuildContext context, Color color) => context.textTheme.titleSmall!.copyWith(
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle titleMediumBlack(BuildContext context) => titleMedium(context, AppColors.black);
  static TextStyle titleMediumWhite(BuildContext context) => titleMedium(context, AppColors.white);

  static TextStyle errorStyle(BuildContext context) => context.textTheme.labelMedium!.copyWith(
    fontWeight: FontWeight.bold,
    color: AppColors.red,
  );

  static TextStyle btnLabelStyle(BuildContext context) => context.textTheme.titleLarge!.copyWith(
      color: AppColors.white, 
      fontWeight: FontWeight.bold,
    );
}