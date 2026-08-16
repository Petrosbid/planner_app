import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/aura_charts.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';

class WeeklyReviewScreen extends StatefulWidget {
  const WeeklyReviewScreen({super.key});

  @override
  State<WeeklyReviewScreen> createState() => _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends State<WeeklyReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;
    final hasData = store.tasks.isNotEmpty || store.focusRecords.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.weeklyReviewTitle)),
      body: SafeArea(
        child: !hasData
            ? EmptyStateView(
                icon: Icons.insights_outlined,
                title: l10n.translate('emptyWeeklyTitle'),
                message: l10n.translate('emptyWeeklyMessage'),
              )
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  FadeSlideIn(
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.translate('weeklyFocus'), style: AppTypography.headlineMd()),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 160,
                            child: SimpleBarChart(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 80),
                    child: Row(
                      children: [
                        Expanded(
                          child: _metricCard(
                            l10n.translate('executionRate'),
                            '${ZedDateUtils.toFaDigits((store.executionRate * 100).round(), fa: isFa)}٪',
                            AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _metricCard(
                            l10n.commitmentReliability,
                            '${ZedDateUtils.toFaDigits((store.commitmentReliability * 100).round(), fa: isFa)}٪',
                            AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 160),
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.translate('focusTodayStat'), style: AppTypography.headlineMd()),
                          const SizedBox(height: 12),
                          Text(
                            '${ZedDateUtils.toFaDigits(store.todayFocusMinutes, fa: isFa)} ${l10n.translate('minutesStat')} · ${ZedDateUtils.toFaDigits(store.todayFocusRecords.length, fa: isFa)} ${l10n.translate('sessionsStat')}',
                            style: AppTypography.bodyLg(),
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

  Widget _metricCard(String label, String value, Color color) {
    return GlassCard(
      child: Column(
        children: [
          Text(label, style: AppTypography.bodySm(), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
