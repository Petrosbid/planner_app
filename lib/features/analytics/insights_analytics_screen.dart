import 'package:flutter/material.dart';

import '../../core/controllers/planner_store.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/aura_charts.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/skeleton.dart';

class InsightsAnalyticsScreen extends StatefulWidget {
  final VoidCallback? onOpenWeeklyReview;

  const InsightsAnalyticsScreen({super.key, this.onOpenWeeklyReview});

  @override
  State<InsightsAnalyticsScreen> createState() => _InsightsAnalyticsScreenState();
}

class _InsightsAnalyticsScreenState extends State<InsightsAnalyticsScreen> with SimulatedFetchMixin {
  static const _categoryColors = [
    AppColors.primary,
    AppColors.success,
    AppColors.warning,
    AppColors.tertiary,
  ];

  @override
  void initState() {
    super.initState();
    startSimulatedFetch();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;
    final hasData = store.tasks.isNotEmpty || store.focusRecords.isNotEmpty || store.blocks.isNotEmpty;

    if (isLoading) {
      return Scaffold(body: SafeArea(child: Shimmer(child: _buildSkeleton())));
    }

    return Scaffold(
      body: SafeArea(
        child: !hasData
            ? EmptyStateView(
                icon: Icons.insights_outlined,
                title: l10n.translate('emptyAnalyticsTitle'),
                message: l10n.translate('emptyAnalyticsMessage'),
              )
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  FadeSlideIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.translate('analyticsTitle'),
                                style: AppTypography.headlineLgMobile(color: AppColors.primary),
                              ),
                              const SizedBox(height: 4),
                              Text(l10n.translate('analyticsSubtitle'), style: AppTypography.bodySm()),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.rate_review_outlined, color: AppColors.primary),
                          onPressed: widget.onOpenWeeklyReview,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Metric cards (computed)
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 80),
                    child: Row(
                      children: [
                        Expanded(
                          child: GlassCard(
                            child: Column(
                              children: [
                                Text(l10n.translate('executionRate'), style: AppTypography.bodySm()),
                                const SizedBox(height: 8),
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: store.executionRate * 100),
                                  duration: const Duration(milliseconds: 700),
                                  builder: (context, v, _) => Text(
                                    '${ZedDateUtils.toFaDigits(v.round(), fa: isFa)}٪',
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GlassCard(
                            child: Column(
                              children: [
                                Text(l10n.commitmentReliability, style: AppTypography.bodySm()),
                                const SizedBox(height: 8),
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: store.commitmentReliability * 100),
                                  duration: const Duration(milliseconds: 700),
                                  builder: (context, v, _) => Text(
                                    '${ZedDateUtils.toFaDigits(v.round(), fa: isFa)}٪',
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Donut: planned time by block category
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 160),
                    child: _categoryDonut(l10n, store, isFa),
                  ),
                  const SizedBox(height: 20),

                  // Weekly focus bars
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 240),
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.translate('weeklyFocus'), style: AppTypography.headlineMd()),
                          const SizedBox(height: 12),
                          SimpleBarChart(
                            values: store.weeklyFocusMinutes,
                            labels: [
                              for (var i = 6; i >= 0; i--)
                                ZedDateUtils.weekday(
                                  DateTime.now().subtract(Duration(days: i)),
                                  fa: isFa,
                                  short: true,
                                ),
                            ],
                            barColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _categoryDonut(AppLocalizations l10n, PlannerStore store, bool isFa) {
    final byCategory = store.focusMinutesByCategory;
    if (byCategory.isEmpty) {
      return GlassCard(
        child: Column(
          children: [
            Text(l10n.translate('focusByCategory'), style: AppTypography.headlineMd()),
            const SizedBox(height: 12),
            Text(l10n.translate('noCategoryData'), style: AppTypography.bodySm()),
          ],
        ),
      );
    }

    final entries = byCategory.entries.toList();
    final totalMinutes = entries.fold<double>(0, (sum, e) => sum + e.value);
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.translate('focusByCategory'), style: AppTypography.headlineMd()),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DonutChartWidget(
                percentages: [for (final e in entries) e.value],
                colors: [for (var i = 0; i < entries.length; i++) _categoryColors[i % _categoryColors.length]],
                centerText:
                    '${ZedDateUtils.toFaDigits((totalMinutes / 60).toStringAsFixed(1), fa: isFa)}\n${l10n.translate('hoursUnit')}',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < entries.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _categoryColors[i % _categoryColors.length],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _categoryLabel(entries[i].key, l10n),
                            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _categoryLabel(String key, AppLocalizations l10n) {
    switch (key) {
      case 'deep':
        return l10n.translate('deepWork');
      case 'meeting':
        return l10n.translate('meeting');
      default:
        return l10n.translate('review');
    }
  }

  // Mirrors the loaded layout so the skeleton→content transition is seamless.
  Widget _buildSkeleton() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonLine(width: 150, height: 22),
                SizedBox(height: 8),
                SkeletonLine(width: 180, height: 12),
              ],
            ),
            const SkeletonCircle(size: 40),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SkeletonCard(
                radius: 24,
                child: Column(
                  children: const [
                    SkeletonLine(width: 80, height: 10),
                    SizedBox(height: 12),
                    SkeletonLine(width: 56, height: 24),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SkeletonCard(
                radius: 24,
                child: Column(
                  children: const [
                    SkeletonLine(width: 90, height: 10),
                    SizedBox(height: 12),
                    SkeletonLine(width: 56, height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SkeletonCard(
          radius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonLine(width: 160, height: 14),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SkeletonCircle(size: 120),
                  SkeletonLine(width: 100, height: 12),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
