import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/icons.dart';
import 'package:flutter/material.dart';
import 'package:svs_operations/widgets/widgets.dart';


class PanaraConfirmDialogWidget extends StatelessWidget {
  const PanaraConfirmDialogWidget({
    super.key,
    this.title,
    required this.message,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onTapConfirm,
    required this.onTapCancel,
  });

  final String? title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onTapConfirm;
  final VoidCallback onTapCancel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 340),
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   AppIcons.info.path,
              //   width: 84,
              //   height: 84,
              //   color: AppColors.vibrantBlue,
              // ),
              if (title != null)
                Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              if (title != null) const SizedBox(height: 5),
              Text(
                message,
                style: const TextStyle(
                  height: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: AppButton(
                      onPressed: onTapCancel,
                      label: cancelButtonText,
                      bgColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: AppButton(
                      onPressed: onTapConfirm,
                      label: confirmButtonText,
                      bgColor: const Color(0xFF179DFF),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
