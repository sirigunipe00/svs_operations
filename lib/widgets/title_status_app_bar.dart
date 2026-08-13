import 'package:flutter/material.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:svs_operations/widgets/doc_status_widget.dart';

enum DocNoAlignment { vertical, horizontal }

class TitleStatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleStatusAppBar({
    super.key,
    this.title = '',
    required this.docNo,
    required this.status,
    required this.textColor,
    this.alignment = DocNoAlignment.horizontal,
  });

  final String title;
  final String docNo;
  final String status;
  final Color textColor;
  final DocNoAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      scrolledUnderElevation: 0.0,
      titleSpacing: 0,
      centerTitle: false,
      title: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (title.containsValidValue) ...[
                  Text(title,
                      style: AppTextStyles.titleLarge(context)
                          .copyWith(color: AppColors.black)),
                ],
                if (alignment == DocNoAlignment.horizontal) ...[
                  AppSpacer.p8(),
                  Text('($docNo)',
                      style: AppTextStyles.titleMedium(context, textColor)),
                ]
              ],
            ),
            if (alignment == DocNoAlignment.vertical) ...[
              Text('($docNo)',
                  style: AppTextStyles.titleMedium(context, textColor)),
            ]
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: context.close,
        icon: const CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.chimneySweep,
          child: Icon(Icons.arrow_back, color: AppColors.white, size: 18),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: DocStatusWidget(status: status),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
