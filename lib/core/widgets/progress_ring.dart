import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProgressRing extends StatelessWidget {
  final double percentage; // 0.0 to 100.0
  final double size;
  final double strokeWidth;
  final Color primaryColor;
  final Color trackColor;
  final Widget? centerChild;

  const ProgressRing({
    super.key,
    required this.percentage,
    this.size = 96.0,
    this.strokeWidth = 8.0,
    this.primaryColor = AppColors.primary,
    this.trackColor = const Color(0x1F3C51C2),
    this.centerChild,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              percentage: percentage.clamp(0.0, 100.0),
              strokeWidth: strokeWidth,
              primaryColor: primaryColor,
              trackColor: trackColor,
            ),
          ),
          if (centerChild != null) centerChild!,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color primaryColor;
  final Color trackColor;

  _RingPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.primaryColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc
    if (percentage > 0) {
      final progressPaint = Paint()
        ..color = primaryColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final sweepAngle = (2 * pi) * (percentage / 100.0);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2, // Start at top 12 o'clock
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.trackColor != trackColor;
  }
}
