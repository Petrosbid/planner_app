import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Sweeps a soft highlight across its [child] while data is loading.
///
/// Wrap an all-skeleton subtree (e.g. a screen body built from
/// [SkeletonLine]/[SkeletonCircle]/[SkeletonCard]). The sweep is theme-aware:
/// darker base with a subtle lift in dark mode, light grey in light mode.
class Shimmer extends StatefulWidget {
  final Widget child;

  const Shimmer({super.key, required this.child});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? AppColors.darkSurfaceContainerLow : AppColors.surfaceContainerLow;
    final highlight = isDark ? AppColors.darkSurfaceContainerHigh : Colors.white;

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          child: child,
          shaderCallback: (bounds) {
            // Slide the gradient's rect across the bounds each frame.
            final dx = -bounds.width + _controller.value * bounds.width * 3;
            return LinearGradient(
              colors: [base, highlight, base],
              stops: const [0.4, 0.5, 0.6],
            ).createShader(
              Rect.fromLTWH(dx, 0, bounds.width * 2, bounds.height),
            );
          },
        );
      },
    );
  }
}

/// Simulates an async screen fetch for the demo data layer.
///
/// Re-arms itself on hot reload: `initState` does not re-run after a reload,
/// which would otherwise leave the skeleton on screen forever.
/// Replace `startSimulatedFetch` with the real repository watch later.
mixin SimulatedFetchMixin<T extends StatefulWidget> on State<T> {
  bool isLoading = true;

  /// Called after the simulated load completes; override for post-load work.
  void onLoadComplete() {}

  void startSimulatedFetch({Duration delay = const Duration(milliseconds: 900)}) {
    Future.delayed(delay, () {
      if (!mounted) return;
      setState(() => isLoading = false);
      onLoadComplete();
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (isLoading) startSimulatedFetch(delay: Duration.zero);
  }
}

/// A rounded placeholder bar. Paints opaque so [Shimmer]'s ShaderMask recolors it.
class SkeletonLine extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const SkeletonLine({super.key, this.width, this.height = 12, this.borderRadius = 6});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// A circular placeholder (avatars, chart rings, icon bubbles).
class SkeletonCircle extends StatelessWidget {
  final double size;

  const SkeletonCircle({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    );
  }
}

/// A card-shaped placeholder container; compose it with [SkeletonLine] children.
class SkeletonCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double radius;
  final Widget child;

  const SkeletonCard({super.key, this.padding = const EdgeInsets.all(16), this.radius = 16, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceContainerLow : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: isDark ? AppColors.darkOutlineVariant : AppColors.outlineVariant,
          width: 0.5,
        ),
      ),
      child: child,
    );
  }
}
