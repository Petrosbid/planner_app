import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class FocusTimerRing extends StatefulWidget {
  final double percentage; // 0.0 to 100.0
  final int remainingSeconds;
  final int totalSeconds;
  final bool isRunning;
  final String modeName;
  final Color primaryColor;
  final VoidCallback? onAddMinute;
  final VoidCallback? onSubtractMinute;
  final bool isZenMode;
  final double ringSize;

  const FocusTimerRing({
    super.key,
    required this.percentage,
    required this.remainingSeconds,
    required this.totalSeconds,
    required this.isRunning,
    required this.modeName,
    this.primaryColor = AppColors.primary,
    this.onAddMinute,
    this.onSubtractMinute,
    this.isZenMode = false,
    this.ringSize = 230.0,
  });

  @override
  State<FocusTimerRing> createState() => _FocusTimerRingState();
}

class _FocusTimerRingState extends State<FocusTimerRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOutSine,
      ),
    );

    if (widget.isRunning) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant FocusTimerRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning != oldWidget.isRunning) {
      if (widget.isRunning) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.animateTo(0.0,
            duration: const Duration(milliseconds: 400));
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _formatPersianDigits(String input) {
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsiDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(englishDigits[i], farsiDigits[i]);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final minutes = widget.remainingSeconds ~/ 60;
    final seconds = widget.remainingSeconds % 60;
    final timeRaw =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    final timeFormatted = _formatPersianDigits(timeRaw);

    final double effectiveSize = widget.isZenMode ? widget.ringSize * 1.15 : widget.ringSize;
    final double strokeWidth = 13.0;

    return Center(
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          final scale = widget.isRunning ? _pulseAnimation.value : 1.0;
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: SizedBox(
          width: effectiveSize + 32,
          height: effectiveSize + 32,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle Outer Ambient Glow Ring
              if (widget.isRunning)
                Container(
                  width: effectiveSize + 20,
                  height: effectiveSize + 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.primaryColor.withValues(alpha: isDark ? 0.25 : 0.15),
                        blurRadius: 32,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                ),

              // Inner Glassmorphic Circle Backdrop
              Container(
                width: effectiveSize - (strokeWidth * 2) - 8,
                height: effectiveSize - (strokeWidth * 2) - 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? AppColors.darkSurfaceContainer.withValues(alpha: 0.6)
                      : AppColors.surfaceContainerLow.withValues(alpha: 0.7),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkOutlineVariant.withValues(alpha: 0.4)
                        : AppColors.outlineVariant.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),

              // Custom Painter for Progress Arc and Ticks
              SizedBox(
                width: effectiveSize,
                height: effectiveSize,
                child: CustomPaint(
                  painter: _FocusRingPainter(
                    percentage: widget.percentage.clamp(0.0, 100.0),
                    strokeWidth: strokeWidth,
                    primaryColor: widget.primaryColor,
                    trackColor: isDark
                        ? AppColors.darkSurfaceContainerHigh
                        : AppColors.primaryContainer.withValues(alpha: 0.12),
                    isRunning: widget.isRunning,
                  ),
                ),
              ),

              // Central Content (Countdown & Status)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Mode Indicator Badge
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: widget.primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.isRunning
                                  ? AppColors.success
                                  : widget.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.modeName,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: widget.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Large Digital Countdown
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        timeFormatted,
                        style: AppTypography.displayData(
                          color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                        ).copyWith(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          fontFeatures: const [
                            FontFeature.tabularFigures(),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Status Text / Quick Nudge Buttons
                    if (!widget.isZenMode)
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: effectiveSize - 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.onSubtractMinute != null &&
                                widget.remainingSeconds > 60)
                              _quickTimeButton(
                                icon: Icons.remove_rounded,
                                tooltip: 'کاهش ۱ دقیقه',
                                onTap: widget.onSubtractMinute!,
                                isDark: isDark,
                              ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  widget.isRunning
                                      ? 'در حال تمرکز...'
                                      : 'آماده برای شروع',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: widget.isRunning
                                        ? widget.primaryColor
                                        : (isDark
                                            ? AppColors.darkOnSurfaceVariant
                                            : AppColors.onSurfaceVariant),
                                  ),
                                ),
                              ),
                            ),
                            if (widget.onAddMinute != null)
                              _quickTimeButton(
                                icon: Icons.add_rounded,
                                tooltip: 'افزایش ۱ دقیقه',
                                onTap: widget.onAddMinute!,
                                isDark: isDark,
                              ),
                          ],
                        ),
                      )
                    else
                      Text(
                        widget.isRunning ? 'در حال تمرکز...' : 'متوقف شده',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark
                              ? AppColors.darkOnSurfaceVariant
                              : AppColors.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickTimeButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurfaceContainerHigh
              : AppColors.surfaceContainerHigh,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 13,
          color: isDark
              ? AppColors.darkOnSurfaceVariant
              : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _FocusRingPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color primaryColor;
  final Color trackColor;
  final bool isRunning;

  _FocusRingPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.primaryColor,
    required this.trackColor,
    required this.isRunning,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 1. Background Track
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // 2. Subtle Minute Tick Marks around the ring
    final tickPaint = Paint()
      ..color = trackColor.withValues(alpha: 0.8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const totalTicks = 60;
    for (int i = 0; i < totalTicks; i++) {
      if (i % 5 == 0) {
        final angle = (i * 2 * pi / totalTicks) - (pi / 2);
        final outerX = center.dx + (radius + strokeWidth / 2 + 3) * cos(angle);
        final outerY = center.dy + (radius + strokeWidth / 2 + 3) * sin(angle);
        final innerX = center.dx + (radius + strokeWidth / 2 + 1) * cos(angle);
        final innerY = center.dy + (radius + strokeWidth / 2 + 1) * sin(angle);
        canvas.drawLine(Offset(innerX, innerY), Offset(outerX, outerY), tickPaint);
      }
    }

    // 3. Active Progress Arc
    if (percentage > 0) {
      final sweepAngle = (2 * pi) * (percentage / 100.0);

      // Gradient for active progress
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -pi / 2,
        endAngle: (3 * pi) / 2,
        colors: [
          primaryColor.withValues(alpha: 0.8),
          primaryColor,
          primaryColor,
        ],
        stops: const [0.0, 0.5, 1.0],
        transform: const GradientRotation(-pi / 2),
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        -pi / 2, // 12 o'clock top start
        sweepAngle,
        false,
        progressPaint,
      );

      // 4. Glowing Head Dot at the leading edge of progress
      final endAngle = -pi / 2 + sweepAngle;
      final headX = center.dx + radius * cos(endAngle);
      final headY = center.dy + radius * sin(endAngle);
      final headCenter = Offset(headX, headY);

      final dotGlowPaint = Paint()
        ..color = primaryColor.withValues(alpha: 0.4)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(headCenter, strokeWidth * 0.65, dotGlowPaint);

      final dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(headCenter, strokeWidth * 0.35, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _FocusRingPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.isRunning != isRunning;
  }
}
