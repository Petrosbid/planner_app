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
import '../../core/widgets/progress_ring.dart';
import '../../core/widgets/skeleton.dart';
import '../common/block_form_sheet.dart';
import '../common/distraction_reason_sheet.dart';

class InsightsAnalyticsScreen extends StatefulWidget {
  final VoidCallback? onOpenWeeklyReview;
  final VoidCallback? onOpenAchievements;

  const InsightsAnalyticsScreen({
    super.key,
    this.onOpenWeeklyReview,
    this.onOpenAchievements,
  });

  @override
  State<InsightsAnalyticsScreen> createState() =>
      _InsightsAnalyticsScreenState();
}

class _InsightsAnalyticsScreenState extends State<InsightsAnalyticsScreen>
    with SimulatedFetchMixin {
  static final _categoryColors = [
    AppColors.primary,
    AppColors.success,
    AppColors.warning,
    AppColors.tertiary,
    const Color(0xFF8B5CF6),
    const Color(0xFFEC4899),
  ];

  @override
  void initState() {
    super.initState();
    startSimulatedFetch();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final store = scope.store;
    final isFa = l10n.isFa;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hasData = store.tasks.isNotEmpty ||
        store.focusRecords.isNotEmpty ||
        store.blocks.isNotEmpty ||
        store.habits.isNotEmpty ||
        store.distractions.isNotEmpty;

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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  // Screen Header
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
                                style: AppTypography.headlineLgMobile(
                                    color: AppColors.primary),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.translate('analyticsSubtitle'),
                                style: AppTypography.bodySm(),
                              ),
                            ],
                          ),
                        ),
                        if (widget.onOpenAchievements != null)
                          IconButton(
                            icon: const Icon(Icons.emoji_events_outlined,
                                color: Color(0xFFFFB800)),
                            tooltip: l10n.translate('achievements'),
                            onPressed: widget.onOpenAchievements,
                          ),
                        IconButton(
                          icon: Icon(Icons.rate_review_outlined,
                              color: AppColors.primary),
                          tooltip: l10n.translate('reviews'),
                          onPressed: widget.onOpenWeeklyReview,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 1. Composite Discipline Score Card
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 60),
                    child: _buildDisciplineHeroCard(context, l10n, store, isFa, isDark),
                  ),
                  const SizedBox(height: 16),

                  // 2. AI Smart Behavioral Insights
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 120),
                    child: _buildSmartInsightsCard(context, l10n, store, isFa),
                  ),
                  const SizedBox(height: 16),

                  // 3. 7-Day Task Completion Trend
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 180),
                    child: _buildWeeklyCompletionTrendCard(context, l10n, store, isFa),
                  ),
                  const SizedBox(height: 16),

                  // 4. Focus Rhythm by Time of Day
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 240),
                    child: _buildTimeOfDayFocusCard(context, l10n, store, isFa),
                  ),
                  const SizedBox(height: 16),

                  // 5. Habits Consistency Leaderboard
                  if (store.habits.isNotEmpty) ...[
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 300),
                      child: _buildHabitsStreakCard(context, l10n, store, isFa),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 6. Task Execution by Priority
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 360),
                    child: _buildTasksByPriorityCard(context, l10n, store, isFa),
                  ),
                  const SizedBox(height: 16),

                  // 7. Time Category Donut
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 420),
                    child: _categoryDonut(l10n, store, isFa),
                  ),
                  const SizedBox(height: 16),

                  // 8. Weekly Distractions & Obstacles
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 480),
                    child: _weeklyDistractionsCard(l10n, store, isFa),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
      ),
    );
  }

  /// 1. Discipline Score Hero
  Widget _buildDisciplineHeroCard(
    BuildContext context,
    AppLocalizations l10n,
    PlannerStore store,
    bool isFa,
    bool isDark,
  ) {
    final score = store.disciplineScore;
    final execRate = store.executionRate;
    final commitRel = store.commitmentReliability;

    Color scoreColor;
    String scoreStatus;
    if (score >= 80) {
      scoreColor = AppColors.success;
      scoreStatus = l10n.translate('tierDiamond');
    } else if (score >= 60) {
      scoreColor = AppColors.primary;
      scoreStatus = l10n.translate('tierGold');
    } else if (score >= 40) {
      scoreColor = AppColors.warning;
      scoreStatus = l10n.translate('tierSilver');
    } else {
      scoreColor = AppColors.error;
      scoreStatus = l10n.translate('tierBronze');
    }

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.military_tech_rounded, color: scoreColor, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    l10n.translate('disciplineScoreHeader'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: scoreColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scoreColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  scoreStatus,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              // Score Progress Ring
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: score.toDouble()),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, val, _) => ProgressRing(
                  percentage: val,
                  size: 96,
                  strokeWidth: 9,
                  primaryColor: scoreColor,
                  trackColor: scoreColor.withValues(alpha: 0.15),
                  centerChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ZedDateUtils.toFaDigits(val.round(), fa: isFa),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: scoreColor,
                        ),
                      ),
                      Text(
                        '/ ۱۰۰',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Metrics breakdown
              Expanded(
                child: Column(
                  children: [
                    _buildSubMetricRow(
                      l10n.translate('executionRate'),
                      '${ZedDateUtils.toFaDigits((execRate * 100).round(), fa: isFa)}٪',
                      execRate,
                      AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    _buildSubMetricRow(
                      l10n.translate('commitmentReliability'),
                      '${ZedDateUtils.toFaDigits((commitRel * 100).round(), fa: isFa)}٪',
                      commitRel,
                      AppColors.success,
                    ),
                    const SizedBox(height: 10),
                    _buildSubMetricRow(
                      l10n.translate('activeStreak'),
                      '${ZedDateUtils.toFaDigits(store.dailyTaskStreak, fa: isFa)} ${l10n.translate('day')}',
                      (store.dailyTaskStreak / 14.0).clamp(0.0, 1.0),
                      AppColors.warning,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubMetricRow(
    String label,
    String valueText,
    double progress,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
            ),
            Text(
              valueText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 5,
            backgroundColor: AppColors.surfaceContainerHigh,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  /// 2. Smart Behavioral Insights
  Widget _buildSmartInsightsCard(
    BuildContext context,
    AppLocalizations l10n,
    PlannerStore store,
    bool isFa,
  ) {
    final focusByTime = store.focusByTimeOfDay;
    var maxKey = 'morning';
    var maxVal = 0;
    focusByTime.forEach((k, v) {
      if (v > maxVal) {
        maxVal = v;
        maxKey = k;
      }
    });

    String timeLabelKey = 'morningFocus';
    if (maxKey == 'afternoon') timeLabelKey = 'afternoonFocus';
    if (maxKey == 'evening') timeLabelKey = 'eveningFocus';
    if (maxKey == 'night') timeLabelKey = 'nightFocus';

    return GlassCard(
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Insight 1: Peak time
          _buildInsightItem(
            l10n.translate('insightPeakTimeTitle'),
            l10n
                .translate('insightPeakTimeDesc')
                .replaceFirst('%s', l10n.translate(timeLabelKey)),
            Icons.wb_sunny_outlined,
            AppColors.primary,
          ),
          const SizedBox(height: 10),

          // Insight 2: Discipline Status
          _buildInsightItem(
            l10n.translate('disciplineScoreHeader'),
            l10n.translate(store.disciplineScore >= 70
                ? 'insightDisciplineHigh'
                : (store.disciplineScore >= 40
                    ? 'insightDisciplineMed'
                    : 'insightDisciplineLow')),
            Icons.track_changes_rounded,
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
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
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 3),
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

  /// 3. Weekly Task Completion Trend
  Widget _buildWeeklyCompletionTrendCard(
    BuildContext context,
    AppLocalizations l10n,
    PlannerStore store,
    bool isFa,
  ) {
    final completedCounts = store.completionCountsLast7Days;
    final totalCompleted = completedCounts.fold<int>(0, (a, b) => a + b);

    final labels = [
      for (var i = 6; i >= 0; i--)
        ZedDateUtils.weekday(
          DateTime.now().subtract(Duration(days: i)),
          fa: isFa,
          short: true,
        ),
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.translate('dailyCompletionTrend'),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${ZedDateUtils.toFaDigits(totalCompleted, fa: isFa)} ${l10n.translate('completed')}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SimpleBarChart(
            values: [for (final c in completedCounts) c.toDouble()],
            labels: labels,
            barColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  /// 4. Focus Rhythm by Time of Day
  Widget _buildTimeOfDayFocusCard(
    BuildContext context,
    AppLocalizations l10n,
    PlannerStore store,
    bool isFa,
  ) {
    final dist = store.focusByTimeOfDay;
    final total = dist.values.fold<int>(0, (a, b) => a + b);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.translate('focusTimeDistribution'),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildTimeOfDayColumn(
                  l10n.translate('morningFocus'),
                  dist['morning'] ?? 0,
                  total,
                  Icons.wb_sunny_outlined,
                  const Color(0xFFFFB800),
                  isFa,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeOfDayColumn(
                  l10n.translate('afternoonFocus'),
                  dist['afternoon'] ?? 0,
                  total,
                  Icons.wb_twilight_rounded,
                  AppColors.primary,
                  isFa,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeOfDayColumn(
                  l10n.translate('eveningFocus'),
                  dist['evening'] ?? 0,
                  total,
                  Icons.nightlight_outlined,
                  const Color(0xFF8B5CF6),
                  isFa,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOfDayColumn(
    String label,
    int minutes,
    int total,
    IconData icon,
    Color color,
    bool isFa,
  ) {
    final percent = total > 0 ? (minutes / total) : 0.0;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            label.split(' ')[0], // first word e.g. "صبح" or "Morning"
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            '${ZedDateUtils.toFaDigits(minutes, fa: isFa)} د',
            style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 4,
              backgroundColor: AppColors.surfaceContainerHigh,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  /// 5. Habit Consistency Leaderboard
  Widget _buildHabitsStreakCard(
    BuildContext context,
    AppLocalizations l10n,
    PlannerStore store,
    bool isFa,
  ) {
    final ranked = store.rankedHabits;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.translate('habitStreaksRanking'),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.emoji_events_outlined,
                  color: Color(0xFFFFB800), size: 18),
            ],
          ),
          const SizedBox(height: 12),
          ...ranked.take(5).map((entry) {
            final habit = entry.key;
            final streak = entry.value;
            final habitColor = Color(habit.colorValue);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: habitColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: habitColor, width: 1.5),
                    ),
                    child: Icon(Icons.autorenew_rounded,
                        color: habitColor, size: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${l10n.translate('last30Days')}: ${ZedDateUtils.toFaDigits(habit.markedDays.length, fa: isFa)} ${l10n.translate('day')}',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: streak > 0
                          ? const Color(0xFFFFB800).withValues(alpha: 0.15)
                          : AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          size: 14,
                          color: streak > 0
                              ? const Color(0xFFFFB800)
                              : AppColors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          ZedDateUtils.toFaDigits(streak, fa: isFa),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: streak > 0
                                ? const Color(0xFFFFB800)
                                : AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 6. Task Execution by Priority
  Widget _buildTasksByPriorityCard(
    BuildContext context,
    AppLocalizations l10n,
    PlannerStore store,
    bool isFa,
  ) {
    final prioMap = store.tasksByPriority;

    final high = prioMap[2]!;
    final med = prioMap[1]!;
    final low = prioMap[0]!;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.translate('tasksByPriority'),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          _buildPriorityBarRow(
            l10n.translate('priorityHigh'),
            high.completed,
            high.total,
            AppColors.error,
            isFa,
          ),
          const SizedBox(height: 10),
          _buildPriorityBarRow(
            l10n.translate('priorityMedium'),
            med.completed,
            med.total,
            AppColors.warning,
            isFa,
          ),
          const SizedBox(height: 10),
          _buildPriorityBarRow(
            l10n.translate('priorityLow'),
            low.completed,
            low.total,
            AppColors.primary,
            isFa,
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBarRow(
    String label,
    int completed,
    int total,
    Color color,
    bool isFa,
  ) {
    final percent = total > 0 ? (completed / total) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            Text(
              '${ZedDateUtils.toFaDigits(completed, fa: isFa)} / ${ZedDateUtils.toFaDigits(total, fa: isFa)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 6,
            backgroundColor: AppColors.surfaceContainerHigh,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  /// 7. Focus by Category Donut
  Widget _categoryDonut(AppLocalizations l10n, PlannerStore store, bool isFa) {
    final byCategory = store.focusMinutesByCategory;
    if (byCategory.isEmpty) {
      return GlassCard(
        child: Column(
          children: [
            Text(l10n.translate('focusByCategory'),
                style: AppTypography.headlineMd()),
            const SizedBox(height: 12),
            Text(l10n.translate('noCategoryData'),
                style: AppTypography.bodySm()),
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
          Text(l10n.translate('focusByCategory'),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DonutChartWidget(
                percentages: [for (final e in entries) e.value],
                colors: [
                  for (var i = 0; i < entries.length; i++)
                    _categoryColors[i % _categoryColors.length]
                ],
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
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color:
                                  _categoryColors[i % _categoryColors.length],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _categoryLabel(entries[i].key, l10n),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.onSurfaceVariant,
                            ),
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

  /// 8. Weekly Distractions Card
  Widget _weeklyDistractionsCard(
      AppLocalizations l10n, PlannerStore store, bool isFa) {
    final counts = store.distractionCountsLast7Days;
    final total = counts.fold<int>(0, (a, b) => a + b);
    final reasonCounts = store.weeklyReasonCounts;
    final maxCount = reasonCounts.isEmpty ? 1 : reasonCounts.first.value;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_paused_outlined,
                    size: 16, color: AppColors.warning),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.translate('weeklyDistractions'),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                ZedDateUtils.toFaDigits(total, fa: isFa),
                style: AppTypography.numericMd(
                    color: total > 0 ? AppColors.warning : AppColors.success),
              ),
            ],
          ),
          if (total == 0) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.emoji_events_rounded,
                    size: 16, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(l10n.translate('noDistractions'),
                      style: AppTypography.bodySm()),
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 14),
            SimpleBarChart(
              values: [for (final c in counts) c.toDouble()],
              labels: [
                for (var i = 6; i >= 0; i--)
                  ZedDateUtils.weekday(
                    DateTime.now().subtract(Duration(days: i)),
                    fa: isFa,
                    short: true,
                  ),
              ],
              barColor: AppColors.warning,
            ),
            const SizedBox(height: 16),
            Text(l10n.translate('topReasons'), style: AppTypography.labelCaps()),
            const SizedBox(height: 8),
            for (final entry in reasonCounts.take(4))
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            DistractionReasonSheet.reasonLabel(entry.key, l10n),
                            style: AppTypography.bodySm(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${ZedDateUtils.toFaDigits(entry.value, fa: isFa)} ${l10n.translate('times')}',
                          style: AppTypography.bodySm(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: entry.value / maxCount,
                        minHeight: 5,
                        backgroundColor: AppColors.surfaceContainerHigh,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.warning),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  String _categoryLabel(String key, AppLocalizations l10n) =>
      BlockFormSheet.categoryLabel(key, l10n);

  Widget _buildSkeleton() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(width: 150, height: 22),
                SizedBox(height: 8),
                SkeletonLine(width: 180, height: 12),
              ],
            ),
            SkeletonCircle(size: 40),
          ],
        ),
        SizedBox(height: 20),
        SkeletonCard(
          radius: 24,
          child: Row(
            children: [
              SkeletonCircle(size: 88),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(width: 130, height: 16),
                    SizedBox(height: 8),
                    SkeletonLine(height: 10),
                    SizedBox(height: 6),
                    SkeletonLine(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        SkeletonCard(
          radius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(width: 160, height: 14),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
