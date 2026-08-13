import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/spaced_column.dart';
import 'package:svs_operations/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SimpleAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: AppTextStyles.titleLarge(context).copyWith(color: AppColors.black,fontWeight: FontWeight.bold),
      scrolledUnderElevation: 0.0,
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: AppColors.white,
      title: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: context.close, 
        icon: const CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.chimneySweep,
          child: Icon(Icons.arrow_back, color: AppColors.white),
        ),
      ),
      actions: [
        SpacedColumn(
          margin: const EdgeInsets.only(right: 12.0),
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(context.user.username, style: AppTextStyles.titleMediumBlack(context)),
            Text(DFU.currentTimeFormat(DateTime.now()), style: AppTextStyles.titleMediumBlack(context)),
          ],
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}