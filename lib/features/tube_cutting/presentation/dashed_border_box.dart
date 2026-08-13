import 'package:flutter/material.dart';


class DashedBorderBox extends StatelessWidget {

  const DashedBorderBox({
    super.key,
    required this.child,
    this.color = const Color(0xFF2563EB),
    this.strokeWidth = 1.5,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.borderRadius = 16,
  });
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (context, constraints) {
        return CustomPaint(

          foregroundPainter: DashedBorderPainter(
            color: color,
            strokeWidth: strokeWidth,
            dashWidth: dashWidth,
            dashSpace: dashSpace,
            borderRadius: borderRadius,
          ),
          child: child,
        );
      },
    );
  }
}


class DashedBorderPainter extends CustomPainter {

  const DashedBorderPainter({
    this.color = const Color(0xFF2563EB),
    this.strokeWidth = 1.5,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.borderRadius = 16,
  });
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(borderRadius),
        ),
      );

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.dashWidth != dashWidth ||
      old.dashSpace != dashSpace ||
      old.borderRadius != borderRadius;
}