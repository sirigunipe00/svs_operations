import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/app_text_styles.dart';
import 'package:svs_operations/widgets/widgets.dart';

class AppDropDownWidget<T> extends StatefulWidget {
  const AppDropDownWidget({
    super.key,
    this.title,
    this.hint,
    required this.items,
    required this.onSelected,
    this.defaultSelection,
    this.isMandatory = false,
    this.readOnly = false,
    this.listItemBuilder,
    this.headerBuilder,
    this.futureRequest,
  });

  final String? title;
  final String? hint;
  final List<T> items;
   final HeaderBuilder<T>? headerBuilder;
  final Future<List<T>> Function(String)? futureRequest;
  final Widget Function(BuildContext, T, bool, void Function())?
      listItemBuilder;
  final T? defaultSelection;
  final bool isMandatory;
  final bool readOnly;
  final dynamic Function(T? item)? onSelected;

  @override
  State<AppDropDownWidget<T>> createState() => _AppDropDownWidgetState<T>();
}

class _AppDropDownWidgetState<T> extends State<AppDropDownWidget<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultSelection;
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.readOnly,
      child: Column(
        key: widget.key,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.title.containsValidValue) ...[
            CaptionText(title: widget.title!, isRequired: widget.isMandatory),
          ],
          const SizedBox(height: 4),
          CustomDropdown<T>.searchRequest(
            decoration: CustomDropdownDecoration(
              hintStyle: AppTextStyles.titleLarge(context)
                  .copyWith(color: AppColors.black),
              closedBorder: Border.all(width: 0.8),
              expandedBorder: Border.all(width: 0.8),
              closedShadow: [
                const BoxShadow(
                  color: AppColors.marigoldDDust,
                  blurRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            futureRequest: widget.futureRequest,
            hintText: widget.hint,
            items: widget.items,
            headerBuilder: widget.headerBuilder,
            listItemBuilder: widget.listItemBuilder,
            onChanged: widget.onSelected,
            initialItem: _selectedValue,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
