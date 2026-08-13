import 'package:flutter/material.dart';
import 'package:svs_operations/features/tube_cutting/presentation/dashed_border_box.dart';
import 'package:svs_operations/features/tube_cutting/presentation/qr_scanner_screen.dart';
import 'package:svs_operations/features/tube_cutting/presentation/work_station_Screen.dart';

class TubeCuttingScreen extends StatelessWidget {
  final String title;
  final String date;
  const TubeCuttingScreen({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('($date)'),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        
        child: Column(
          children: [
            // _buildHeader(title, date),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    14,
                    22,
                    21,
                    20,
                  ),
                  child: _buildScanCard(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title, String date) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        35,
        15,
        34,
        10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF168ED1),
            ),
          ),
          const Spacer(),
          Text(
            '($date)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF61718C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanCard(BuildContext context) {
    return CustomPaint(
        painter: DashedRoundedBorderPainter(
          color: const Color(0xFF59AEE2),
          strokeWidth: 3,
          dashWidth: 10,
          dashSpace: 8,
          radius: 20,
        ),
        child: DashedBorderBox(
          borderRadius: 20,
          color: Colors.blue,
          dashSpace: 6,
          dashWidth: 5,
          strokeWidth: 2,
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQrButton(context),
                const SizedBox(height: 43),
                const Text(
                  'SCAN MACHINE / WORK STATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Scan the QR to start the process',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF92A3BD),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildQrButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        // final String? scannedValue = await Navigator.push<String>(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => const QrScannerScreen(),
        //   ),
        // );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TubeCuttingWorkStationScreen(),
          ),
        );

        // if (scannedValue != null && scannedValue.isNotEmpty) {
        // debugPrint('QR Code: $scannedValue');

        // Do whatever you need with the scanned value.
        // Example:
        // context.read<TubeCuttingCubit>().scanMachine(
        //   scannedValue,
        // );
        // }
      },
      child: Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF188FD2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF188FD2).withOpacity(0.25),
              blurRadius: 18,
              spreadRadius: 4,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.qr_code_scanner_rounded,
            size: 45,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DashedRoundedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  DashedRoundedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final path = Path();

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    path.addRRect(
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(radius),
      ),
    );

    _drawDashedPath(
      canvas,
      path,
      paint,
      dashWidth,
      dashSpace,
    );
  }

  void _drawDashedPath(
    Canvas canvas,
    Path path,
    Paint paint,
    double dashWidth,
    double dashSpace,
  ) {
    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final double nextDistance = distance + dashWidth;

        final Path dash = metric.extractPath(
          distance,
          nextDistance > metric.length ? metric.length : nextDistance,
        );

        canvas.drawPath(dash, paint);

        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant DashedRoundedBorderPainter oldDelegate,
  ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.radius != radius;
  }
}
