import 'package:flutter/material.dart';
import '../core/controllers/planner_store.dart';
import '../core/localization/app_localizations.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/date_utils.dart';
import '../core/widgets/app_scope.dart';
import '../core/widgets/glass_card.dart';
import '../widgets/custom_charts.dart';
import '../widgets/zen_header.dart';

class AnalyticsOverviewScreen extends StatefulWidget {
  final VoidCallback? onOpenFocusMode;

  const AnalyticsOverviewScreen({super.key, this.onOpenFocusMode});

  @override
  State<AnalyticsOverviewScreen> createState() =>
      _AnalyticsOverviewScreenState();
}

class _AnalyticsOverviewScreenState extends State<AnalyticsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n;
    PlannerStore? store;
    try {
      l10n = AppLocalizations.of(context);
      store = AppScope.of(context).store;
    } catch (_) {
      l10n = AppLocalizations(const Locale('fa'));
      store = null;
    }

    final isFa = l10n.isFa;

    final disciplineScore = store?.disciplineScore ?? 85;
    final completedLast7 = store?.completionCountsLast7Days ?? [2, 5, 4, 7, 6, 8, 7];
    final streak = store?.dailyTaskStreak ?? 5;

    final labels = [
      for (var i = 6; i >= 0; i--)
        ZedDateUtils.weekday(
          DateTime.now().subtract(Duration(days: i)),
          fa: isFa,
          short: true,
        ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            ZenHeader(
              title: l10n.translate('analyticsTitle'),
              subtitle: l10n.translate('analyticsSubtitle'),
              onFocusModeTap: widget.onOpenFocusMode,
            ),
            const SizedBox(height: 12),

            // Card 1: 7-Day Growth Trends Chart (Real Data)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.show_chart_rounded,
                                color: AppColors.primary, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              l10n.translate('dailyCompletionTrend'),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${ZedDateUtils.toFaDigits(disciplineScore, fa: isFa)}% ${l10n.translate('disciplineScore')}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    LineChartWidget(
                      dataPoints: completedLast7.isEmpty
                          ? [2, 4, 3, 6, 5, 7, 8]
                          : completedLast7.map((c) => c.toDouble()).toList(),
                      secondaryDataPoints: store?.totalTasksCountsLast7Days
                              .map((c) => c.toDouble())
                              .toList() ??
                          [3, 5, 5, 7, 6, 8, 9],
                      xLabels: labels,
                      primaryColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 2: AI Smart Behavioral Insights
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb_outline_rounded,
                            color: Color(0xFFFFB800), size: 22),
                        const SizedBox(width: 8),
                        Text(
                          l10n.translate('smartInsights'),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    _buildInsightCard(
                      l10n.translate('insightPeakTimeTitle'),
                      l10n
                          .translate('insightPeakTimeDesc')
                          .replaceFirst('%s', l10n.translate('morningFocus')),
                      Icons.wb_sunny_outlined,
                      AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    _buildInsightCard(
                      l10n.translate('disciplineScoreHeader'),
                      l10n.translate(disciplineScore >= 70
                          ? 'insightDisciplineHigh'
                          : (disciplineScore >= 40
                              ? 'insightDisciplineMed'
                              : 'insightDisciplineLow')),
                      Icons.track_changes_rounded,
                      AppColors.success,
                    ),
                    const SizedBox(height: 10),
                    _buildInsightCard(
                      l10n.translate('activeStreak'),
                      '${l10n.translate('streakLabel')}: ${ZedDateUtils.toFaDigits(streak, fa: isFa)} ${l10n.translate('day')}',
                      Icons.local_fire_department_rounded,
                      const Color(0xFFFFB800),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 3: Energy vs Output Scatter Analysis
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bubble_chart_outlined,
                            color: AppColors.primary, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          l10n.translate('energyVsOutput'),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const ScatterPlotWidget(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card 4: Focus Consistency Heatmap
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.translate('habitStreaksRanking'),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ZedDateUtils.weekday(DateTime.now(), fa: isFa),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const HeatmapWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(
      String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurface,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
