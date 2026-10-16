import 'package:flutter/material.dart';
import 'package:svs_operations/features/gate_entry/model/gate_entry.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_ui_components.dart';

class GateEntryWidget extends StatelessWidget {
  const GateEntryWidget({
    super.key,
    required this.gateEntry,
    required this.onTap,
  });

  final GateEntry gateEntry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final vehicleText =
        gateEntry.vehicleNo.isNotEmpty ? gateEntry.vehicleNo : '--';

    final gateEntryName = gateEntry.name.isNotEmpty ? gateEntry.name : '--';
    final poNumber = gateEntry.poNumber.isNotEmpty ? gateEntry.poNumber : '--';
    final dateText = gateEntry.entryDate.isNotEmpty
        ? gateEntry.entryDate
        : (gateEntry.invoiceDate.isNotEmpty ? gateEntry.invoiceDate : '---');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x080F172A),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Inward arrow icon badge
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.login_rounded,
                    color: Color(0xFF0284C7),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // Vehicle number & supplier/po
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gateEntryName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        vehicleText,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Status pill
                GateStatusBadge(status: gateEntry.status),
              ],
            ),

            const SizedBox(height: 8),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 6),

            // Date and Document ID row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      dateText,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  poNumber,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
