import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:flutter/material.dart';


class ViewBtn extends StatelessWidget {
  const ViewBtn({super.key, this.onPressed});

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.liteBlack,
        visualDensity: VisualDensity.compact,
        side: const BorderSide(color: AppColors.liteBlack),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onPressed: onPressed, 
      child: Text('View', style: AppTextStyles.btnLabelStyle(context)),
    );
  }
}