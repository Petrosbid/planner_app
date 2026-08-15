import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HabitHeatmapGrid extends StatelessWidget {
  final List<double> dayOpacities; // 7 items (Monday..Sunday), values 0.0 to 1.0

  const HabitHeatmapGrid({
    super.key,
    required this.dayOpacities,
  });

  @override
  Widget build(BuildContext context) {
    const dayLabels = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final opacity = index < dayOpacities.length ? dayOpacities[index] : 0.0;
        final isActive = opacity > 0;

        return Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withValues(alpha: opacity.clamp(0.2, 1.0))
                    : AppColors.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: isActive
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 6),
            Text(
              dayLabels[index],
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class DonutChartWidget extends StatelessWidget {
  final List<double> percentages;
  final List<Color> colors;
  final String centerText;

  const DonutChartWidget({
    super.key,
    required this.percentages,
    required this.colors,
    required this.centerText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(140, 140),
            painter: _DonutPainter(percentages: percentages, colors: colors),
          ),
          Text(
            centerText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<double> percentages;
  final List<Color> colors;

  _DonutPainter({required this.percentages, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 16) / 2;
    double startAngle = -pi / 2;

    final total = percentages.fold(0.0, (sum, item) => sum + item);
    if (total == 0) return;

    for (int i = 0; i < percentages.length; i++) {
      final sweepAngle = (2 * pi) * (percentages[i] / total);
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..strokeWidth = 14
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SimpleBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final Color barColor;

  const SimpleBarChart({
    super.key,
    required this.values,
    required this.labels,
    this.barColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = values.isEmpty ? 1.0 : values.reduce(max);

    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (i) {
          final heightFactor = maxValue > 0 ? (values[i] / maxValue) : 0.0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 16,
                height: 80 * heightFactor.clamp(0.1, 1.0),
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                i < labels.length ? labels[i] : '',
                style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
              ),
            ],
          );
        }),
      ),
    );
  }
}
