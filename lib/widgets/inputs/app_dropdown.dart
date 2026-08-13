import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:svs_operations/core/ext/context_ext.dart';
import 'package:svs_operations/core/utils/typedefs.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/caption_text.dart';
import 'package:svs_operations/widgets/spaced_column.dart';
import 'package:flutter/material.dart';


class AppDropDown<T> extends StatefulWidget {
  const AppDropDown({
    super.key,
    this.hint,
    required this.items,
    required this.onSelected,
    this.defaultSelection,
    this.isMandatory = false,
    this.readOnly = false,
    this.listItemBuilder,
    this.headerBuilder,
    this.hintBuilder,
    required this.title,
    this.borderColor,
  });
  final String? hint;
  final List<T> items;
  final HeaderBuilder<T>? headerBuilder;
  final Widget Function(BuildContext, T, bool, void Function())?
      listItemBuilder;
  final T? defaultSelection;
  final bool isMandatory;
  final bool readOnly;
  final String title;
  final void Function(T?) onSelected;
  final HintBuilder? hintBuilder;

  final Color? borderColor;
  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.items.contains(widget.defaultSelection)) {
      _selectedValue = widget.defaultSelection;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      defaultHeight: 4.0,
      children: [
        CaptionText(title: widget.title, isRequired: widget.isMandatory),
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.white, width: 0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.aztecAura,
                blurRadius: 0.8,
                offset: Offset(4, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: AbsorbPointer(
            absorbing: widget.readOnly,
            child: CustomDropdown<T>(
              canCloseOutsideBounds: true,
              hideSelectedFieldWhenExpanded: true,
              excludeSelected: false,
              closedHeaderPadding: const EdgeInsets.all(16.0),
              expandedHeaderPadding: const EdgeInsets.all(16.0),
              decoration: CustomDropdownDecoration(
                closedSuffixIcon: const Icon(Icons.arrow_drop_down),
                closedBorderRadius: BorderRadius.circular(8.0),
                expandedBorderRadius: BorderRadius.circular(8.0),
                closedBorder: Border.all(width: 0.4),
                expandedBorder: Border.all(width: 0.4),
                hintStyle: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.bold),
              ),
              hintText: widget.hint,
              items: widget.items,
              hintBuilder: widget.hintBuilder,
              headerBuilder: widget.headerBuilder,
              listItemBuilder: widget.listItemBuilder,
              onChanged: widget.onSelected,
              initialItem: _selectedValue,
            ),
          ),
        ),
      ],
    );
  }
}
