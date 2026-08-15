import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ==========================================
// 1. RADAR CHART WIDGET (Financial Health)
// ==========================================
class RadarChartWidget extends StatelessWidget {
  final List<String> categories;
  final List<double> values; // Normalized 0.0 - 1.0

  const RadarChartWidget({
    super.key,
    this.categories = const ['درآمد', 'پس‌انداز', 'بدهی', 'هزینه‌ها'],
    this.values = const [0.85, 0.70, 0.40, 0.65],
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: CustomPaint(
        painter: _RadarChartPainter(
          categories: categories,
          values: values,
          primaryColor: AppColors.primaryContainer,
        ),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<String> categories;
  final List<double> values;
  final Color primaryColor;

  _RadarChartPainter({
    required this.categories,
    required this.values,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2.8;
    final numSides = categories.length;
    final angleStep = (2 * pi) / numSides;

    // Grid circles/polygons
    final gridPaint = Paint()
      ..color = AppColors.primaryContainer.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int step = 1; step <= 3; step++) {
      final r = radius * (step / 3);
      final path = Path();
      for (int i = 0; i < numSides; i++) {
        final angle = i * angleStep - pi / 2;
        final x = center.dx + r * cos(angle);
        final y = center.dy + r * sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // Axes lines & Labels
    const textStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.lightOnSurfaceVariant,
    );

    for (int i = 0; i < numSides; i++) {
      final angle = i * angleStep - pi / 2;
      final endPoint = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(center, endPoint, gridPaint);

      // Draw category label
      final labelOffset = Offset(
        center.dx + (radius + 20) * cos(angle),
        center.dy + (radius + 15) * sin(angle),
      );
      final textSpan = TextSpan(text: categories[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.rtl,
      )..layout();

      textPainter.paint(
        canvas,
        labelOffset - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    // Filled Data Polygon
    final fillPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final dataPath = Path();
    for (int i = 0; i < numSides; i++) {
      final val = values[i].clamp(0.0, 1.0);
      final r = radius * val;
      final angle = i * angleStep - pi / 2;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();
    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ==========================================
// 2. LINE CHART WIDGET (Growth & Energy)
// ==========================================
class LineChartWidget extends StatelessWidget {
  final List<double> dataPoints;
  final List<double>? secondaryDataPoints;
  final List<String> xLabels;
  final Color primaryColor;

  const LineChartWidget({
    super.key,
    required this.dataPoints,
    this.secondaryDataPoints,
    this.xLabels = const ['۱', '۵', '۱۰', '۱۵', '۲۰', '۲۵', '۳۰'],
    this.primaryColor = AppColors.primaryContainer,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: CustomPaint(
        painter: _LineChartPainter(
          dataPoints: dataPoints,
          secondaryDataPoints: secondaryDataPoints,
          xLabels: xLabels,
          primaryColor: primaryColor,
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final List<double>? secondaryDataPoints;
  final List<String> xLabels;
  final Color primaryColor;

  _LineChartPainter({
    required this.dataPoints,
    this.secondaryDataPoints,
    required this.xLabels,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const paddingBottom = 30.0;
    const paddingLeft = 30.0;
    final chartWidth = size.width - paddingLeft;
    final chartHeight = size.height - paddingBottom;

    // Grid lines
    final gridPaint = Paint()
      ..color = AppColors.outlineVariant.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 3; i++) {
      final y = chartHeight * (i / 3);
      canvas.drawLine(Offset(paddingLeft, y), Offset(size.width, y), gridPaint);
    }

    // Draw Main Smooth Bezier Line
    const maxVal = 30.0;
    final path = Path();
    final fillPath = Path();

    final stepX = chartWidth / (dataPoints.length - 1);

    fillPath.moveTo(paddingLeft, chartHeight);
    for (int i = 0; i < dataPoints.length; i++) {
      final x = paddingLeft + i * stepX;
      final y = chartHeight - (dataPoints[i] / maxVal) * chartHeight;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.lineTo(x, y);
      } else {
        final prevX = paddingLeft + (i - 1) * stepX;
        final prevY = chartHeight - (dataPoints[i - 1] / maxVal) * chartHeight;
        final controlX1 = prevX + stepX / 2;
        final controlY1 = prevY;
        final controlX2 = prevX + stepX / 2;
        final controlY2 = y;
        path.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
        fillPath.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
      }
    }

    fillPath.lineTo(paddingLeft + (dataPoints.length - 1) * stepX, chartHeight);
    fillPath.close();

    final fillGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        primaryColor.withValues(alpha: 0.3),
        primaryColor.withValues(alpha: 0.0),
      ],
    );

    final fillPaint = Paint()
      ..shader = fillGradient.createShader(Rect.fromLTWH(0, 0, size.width, chartHeight));
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawPath(path, linePaint);

    // Draw Dots on Main Line
    final dotPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    final dotInnerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < dataPoints.length; i++) {
      final x = paddingLeft + i * stepX;
      final y = chartHeight - (dataPoints[i] / maxVal) * chartHeight;
      canvas.drawCircle(Offset(x, y), 5, dotPaint);
      canvas.drawCircle(Offset(x, y), 2.5, dotInnerPaint);
    }

    // Secondary line if provided
    if (secondaryDataPoints != null) {
      final secPaint = Paint()
        ..color = AppColors.secondary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      final secPath = Path();
      for (int i = 0; i < secondaryDataPoints!.length; i++) {
        final x = paddingLeft + i * stepX;
        final y = chartHeight - (secondaryDataPoints![i] / maxVal) * chartHeight;
        if (i == 0) {
          secPath.moveTo(x, y);
        } else {
          secPath.lineTo(x, y);
        }
      }
      canvas.drawPath(secPath, secPaint);
    }

    // X Labels
    const labelStyle = TextStyle(
      fontSize: 11,
      color: AppColors.lightOnSurfaceVariant,
    );
    for (int i = 0; i < xLabels.length; i++) {
      final x = paddingLeft + i * (chartWidth / (xLabels.length - 1));
      final textSpan = TextSpan(text: xLabels[i], style: labelStyle);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.rtl)..layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, chartHeight + 8));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ==========================================
// 3. DONUT CHART WIDGET (Expense Breakdown)
// ==========================================
class DonutChartWidget extends StatelessWidget {
  final List<double> percentages; // e.g. [45, 30, 25]
  final List<Color> colors;
  final String centerText;

  const DonutChartWidget({
    super.key,
    this.percentages = const [45, 30, 25],
    this.colors = const [AppColors.primaryContainer, AppColors.secondary, AppColors.warning],
    this.centerText = '۱۰۰%\nکل بودجه',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(160, 160),
            painter: _DonutChartPainter(
              percentages: percentages,
              colors: colors,
            ),
          ),
          Text(
            centerText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.lightOnSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final List<double> percentages;
  final List<Color> colors;

  _DonutChartPainter({required this.percentages, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 20.0;

    double startAngle = -pi / 2;
    final total = percentages.fold(0.0, (a, b) => a + b);

    for (int i = 0; i < percentages.length; i++) {
      final sweepAngle = (percentages[i] / total) * (2 * pi);
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle - 0.08, // Gap between segments
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ==========================================
// 4. SCATTER PLOT WIDGET (Energy vs Output)
// ==========================================
class ScatterPlotWidget extends StatelessWidget {
  const ScatterPlotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: CustomPaint(
        painter: _ScatterPlotPainter(),
      ),
    );
  }
}

class _ScatterPlotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const padding = 30.0;
    final width = size.width - padding * 2;
    final height = size.height - padding * 2;

    final gridPaint = Paint()
      ..color = AppColors.outlineVariant.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke;

    for (int i = 0; i <= 4; i++) {
      final y = padding + i * (height / 4);
      canvas.drawLine(Offset(padding, y), Offset(size.width - padding, y), gridPaint);
    }

    final points = [
      const Offset(0.2, 0.8),
      const Offset(0.4, 0.4),
      const Offset(0.5, 0.6),
      const Offset(0.65, 0.3),
      const Offset(0.75, 0.15),
      const Offset(0.85, 0.2),
      const Offset(0.95, 0.05),
    ];

    final dotPaint = Paint()
      ..color = AppColors.primaryContainer
      ..style = PaintingStyle.fill;

    final dotRingPaint = Paint()
      ..color = AppColors.primaryContainer.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final p in points) {
      final dx = padding + p.dx * width;
      final dy = padding + p.dy * height;
      canvas.drawCircle(Offset(dx, dy), 8, dotPaint);
      canvas.drawCircle(Offset(dx, dy), 10, dotRingPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 5. WEEKLY BAR CHART (Performance Report)
// ==========================================
class WeeklyBarChartWidget extends StatelessWidget {
  const WeeklyBarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['شنبه', '۱شنبه', '۲شنبه', '۳شنبه', '۴شنبه', '۵شنبه', 'جمعه'];
    final thisWeekData = [0.2, 0.4, 0.85, 0.6, 0.95, 0.5, 0.7];
    final lastWeekData = [0.3, 0.5, 0.75, 0.45, 0.80, 0.6, 0.5];

    return AspectRatio(
      aspectRatio: 1.8,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(days.length, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 12,
                          height: 140 * thisWeekData[index],
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 12,
                          height: 140 * lastWeekData[index],
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      days[index],
                      style: const TextStyle(fontSize: 11, color: AppColors.lightOnSurfaceVariant),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. HEATMAP WIDGET (Focus Consistency)
// ==========================================
class HeatmapWidget extends StatelessWidget {
  const HeatmapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final grid = [
      [1, 2, 3, 3, 1, 2, 2],
      [3, 1, 2, 2, 1, 3, 3],
    ];

    final colors = [
      AppColors.primaryContainer.withValues(alpha: 0.15),
      AppColors.primaryContainer.withValues(alpha: 0.4),
      AppColors.primaryContainer.withValues(alpha: 0.7),
      AppColors.primaryContainer,
    ];

    return Column(
      children: List.generate(grid.length, (r) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(grid[r].length, (c) {
              final level = grid[r][c];
              return Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: colors[level],
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
