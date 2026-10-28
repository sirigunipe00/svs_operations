import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/utils/attachment_selection_mixin.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/dashed_border_box.dart';
import 'package:svs_operations/styles/app_colors.dart';

/// Common Gradient Header matching the modern design with concentric rings
class GateHeader extends StatelessWidget {
  const GateHeader({
    super.key,
    required this.title,
    this.onBack,
    this.showBackButton = true,
    this.tagText,
    this.searchWidget,
    this.filterWidget,
    this.trailing,
  });

  final String title;
  final VoidCallback? onBack;
  final bool showBackButton;
  final String? tagText;
  final Widget? searchWidget;
  final Widget? filterWidget;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF04244C),
            Color(0xFF06336D),
            Color(0xFF0E60B8),
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background concentric rings & circles
          Positioned(
            top: -140,
            right: -120,
            child: _circle(380, Colors.white.withOpacity(0.04)),
          ),
          Positioned(
            top: -100,
            right: -80,
            child: _circle(280, Colors.white.withOpacity(0.05)),
          ),
          Positioned(
            top: -60,
            right: -40,
            child: _circle(180, Colors.white.withOpacity(0.06)),
          ),
          Positioned(
            top: -140,
            right: -120,
            child: _ring(380, Colors.white.withOpacity(0.07)),
          ),
          Positioned(
            top: -100,
            right: -80,
            child: _ring(280, Colors.white.withOpacity(0.08)),
          ),

          // Content
          Padding(
            padding: EdgeInsets.only(
              top: topPadding + 8,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top row with Back button and Title
                Row(
                  children: [
                    if (showBackButton) ...[
                      GestureDetector(
                        onTap: onBack ?? () => Navigator.of(context).maybePop(),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    if (tagText.containsValidValue) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          tagText!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (trailing != null) trailing!,
                  ],
                ),

                // Search widget
                if (searchWidget != null) ...[
                  const SizedBox(height: 14),
                  searchWidget!,
                ],

                // Filter widget
                if (filterWidget != null) ...[
                  const SizedBox(height: 10),
                  filterWidget!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );

  Widget _ring(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.2),
        ),
      );
}

/// Translucent Pill Search Bar embedded in Header
class GateSearchBar extends StatefulWidget {
  const GateSearchBar({
    super.key,
    this.hintText = 'Search',
    this.initial,
    required this.onSearch,
    this.onClear,
  });

  final String hintText;
  final String? initial;
  final ValueChanged<String?> onSearch;
  final VoidCallback? onClear;

  @override
  State<GateSearchBar> createState() => _GateSearchBarState();
}

class _GateSearchBarState extends State<GateSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void didUpdateWidget(covariant GateSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initial == null || widget.initial!.isEmpty) {
      if (_controller.text.isNotEmpty) {
        _controller.clear();
        setState(() {});
      }
    } else if (widget.initial != _controller.text) {
      _controller.text = widget.initial!;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.28),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: Colors.white.withOpacity(0.75),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
              ),
              onSubmitted: (val) {
                setState(() {});
                widget.onSearch(val.trim().isEmpty ? null : val.trim());
              },
            ),
          ),
          if (_controller.text.isNotEmpty) ...[
            GestureDetector(
              onTap: () {
                _controller.clear();
                setState(() {});
                widget.onSearch(null);
                widget.onClear?.call();
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white.withOpacity(0.8),
                  size: 18,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Horizontal Status Filter Chips
class GateStatusFilterChips extends StatelessWidget {
  const GateStatusFilterChips({
    super.key,
    required this.statuses,
    required this.selectedStatus,
    required this.onSelected,
  });

  final List<String> statuses;
  final String? selectedStatus;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: statuses.map((status) {
          final isSelected = (selectedStatus == null && status == 'All') ||
              (selectedStatus?.toLowerCase() == status.toLowerCase());

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => onSelected(status),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF06336D)
                        : Colors.white.withOpacity(0.9),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Card Container with Numbered Badge Header (1 Vehicle, 2 Material, 3 Photos & remarks)
class GateSectionCard extends StatelessWidget {
  const GateSectionCard({
    super.key,
    required this.number,
    required this.title,
    required this.children,
    this.isMandatory = false,
  });

  final String number;
  final String title;
  final List<Widget> children;
  final bool? isMandatory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F172A),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with circular number badge
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F2FE),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Color(0xFF0284C7),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 6),
              if (isMandatory == true) ...[
                const Text(
                  '*',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.red,
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

/// Styled Input Field with Uppercase Label, prefix icon, and soft border
class GateInputField extends StatefulWidget {
  const GateInputField({
    super.key,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.readOnly = false,
    this.isRequired = false,
    this.inputFormatters,
    this.keyboardType,
    this.minLines,
    this.maxLines = 1,
  });

  final String label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;

  @override
  State<GateInputField> createState() => _GateInputFieldState();
}

class _GateInputFieldState extends State<GateInputField> {
  TextEditingController? _internalController;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController =
          TextEditingController(text: widget.initialValue ?? '');
    }
  }

  @override
  void didUpdateWidget(covariant GateInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null) {
      if (_internalController == null) {
        _internalController =
            TextEditingController(text: widget.initialValue ?? '');
      } else if (oldWidget.initialValue != widget.initialValue &&
          (widget.initialValue ?? '') != _internalController!.text) {
        _internalController!.text = widget.initialValue ?? '';
      }
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Color(0xFF64748B),
                ),
              ),
              if (widget.isRequired) ...[
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFDC2626),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _effectiveController,
            readOnly: widget.readOnly,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: widget.readOnly
                  ? const Color(0xFF64748B)
                  : const Color(0xFF0F172A),
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: widget.readOnly
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFFF8FAFC),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: widget.prefixIcon,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 38,
                minHeight: 38,
              ),
              suffixIcon: widget.suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF0284C7),
                  width: 1.2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Styled Date Picker Field
