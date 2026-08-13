import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/caption_text.dart';
import 'package:svs_operations/widgets/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.title,
    this.initialValue,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.inputType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 255,
    this.readOnly = false,
    this.helperText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
    this.obscureText = false,
    TextEditingController? controller,
  }) {
    this.controller = controller ?? TextEditingController();
    if (initialValue?.isNotEmpty == true) {
      this.controller?.text = initialValue!;
    }
  }

  final String title;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputType inputType;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final bool readOnly;
  final String? helperText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  late final TextEditingController? controller;
  final bool autofocus;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(color: AppColors.haintBlue),
    );

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      defaultHeight: 4.0,
      children: [
        CaptionText(title: title,),
        TextField(
          style: AppTextStyles.titleMedium(context, AppColors.black),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: textFieldBorder,
            enabledBorder: textFieldBorder,
            focusedBorder: textFieldBorder,
            contentPadding: const EdgeInsets.all(16.0),
            suffix: suffixIcon,
            counterText: '',
          ),
          obscuringCharacter: '*',
          textInputAction: TextInputAction.done,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          keyboardType: inputType,
          minLines: minLines,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          textCapitalization: TextCapitalization.none,
          readOnly: readOnly,
          autocorrect: false,
          autofocus: autofocus,
        ),
      ],
    );
  }
}
