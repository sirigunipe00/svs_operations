import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:svs_operations/widgets/dialogs/panara_confirm_widget.dart';
import 'package:flutter/material.dart';


enum DialogType { success, normal, error, confirmRetry }

class AppDialog {
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required String content,
    required VoidCallback onTapOkay,
    DialogType type = DialogType.normal,
    String buttonText = 'Okay',
    bool barrierDismissible = true,
  }) async =>
      await showGeneralDialog<T?>(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierLabel: 'Dialog',
        useRootNavigator: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return _DialogWidget(
            title: title,
            content: content,
            buttonText: buttonText,
            onTapDismiss: onTapOkay,
            dialogType: type,
          );
        },
      );

  static Future showErrorDialog(
    BuildContext context, {
    String? title,
    required String content,
    required VoidCallback onTapDismiss,
    bool barrierDismissible = true,
  }) async =>
      await showGeneralDialog(
        context: context,
        barrierLabel: 'ErrorDialog',
        useRootNavigator: true,
        barrierDismissible: barrierDismissible,
        pageBuilder: (context, animation, secondaryAnimation) {
          return _DialogWidget(
            title: title,
            content: content,
            buttonText: 'Cancel',
            onTapDismiss: onTapDismiss,
            dialogType: DialogType.error,
          );
        },
      );

  static Future<T?> showSuccessDialog<T>(
    BuildContext context, {
    String? title,
    required String content,
    required VoidCallback onTapDismiss,
    String buttonText = 'Okay',
    bool barrierDismissible = true,
  }) async =>
      await showGeneralDialog<T>(
        context: context,
        barrierLabel: 'SuccessDialog',
        useRootNavigator: true,
        barrierDismissible: barrierDismissible,
        pageBuilder: (context, animation, secondaryAnimation) {
          return _DialogWidget(
            title: title,
            content: content,
            buttonText: buttonText,
            onTapDismiss: onTapDismiss,
            dialogType: DialogType.success,
          );
        },
      );

  static Future<T?> askForConfirmation<T>(
    BuildContext context, {
    String? title,
    required String content,
    required VoidCallback onTapDismiss,
    String buttonText = 'Cancel',
    bool barrierDismissible = true,
    String confirmBtnText = 'Okay',
    required VoidCallback onTapConfirm,
  }) async =>
       await showGeneralDialog<T>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: barrierDismissible,
        barrierLabel: 'ConfirmationDialog',
        pageBuilder: (context, animation, secondaryAnimation) => PopScope(
          canPop: false,
          child: PanaraConfirmDialogWidget(
            title: title,
            message: content,
            cancelButtonText: buttonText,
            confirmButtonText: confirmBtnText,
            onTapCancel: onTapDismiss,
            onTapConfirm: onTapConfirm,
          ),
        ),
      );
}

class _DialogWidget extends StatelessWidget {
  const _DialogWidget({
    required this.content,
    required this.buttonText,
    required this.onTapDismiss,
    required this.dialogType,
    this.title,
  });

  final String? title;
  final String content;
  final String buttonText;
  final VoidCallback onTapDismiss;
  final DialogType dialogType;

  @override
  Widget build(BuildContext context) {
    final bgColor = dialogType == DialogType.success 
      ? AppColors.vibrantBlue 
      : AppColors.white;

    final textColor = dialogType == DialogType.success 
      ? AppColors.white 
      : AppColors.black;

    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 340),
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpacer.p8(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title.containsValidValue) ...[
                    Expanded(
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ] else...[const SizedBox.shrink()],
                  IconButton(
                    onPressed: onTapDismiss, 
                    icon: const Icon(Icons.close, color: AppColors.red),
                  ),
                ],
              ),
              if(dialogType != DialogType.success)...[
                const Divider(color: AppColors.grey, height: 1, thickness: 2),
              ],
              AppSpacer.p8(),
              _BulletPointWidget(content, textColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletPointWidget extends StatelessWidget {
  const _BulletPointWidget(this.messgae, this.textColor);

  final String messgae;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final isSuccess = textColor == Colors.white;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text( '\u2022',
          style: TextStyle(fontSize: 20, height: 1.15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            messgae.trim(),
            textAlign: isSuccess ? TextAlign.center : TextAlign.left,
            softWrap: true,
            style: TextStyle(
              fontSize: isSuccess ? 18 : 16,
              fontWeight: isSuccess ? FontWeight.bold : FontWeight.normal,
              color: textColor, height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}