class GateDatePickerField extends StatefulWidget {
  const GateDatePickerField({
    super.key,
    required this.label,
    this.initialValue,
    this.hintText,
    this.readOnly = false,
    this.isRequired = false,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
  });

  final String label;
  final String? initialValue;
  final String? hintText;
  final bool readOnly;
  final bool isRequired;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<GateDatePickerField> createState() => _GateDatePickerFieldState();
}

class _GateDatePickerFieldState extends State<GateDatePickerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant GateDatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Color(0xFF64748B),
                ),
              ),
              if (widget.isRequired) ...[
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFDC2626),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: widget.readOnly ? null : _pickDate,
            child: AbsorbPointer(
              child: TextFormField(
                controller: _controller,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.readOnly
                      ? const Color(0xFF64748B)
                      : const Color(0xFF0F172A),
                ),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: widget.readOnly
                      ? const Color(0xFFF1F5F9)
                      : const Color(0xFFF8FAFC),
                  hintText: widget.hintText ?? 'Select date',
                  hintStyle: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xFF94A3B8),
                      size: 18,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 38,
                    minHeight: 38,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF0284C7),
                      width: 1.2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2020),
      lastDate:
          widget.lastDate ?? DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final formatted = DFU.friendlyFormat(picked);
      setState(() {
        _controller.text = formatted;
      });
      widget.onDateSelected(picked);
    }
  }
}

/// Dashed Border Photo Capture Box matching Screen 2 & 4
class GatePhotoPickerBox extends StatefulWidget {
  const GatePhotoPickerBox({
    super.key,
    required this.title,
    this.imageValue,
    this.readOnly = false,
    required this.onImage,
    this.onView,
  });

  final String title;
  final String? imageValue;
  final bool readOnly;
  final Function(File? file) onImage;
  final VoidCallback? onView;

  @override
  State<GatePhotoPickerBox> createState() => _GatePhotoPickerBoxState();
}

class _GatePhotoPickerBoxState extends State<GatePhotoPickerBox>
    with AttahcmentSelectionMixin {
  File? _localImageFile;

  bool get _hasImage =>
      _localImageFile != null || widget.imageValue.containsValidValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: _hasImage ? _buildPreviewCard() : _buildDashedCaptureButton(),
    );
  }

  Widget _buildDashedCaptureButton() {
    return GestureDetector(
      onTap: widget.readOnly ? null : _handleCapture,
      child: DashedBorderBox(
        color: const Color(0xFF93C5FD),
        borderRadius: 12,
        strokeWidth: 1.5,
        dashWidth: 6,
        dashSpace: 4,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                color: Color(0xFF0284C7),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Color(0xFF0369A1),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image display
          GestureDetector(
            onTap: widget.onView,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _localImageFile != null
                  ? Image.file(
                      _localImageFile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : _buildBase64Image(widget.imageValue!),
            ),
          ),

          // Label pill at bottom
          Positioned(
            left: 10,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF4ADE80),
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Action buttons on top right
          if (!widget.readOnly) ...[
            Positioned(
              top: 6,
              right: 6,
              child: Row(
                children: [
                  // Retake
                  GestureDetector(
                    onTap: _handleCapture,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Clear
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _localImageFile = null;
                      });
                      widget.onImage(null);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBase64Image(String source) {
    try {
      return Image.memory(
        base64Decode(source),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } catch (_) {
      return const Center(
        child: Icon(Icons.broken_image_rounded, color: Colors.grey),
      );
    }
  }

  Future<void> _handleCapture() async {
    final captured = await captureImage();
    if (captured != null) {
      setState(() {
        _localImageFile = captured;
      });
      widget.onImage(captured);
    }
  }
}

/// Status badge pill with custom colors
class GateStatusBadge extends StatelessWidget {
  const GateStatusBadge({super.key, this.status});

  final String? status;

  @override
  Widget build(BuildContext context) {
    final s = status?.trim() ?? 'Draft';
    final normalized = s.toLowerCase();

    Color bgColor = const Color(0xFFE0F2FE);
    Color textColor = const Color(0xFF0284C7);

    if (normalized.contains('draft')) {
      bgColor = const Color(0xFFE0F2FE);
      textColor = const Color(0xFF0284C7);
    } else if (normalized.contains('pending') ||
        normalized.contains('submitted')) {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFFD97706);
    } else if (normalized.contains('complete') ||
        normalized.contains('approved')) {
      bgColor = const Color(0xFFDCFCE7);
      textColor = const Color(0xFF16A34A);
    } else if (normalized.contains('cancel') ||
        normalized.contains('rejected')) {
      bgColor = const Color(0xFFFEE2E2);
      textColor = const Color(0xFFDC2626);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        s,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Primary Full-Width Action Button (Save / Submit / New)
class GatePrimaryButton extends StatelessWidget {
  const GatePrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D4ED8),
              elevation: 2,
              shadowColor: const Color(0xFF1D4ED8).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: isLoading ? null : onPressed,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
