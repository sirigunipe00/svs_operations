import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/app_spacer.dart';
import 'package:svs_operations/widgets/caption_text.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';


class SearchDropDownList<T> extends StatefulWidget {
  const SearchDropDownList({
    super.key,
    this.title,
    this.hint,
    required this.items,
    required this.onSelected,
    this.defaultSelection,
    this.isMandatory = false,
    this.readOnly = false,
    this.isloading = false,
    this.listItemBuilder,
    this.headerBuilder,
    this.futureRequest,
    this.hintBuilder,
    this.closedFillColor, this.focusNode, required this.color,

  });

  final String? title;
  final String? hint;
  final List<T> items;
  final HeaderBuilder<T>? headerBuilder;
  final ListItemBuilder<T>? listItemBuilder;
  final HintBuilder? hintBuilder;
  final Future<List<T>> Function(String)? futureRequest;
  final T? defaultSelection;
  final bool isMandatory;
  final bool readOnly;
  final bool isloading;
    final Color color;

  final Color? closedFillColor;
  final void Function(T item) onSelected;
  final FocusNode? focusNode;

  @override
  State<SearchDropDownList<T>> createState() => _SearchDropDownListState<T>();
}

class _SearchDropDownListState<T> extends State<SearchDropDownList<T>> {
  T? _selectedValue;
  final scrollCtlr = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultSelection;
  }
  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title.containsValidValue)...[
            CaptionText(title: widget.title.valueOrEmpty, isRequired: widget.isMandatory),
            AppSpacer.p4(),
          ],
          AbsorbPointer(
            absorbing: widget.readOnly || widget.isloading,
            child: CustomDropdown<T>.searchRequest(
              hideSelectedFieldWhenExpanded: true,
              excludeSelected: false,
              closedHeaderPadding: const EdgeInsets.all(16.0),
              expandedHeaderPadding: const EdgeInsets.all(16.0),
              
              decoration: CustomDropdownDecoration(
                expandedFillColor: AppColors.white,
                closedSuffixIcon: widget.isloading ? const LoadingIndicator() : null,
                closedBorder: Border.all(width: 0.4),
                expandedBorder: Border.all(width: 0.4),
                closedBorderRadius: BorderRadius.circular(8.0),
                expandedBorderRadius: BorderRadius.circular(8.0),
                closedFillColor: AppColors.white,
                hintStyle: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.black, 
                  fontWeight: FontWeight.w500,
                ),
                closedShadow: [
                  BoxShadow(
                    color: widget.color,
                    blurRadius: 2,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              listItemPadding: const EdgeInsets.all(4.0),
              hintBuilder: widget.hintBuilder,
              futureRequest: widget.futureRequest,
              hintText: widget.hint,
              items: widget.items,
              headerBuilder: widget.headerBuilder,
              listItemBuilder: widget.listItemBuilder,
              onChanged: (p0) {
                if(p0 == null) return;
                widget.onSelected(p0);
              },
              initialItem: _selectedValue,
            ),
          ),
          AppSpacer.p4(),
        ],
      ),
    );
  }
}
