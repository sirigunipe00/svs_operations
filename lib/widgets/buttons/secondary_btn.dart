import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:flutter/material.dart';


class SecondaryBtn extends StatelessWidget {
  const SecondaryBtn({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.white.withOpacity(0.6),
        visualDensity: VisualDensity.compact,
        side: const BorderSide(color: AppColors.white),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: AppTextStyles.titleLarge(context).copyWith(color: AppColors.black)
      ),
      onPressed: onPressed, 
      icon: const Icon(Icons.add), 
      label: Text(label),
    );
  }
}