
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:svs_operations/core/core.dart';
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

  final Widget Function(
    BuildContext,
    T,
    bool,
    void Function(),
  )? listItemBuilder;

  final T? defaultSelection;
  final bool isMandatory;
  final bool readOnly;
  final dynamic Function(T? item)? onSelected;

  @override
  State<AppDropDownWidget<T>> createState() =>
      _AppDropDownWidgetState<T>();
}

class _AppDropDownWidgetState<T>
    extends State<AppDropDownWidget<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultSelection;
  }

  @override
  void didUpdateWidget(covariant AppDropDownWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.defaultSelection != widget.defaultSelection) {
      _selectedValue = widget.defaultSelection;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.readOnly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.title.containsValidValue) ...[
            CaptionText(
              title: widget.title!,
              isRequired: widget.isMandatory,
            ),
          ],

          const SizedBox(height: 3),

          CustomDropdown<T>.searchRequest(
            decoration: CustomDropdownDecoration(
              closedFillColor: widget.readOnly
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFFF8FAFC),

              expandedFillColor: Colors.white,

              closedBorder: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.0,
              ),

              expandedBorder: Border.all(
                color: const Color(0xFF0284C7),
                width: 1.2,
              ),

              closedBorderRadius: BorderRadius.circular(10),
              expandedBorderRadius: BorderRadius.circular(10),

              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),

              headerStyle: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),

              closedShadow: const [],
            ),

            futureRequest: widget.futureRequest,
            hintText: widget.hint,
            items: widget.items,

            headerBuilder: widget.headerBuilder,
            listItemBuilder: widget.listItemBuilder,

            initialItem: _selectedValue,

            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });

              widget.onSelected?.call(value);
            },
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
