import 'package:flutter/material.dart';

import '../../core/controllers/planner_store.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/app_scope.dart';
import '../../core/widgets/fade_slide_in.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/progress_ring.dart';
import '../../core/widgets/skeleton.dart';
import '../../data/models/planner_models.dart';

class HomeTodayScreen extends StatefulWidget {
  final VoidCallback onStartFocus;
  final Function(String screen) onNavigate;
  final VoidCallback onOpenProfile;

  const HomeTodayScreen({
    super.key,
    required this.onStartFocus,
    required this.onNavigate,
    required this.onOpenProfile,
  });

  @override
  State<HomeTodayScreen> createState() => _HomeTodayScreenState();
}

class _HomeTodayScreenState extends State<HomeTodayScreen> with SimulatedFetchMixin {
  @override
  void initState() {
    super.initState();
    startSimulatedFetch();
  }

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.translate('goodMorning');
    if (hour < 18) return l10n.translate('goodAfternoon');
    return l10n.translate('goodEvening');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scope = AppScope.of(context);
    final store = scope.store;
    final isFa = l10n.isFa;

    if (isLoading) {
      return Scaffold(body: SafeArea(child: Shimmer(child: _buildSkeleton())));
    }

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          // Also rebuilds when the user switches calendar system or language.
          listenable: Listenable.merge([store, scope.settings]),
          builder: (context, _) {
            final todayTasks = store.todayTasks;
            final completion = store.todayCompletionRate;
            final blocks = store.blocksForDay(DateTime.now());
            final name = scope.settings.userName;
            final useJalali = scope.settings.useJalali;
            final initials = name.isEmpty
                ? '?'
                : name.trim().split(' ').where((w) => w.isNotEmpty).map((w) => w[0]).take(2).join();

            return CustomScrollView(
              slivers: [
                // Header
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.isEmpty ? _greeting(l10n) : '${_greeting(l10n)}، $name',
                                  style: AppTypography.headlineLgMobile(color: AppColors.primary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ZedDateUtils.fullDate(DateTime.now(), fa: isFa, jalali: useJalali),
                                  style: TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: widget.onOpenProfile,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryContainer,
                              child: Text(
                                initials,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Workload ring
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 80),
                      child: GlassCard(
                        child: Row(
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: completion * 100),
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, _) => ProgressRing(
                                percentage: value,
                                size: 88,
                                strokeWidth: 8,
                                primaryColor: AppColors.primary,
                                centerChild: Text(
                                  '${ZedDateUtils.toFaDigits(value.round(), fa: isFa)}٪',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.todayWorkload,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    todayTasks.isEmpty
                                        ? l10n.translate('workloadEmpty')
                                        : '${ZedDateUtils.toFaDigits(todayTasks.where((t) => t.isCompleted).length, fa: isFa)}/${ZedDateUtils.toFaDigits(todayTasks.length, fa: isFa)} ${l10n.translate('workloadProgress')}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.onSurfaceVariant,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Commitments
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 160),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.topCommitments,
                                style: AppTypography.labelCaps(color: AppColors.onSurfaceVariant),
                              ),
                              InkWell(
                                onTap: () => widget.onNavigate('tasks'),
                                child: Text(
                                  l10n.translate('viewAll'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: todayTasks.isEmpty
                                ? _miniEmpty(
                                    Icons.task_alt_rounded,
                                    l10n.translate('emptyTasksTitle'),
                                    l10n.translate('emptyTasksMessage'),
                                    l10n.translate('addTaskCta'),
                                    () => widget.onNavigate('tasks'),
                                  )
                                : Column(
                                    key: const ValueKey('commitment-list'),
                                    children: [
                                      for (final task in todayTasks.take(4))
                                        _buildCommitmentCard(l10n, store, task, isFa),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Today's habits — quick check/uncheck
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.translate('habitsTodayTitle'),
                                style: AppTypography.labelCaps(color: AppColors.onSurfaceVariant),
                              ),
                              InkWell(
                                onTap: () => widget.onNavigate('habits'),
                                child: Text(
                                  l10n.translate('viewAll'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: store.habits.isEmpty
                                ? _miniEmpty(
                                    Icons.autorenew,
                                    l10n.translate('emptyHabitsTitle'),
                                    l10n.translate('emptyHabitsMessage'),
                                    l10n.translate('addHabit'),
                                    () => widget.onNavigate('habits'),
                                  )
                                : _habitsCheckRow(l10n, store),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Timeline
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 240),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.translate('timelineToday'),
                                style: AppTypography.labelCaps(color: AppColors.onSurfaceVariant),
                              ),
                              InkWell(
                                onTap: () => widget.onNavigate('calendar'),
                                child: Text(
                                  l10n.translate('goToCalendar'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: blocks.isEmpty
                                ? _miniEmpty(
                                    Icons.event_available_rounded,
                                    l10n.translate('timelineEmpty'),
                                    l10n.translate('emptyBlocksCalendar'),
                                    l10n.translate('goToCalendar'),
                                    () => widget.onNavigate('calendar'),
                                  )
                                : Column(
                                    key: const ValueKey('timeline-list'),
                                    children: [
                                      for (final block in blocks)
                                        _buildTimelineEvent(l10n, block, isFa),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Discipline & Achievements Card
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  sliver: SliverToBoxAdapter(
                    child: FadeSlideIn(
                      delay: const Duration(milliseconds: 280),
                      child: GlassCard(
                        child: InkWell(
                          onTap: () => widget.onNavigate('achievements'),
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFB800).withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFFFFB800), width: 1.5),
                                ),
                                child: const Icon(Icons.emoji_events_rounded,
                                    color: Color(0xFFFFB800), size: 24),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          l10n.translate('achievements'),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(alpha: 0.12),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            '${ZedDateUtils.toFaDigits(store.disciplineScore, fa: isFa)} ${l10n.translate('disciplineScore')}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      l10n.translate('recentAchievements'),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isFa ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Horizontal tappable habit chips: tap to check/uncheck today's mark.
  Widget _habitsCheckRow(AppLocalizations l10n, PlannerStore store) {
    final habits = store.habits;
    final allDone = habits.every(store.habitDoneToday);
    return Column(
      key: const ValueKey('habits-row'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: habits.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, i) {
              final habit = habits[i];
              final done = store.habitDoneToday(habit);
              final color = Color(habit.colorValue);
              return GestureDetector(
                onTap: () => store.toggleHabitToday(habit),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: done ? color.withValues(alpha: 0.15) : AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: done ? color : AppColors.outlineVariant,
                      width: done ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedScale(
                        scale: done ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: Icon(
                          done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                          size: 18,
                          color: done ? color : AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        habit.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: done ? FontWeight.bold : FontWeight.normal,
                          color: done ? color : AppColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (allDone && habits.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.emoji_events_rounded, size: 14, color: AppColors.warning),
              const SizedBox(width: 6),
              Text(
                l10n.translate('allHabitsDone'),
                style: AppTypography.bodySm(color: AppColors.warning),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _miniEmpty(IconData icon, String title, String message, String action, VoidCallback onAction) {    return Container(
      key: ValueKey('empty-$title'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: AppColors.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(title, style: AppTypography.bodyLg(), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(message, style: AppTypography.bodySm(), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.tonal(onPressed: onAction, child: Text(action)),
        ],
      ),
    );
  }

  Widget _buildCommitmentCard(AppLocalizations l10n, PlannerStore store, TaskItem task, bool isFa) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border(right: BorderSide(color: AppColors.primary, width: 4)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 2)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: GestureDetector(
            onTap: () => store.toggleTaskDone(task),
            child: AnimatedScale(
              scale: task.isCompleted ? 1.0 : 0.92,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: task.isCompleted ? AppColors.success : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: task.isCompleted ? AppColors.success : AppColors.outlineVariant,
                    width: 2,
                  ),
                ),
                child: task.isCompleted ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
              ),
            ),
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              color: task.isCompleted ? AppColors.onSurfaceVariant : AppColors.onSurface,
            ),
            child: Text(task.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(
            '${l10n.translate('estimatedLabel')}: ${ZedDateUtils.toFaDigits(task.estimatedMinutes, fa: isFa)} ${l10n.minutes}',
            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
          ),
          trailing: task.isCommitment
              ? Icon(Icons.star_rounded, color: AppColors.primary, size: 20)
              : null,
        ),
      ),
    );
  }

  Widget _buildTimelineEvent(AppLocalizations l10n, TimeBlockItem block, bool isFa) {
    final color = Color(block.colorValue);
    final isNow = _blockIsNow(block);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 6, left: 12, right: 4),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isNow ? AppColors.primaryFixed : AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isNow ? AppColors.primary.withValues(alpha: 0.3) : AppColors.outlineVariant,
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ZedDateUtils.rangeLabel(block.startHour, block.durationHours, fa: isFa),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isNow ? AppColors.onPrimaryFixed : AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          block.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: block.isDone ? TextDecoration.lineThrough : null,
                            color: isNow ? AppColors.onPrimaryFixed : AppColors.onSurface,
                          ),
                        ),
                      ),
                      if (block.hasOutcome) ...[
                        const SizedBox(width: 4),
                        Icon(
                          block.isDone ? Icons.check_circle_rounded : Icons.cancel_rounded,
                          size: 13,
                          color: block.isDone
                              ? AppColors.success
                              : (isNow ? AppColors.onPrimaryFixed : AppColors.error),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _blockIsNow(TimeBlockItem block) {
    if (!ZedDateUtils.isToday(block.date)) return false;
    final now = DateTime.now();
    final h = now.hour + now.minute / 60;
    return h >= block.startHour && h < block.startHour + block.durationHours;
  }

  // Mirrors the loaded layout so the skeleton→content transition is seamless.
  Widget _buildSkeleton() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(width: 180, height: 22),
                SizedBox(height: 8),
                SkeletonLine(width: 110, height: 12),
              ],
            ),
            SkeletonCircle(size: 40),
          ],
        ),
        const SizedBox(height: 24),
        const SkeletonCard(
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
        const SizedBox(height: 24),
        for (var i = 0; i < 2; i++)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: SkeletonCard(
              radius: 16,
              child: Row(
                children: [
                  SkeletonLine(width: 20, height: 20, borderRadius: 10),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(height: 14),
                        SizedBox(height: 8),
                        SkeletonLine(width: 90, height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
