import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/spaced_column.dart';
import 'package:flutter/material.dart';

class CaptionText extends StatelessWidget {
  const CaptionText({super.key, required this.title, this.isRequired = true});

  final String title;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    if (title.doesNotHaveValue) return const SizedBox.shrink();

    return RichText(
      text: TextSpan(
        style: context.textTheme.titleSmall?.copyWith(color: AppColors.black, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: .5),
        children: [
          TextSpan(text: title),
          if(isRequired)...[
            const TextSpan(text: ' *', style: TextStyle(color: AppColors.red)),
          ],
          const TextSpan(text:  ' :'),
        ],
      ),
    );
  }
}


class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.section, required this.child});

  final String section;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        margin: const EdgeInsets.all(4.0),
        children: [
          Text(section, style: AppTextStyles.labelLarge(context).copyWith(color: AppColors.black)),
          child
        ],
      ),
    );
  }
}