import 'package:flutter/material.dart';

import '../../core/controllers/planner_store.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';
import '../../data/models/planner_models.dart';

class HabitsConsistencyScreen extends StatefulWidget {
  const HabitsConsistencyScreen({super.key});

  @override
  State<HabitsConsistencyScreen> createState() => _HabitsConsistencyScreenState();
}

class _HabitsConsistencyScreenState extends State<HabitsConsistencyScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final store = AppScope.of(context).store;
    final isFa = l10n.isFa;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.translate('habitsTitle')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: l10n.translate('addHabit'),
            onPressed: () => _showAddHabitSheet(l10n),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final habits = store.habits;
            return habits.isEmpty
                ? EmptyStateShim(l10n: l10n, onAdd: () => _showAddHabitSheet(l10n))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                    itemCount: habits.length,
                    itemBuilder: (ctx, i) {
                      final habit = habits[i];
                      return FadeSlideIn(
                        key: ValueKey(habit.id),
                        delay: Duration(milliseconds: 40 * (i < 8 ? i : 8)),
                        child: _habitCard(l10n, store, habit, isFa),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  Widget _habitCard(AppLocalizations l10n, PlannerStore store, HabitItem habit, bool isFa) {
    final color = Color(habit.colorValue);
    final doneToday = store.habitDoneToday(habit);
    final streak = store.habitStreak(habit);
    final doneCount = habit.markedDays.length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  habit.title,
                  style: AppTypography.headlineMd(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedScale(
                scale: doneToday ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  onPressed: () => store.toggleHabitToday(habit),
                  icon: Icon(
                    doneToday ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    color: doneToday ? AppColors.success : AppColors.outlineVariant,
                    size: 28,
                  ),
                  tooltip: l10n.translate('doneToday'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.local_fire_department_outlined, size: 16, color: AppColors.warning),
              const SizedBox(width: 4),
              Text(
                '${l10n.translate('streakLabel')}: ${ZedDateUtils.toFaDigits(streak, fa: isFa)} ${l10n.translate('day')}',
                style: AppTypography.bodySm(),
              ),
              const SizedBox(width: 16),
              Icon(Icons.task_alt_rounded, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                '${ZedDateUtils.toFaDigits(doneCount, fa: isFa)} ${l10n.translate('filterDone')}',
                style: AppTypography.bodySm(),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.error),
                tooltip: l10n.translate('delete'),
                onPressed: () => store.deleteHabit(habit),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(l10n.translate('last30Days'), style: AppTypography.labelCaps()),
          const SizedBox(height: 8),
          _heatmap(store, habit, color),
        ],
      ),
      ),
    );
  }

  /// Last 30 days of marks, oldest → newest.
  Widget _heatmap(PlannerStore store, HabitItem habit, Color color) {
    final days = List<DateTime>.generate(30, (i) => DateTime.now().subtract(Duration(days: 29 - i)));
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          for (final day in days)
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: habit.markedDays.contains(
                              '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}')
                          ? color
                          : AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showAddHabitSheet(AppLocalizations l10n) async {
    final controller = TextEditingController();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.translate('addHabit'), style: AppTypography.headlineMd()),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.translate('habitTitleHint'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    final title = controller.text.trim();
                    if (title.isEmpty) return;
                    AppScope.of(context).store.addHabit(title: title);
                    Navigator.of(ctx).pop();
                  },
                  child: Text(l10n.translate('save')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyStateShim extends StatelessWidget {
  final AppLocalizations l10n;
  final VoidCallback onAdd;

  const EmptyStateShim({super.key, required this.l10n, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return EmptyStateView(
      icon: Icons.autorenew,
      title: l10n.translate('emptyHabitsTitle'),
      message: l10n.translate('emptyHabitsMessage'),
      actionLabel: l10n.translate('addHabit'),
      onAction: onAdd,
    );
  }
}
