import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/create_item_cubit.dart';

class RejectionTrayWidget extends StatefulWidget {
  final VoidCallback? onScanTap;
  final VoidCallback? onCameraTap;
  final String trayId;
  final int rejectedQuantity;
  final String rejectionTrayImagePath;

  const RejectionTrayWidget({
    super.key,
    this.onScanTap,
    this.onCameraTap,
    this.trayId = 'XXX-XX-XX-XXX',
    this.rejectedQuantity = 0,
    required this.rejectionTrayImagePath,
  });

  static const Color _backgroundColor = Color(0xFFF1F3F5);
  static const Color _cardColor = Color(0xFFF7F8F9);
  static const Color _innerCardColor = Color(0xFFE8EFF4);
  static const Color _borderColor = Color(0xFFD9DDE1);
  static const Color _blueColor = Color(0xFF269FE8);
  static const Color _textColor = Color(0xFF374151);
  static const Color _subTextColor = Color(0xFF9CA3AF);

  @override
  State<RejectionTrayWidget> createState() => _RejectionTrayWidgetState();
}

class _RejectionTrayWidgetState extends State<RejectionTrayWidget> {
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RejectionTrayWidget._backgroundColor,
      padding: const EdgeInsets.all(9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ADD ANY SCRAP QTY.',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF92979D),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            height: 177,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left: Scanner and image card
                Expanded(
                  flex: 11,
                  child: _buildScannerCard(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 11,
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          value: widget.trayId,
                          label: 'Scrap Tray ID',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: _buildQuantityCard(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerCard() {
    return Container(
      decoration: BoxDecoration(
        color: RejectionTrayWidget._cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RejectionTrayWidget._borderColor),
      ),
      child: Column(
        children: [
          const SizedBox(height: 11),

          // Scan tray button
          InkWell(
            onTap: widget.onScanTap,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.document_scanner_outlined,
                        color: RejectionTrayWidget._blueColor,
                        size: 17,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'Scan Scrap Tray ID',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: RejectionTrayWidget._blueColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Tap to Scan',
                    style: TextStyle(
                      color: RejectionTrayWidget._subTextColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 7),

          // Dashed divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final count = (constraints.maxWidth / 6).floor();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    count,
                    (_) => Container(
                      width: 3,
                      height: 1.5,
                      color: const Color(0xFFBFCBD5),
                    ),
                  ),
                );
              },
            ),
          ),

          // Camera image section
          Expanded(
            child: InkWell(
              onTap: widget.onCameraTap,
              child: Center(
                child: widget.rejectionTrayImagePath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(widget.rejectionTrayImagePath),
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 19,
                            backgroundColor: Color(0xFFE9EDF1),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xFF7C8FA3),
                              size: 21,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Image of Scrap Tray',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: RejectionTrayWidget._subTextColor,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String value,
    required String label,
    Color valueColor = RejectionTrayWidget._textColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: RejectionTrayWidget._cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RejectionTrayWidget._borderColor),
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: RejectionTrayWidget._innerCardColor,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: RejectionTrayWidget._subTextColor,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: RejectionTrayWidget._cardColor,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 32,
              child: TextField(
                controller: quantityController,
                onChanged: (value) {
                  context
                      .read<CreateItemCubit>()
                      .onValueChanged(rejectedQty: int.tryParse(value));
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFF646B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  hintText: '0',
                  hintStyle: TextStyle(
                    color: Color(0xFFFF646B),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ),
            const Text(
              'Scrap Quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
