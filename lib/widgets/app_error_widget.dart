import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
      {super.key,
      required this.error,
      this.onRefresh,
      required this.isRefresh});

  final String error;
  final VoidCallback? onRefresh;
  final bool isRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isRefresh == true) ...[
          Text(
            'OOPS',
            style: AppTextStyles.errorStyle(context).copyWith(fontSize: 20),
          ),
        ],
        AppSpacer.p8(),
        Text(error,
            textAlign: TextAlign.center,
            style: AppTextStyles.errorStyle(context)),
        AppSpacer.p8(),
        if (isRefresh == true) ...[_RetryBtn(onRefresh: onRefresh)]
      ],
    );
  }
}

class _RetryBtn extends StatelessWidget {
  const _RetryBtn({this.onRefresh});

  final VoidCallback? onRefresh;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.haintBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.refresh_outlined, color: AppColors.white),
      onPressed: onRefresh,
      label: Text('RETRY', style: AppTextStyles.titleLarge(context)),
    );
  }
}
