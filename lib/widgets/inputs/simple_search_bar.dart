import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleSearchBar extends StatefulWidget {
  const SimpleSearchBar({
    this.initial,
    required this.hintText,
    required this.onSearch,
    required this.onCancel,
    super.key,  this.inputType = TextInputType.number,
  });

  final String? initial;
  final String hintText;
  final Function(String) onSearch;
  final Function() onCancel;
  final TextInputType inputType;

  @override
  State<SimpleSearchBar> createState() => _SimpleSearchBarState();
}

class _SimpleSearchBarState extends State<SimpleSearchBar> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  void _onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
         FilteringTextInputFormatter.digitsOnly,
      ],
      controller: _controller,
      focusNode: _focusNode,
      onChanged: _onSearch,
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: 40, minHeight: 40),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(4.0),
        ),
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(4.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(4.0),
        ),
        suffixIcon: IconButton(
          key: const Key('clear-search'),
          onPressed: _clearField,
          icon: const Icon(Icons.clear),
        ),
      ),
      textInputAction: TextInputAction.search,
      maxLines: 1,
    );
  }

  void _clearField() {
    if (_controller.text.isNotEmpty) {
      widget.onCancel();
      _controller.clear();
      _focusNode.unfocus();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _controller.dispose();
  }
}
