import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.margin,
    required this.label,
    this.bgColor = AppColors.haintBlue,
    this.isLoading = false,
    this.onPressed,
    this.textStyle,
    this.icon = const SizedBox(),
  });

  final String label;
  final bool isLoading;
  final Color bgColor;
  final Widget icon;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final btnLabelStyle = textStyle ?? AppTextStyles.btnLabelStyle(context);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ElevatedButton.icon(
        icon: icon,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          fixedSize: Size.fromWidth(context.sizeOfWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: const EdgeInsets.all(14.0),
        ),
        onPressed: isLoading ? null : onPressed,
        label: isLoading
            ? const LoadingIndicator()
            : Text(label, style: btnLabelStyle),
      ),
    );
  }
}
