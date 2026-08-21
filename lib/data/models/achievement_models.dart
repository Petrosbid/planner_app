import 'package:flutter/material.dart';
import '../../core/controllers/planner_store.dart';

enum AchievementCategory {
  discipline,
  focus,
  habits,
  planning,
  mastery,
}

enum AchievementTier {
  bronze,
  silver,
  gold,
  diamond;

  String get label {
    switch (this) {
      case AchievementTier.bronze:
        return 'برنز';
      case AchievementTier.silver:
        return 'نقره';
      case AchievementTier.gold:
        return 'طلا';
      case AchievementTier.diamond:
        return 'الماس';
    }
  }

  Color get color {
    switch (this) {
      case AchievementTier.bronze:
        return const Color(0xFFCD7F32);
      case AchievementTier.silver:
        return const Color(0xFFA0AAB2);
      case AchievementTier.gold:
        return const Color(0xFFFFB800);
      case AchievementTier.diamond:
        return const Color(0xFF00E5FF);
    }
  }

  Color get glowColor {
    switch (this) {
      case AchievementTier.bronze:
        return const Color(0x66CD7F32);
      case AchievementTier.silver:
        return const Color(0x66A0AAB2);
      case AchievementTier.gold:
        return const Color(0x80FFB800);
      case AchievementTier.diamond:
        return const Color(0x8000E5FF);
    }
  }
}

class TierThreshold {
  final AchievementTier tier;
  final double value;

  const TierThreshold(this.tier, this.value);
}

class AchievementDefinition {
  final String id;
  final AchievementCategory category;
  final String titleKey;
  final String descKey;
  final IconData iconData;
  final List<TierThreshold> thresholds;
  final double Function(PlannerStore store) progressCalculator;
  final String unitKey;

  const AchievementDefinition({
    required this.id,
    required this.category,
    required this.titleKey,
    required this.descKey,
    required this.iconData,
    required this.thresholds,
    required this.progressCalculator,
    this.unitKey = '',
  });

  /// Get current unlocked tier for given progress value
  AchievementTier? getUnlockedTier(double progress) {
    AchievementTier? highest;
    for (final t in thresholds) {
      if (progress >= t.value) {
        highest = t.tier;
      }
    }
    return highest;
  }

  /// Get next tier to unlock and its target value
  TierThreshold? getNextThreshold(double progress) {
    for (final t in thresholds) {
      if (progress < t.value) {
        return t;
      }
    }
    return null; // All tiers completed
  }

  /// Max threshold value
  double get maxTarget => thresholds.isNotEmpty ? thresholds.last.value : 1.0;
}

class AchievementProgress {
  final AchievementDefinition definition;
  final double currentProgress;
  final AchievementTier? unlockedTier;
  final TierThreshold? nextThreshold;
  final DateTime? unlockedAt;

  const AchievementProgress({
    required this.definition,
    required this.currentProgress,
    this.unlockedTier,
    this.nextThreshold,
    this.unlockedAt,
  });

  bool get isUnlocked => unlockedTier != null;
  bool get isMaxedOut => nextThreshold == null && isUnlocked;

  double get percentToNext {
    if (isMaxedOut) return 1.0;
    final target = nextThreshold?.value ?? definition.maxTarget;
    if (target == 0) return 0.0;
    return (currentProgress / target).clamp(0.0, 1.0);
  }
}

class AchievementCatalog {
  AchievementCatalog._();

  static final List<AchievementDefinition> allAchievements = [
    // ----------------- DISCIPLINE -----------------
    AchievementDefinition(
      id: 'task_finisher',
      category: AchievementCategory.discipline,
      titleKey: 'ach_task_finisher_title',
      descKey: 'ach_task_finisher_desc',
      iconData: Icons.check_circle_outline_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 5),
        TierThreshold(AchievementTier.silver, 25),
        TierThreshold(AchievementTier.gold, 100),
        TierThreshold(AchievementTier.diamond, 300),
      ],
      progressCalculator: (store) =>
          store.tasks.where((t) => t.isCompleted).length.toDouble(),
      unitKey: 'tasks',
    ),
    AchievementDefinition(
      id: 'commitment_champion',
      category: AchievementCategory.discipline,
      titleKey: 'ach_commitment_title',
      descKey: 'ach_commitment_desc',
      iconData: Icons.star_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 3),
        TierThreshold(AchievementTier.silver, 15),
        TierThreshold(AchievementTier.gold, 50),
        TierThreshold(AchievementTier.diamond, 150),
      ],
      progressCalculator: (store) => store.tasks
          .where((t) => t.isCommitment && t.isCompleted)
          .length
          .toDouble(),
      unitKey: 'tasks',
    ),
    AchievementDefinition(
      id: 'zero_postpone',
      category: AchievementCategory.discipline,
      titleKey: 'ach_zero_postpone_title',
      descKey: 'ach_zero_postpone_desc',
      iconData: Icons.flash_on_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 5),
        TierThreshold(AchievementTier.silver, 20),
        TierThreshold(AchievementTier.gold, 60),
        TierThreshold(AchievementTier.diamond, 150),
      ],
      progressCalculator: (store) => store.tasks
          .where((t) => t.isCompleted && t.postponementCount == 0)
          .length
          .toDouble(),
      unitKey: 'tasks',
    ),
    AchievementDefinition(
      id: 'daily_streak',
      category: AchievementCategory.discipline,
      titleKey: 'ach_daily_streak_title',
      descKey: 'ach_daily_streak_desc',
      iconData: Icons.local_fire_department_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 3),
        TierThreshold(AchievementTier.silver, 7),
        TierThreshold(AchievementTier.gold, 21),
        TierThreshold(AchievementTier.diamond, 60),
      ],
      progressCalculator: (store) => store.dailyTaskStreak.toDouble(),
      unitKey: 'days',
    ),

    // ----------------- FOCUS -----------------
    AchievementDefinition(
      id: 'focus_master',
      category: AchievementCategory.focus,
      titleKey: 'ach_focus_master_title',
      descKey: 'ach_focus_master_desc',
      iconData: Icons.timer_outlined,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 60), // 1 hour
        TierThreshold(AchievementTier.silver, 300), // 5 hours
        TierThreshold(AchievementTier.gold, 1200), // 20 hours
        TierThreshold(AchievementTier.diamond, 3600), // 60 hours
      ],
      progressCalculator: (store) => store.totalFocusMinutes.toDouble(),
      unitKey: 'minutes',
    ),
    AchievementDefinition(
      id: 'deep_work_unbroken',
      category: AchievementCategory.focus,
      titleKey: 'ach_deep_unbroken_title',
      descKey: 'ach_deep_unbroken_desc',
      iconData: Icons.shield_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 3),
        TierThreshold(AchievementTier.silver, 10),
        TierThreshold(AchievementTier.gold, 30),
        TierThreshold(AchievementTier.diamond, 100),
      ],
      progressCalculator: (store) =>
          store.focusRecords.where((f) => f.interruptions == 0).length.toDouble(),
      unitKey: 'sessions',
    ),
    AchievementDefinition(
      id: 'focus_marathon',
      category: AchievementCategory.focus,
      titleKey: 'ach_focus_marathon_title',
      descKey: 'ach_focus_marathon_desc',
      iconData: Icons.directions_run_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 25),
        TierThreshold(AchievementTier.silver, 50),
        TierThreshold(AchievementTier.gold, 90),
        TierThreshold(AchievementTier.diamond, 120),
      ],
      progressCalculator: (store) => store.longestFocusSessionMinutes.toDouble(),
      unitKey: 'minutes',
    ),

    // ----------------- HABITS -----------------
    AchievementDefinition(
      id: 'habit_builder',
      category: AchievementCategory.habits,
      titleKey: 'ach_habit_builder_title',
      descKey: 'ach_habit_builder_desc',
      iconData: Icons.autorenew_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 1),
        TierThreshold(AchievementTier.silver, 3),
        TierThreshold(AchievementTier.gold, 5),
        TierThreshold(AchievementTier.diamond, 10),
      ],
      progressCalculator: (store) => store.habits.length.toDouble(),
      unitKey: 'habits',
    ),
    AchievementDefinition(
      id: 'habit_streak_king',
      category: AchievementCategory.habits,
      titleKey: 'ach_habit_streak_title',
      descKey: 'ach_habit_streak_desc',
      iconData: Icons.emoji_events_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 5),
        TierThreshold(AchievementTier.silver, 14),
        TierThreshold(AchievementTier.gold, 30),
        TierThreshold(AchievementTier.diamond, 90),
      ],
      progressCalculator: (store) => store.bestHabitStreakAllTime.toDouble(),
      unitKey: 'days',
    ),
    AchievementDefinition(
      id: 'perfect_habit_day',
      category: AchievementCategory.habits,
      titleKey: 'ach_perfect_habit_day_title',
      descKey: 'ach_perfect_habit_day_desc',
      iconData: Icons.verified_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 3),
        TierThreshold(AchievementTier.silver, 10),
        TierThreshold(AchievementTier.gold, 30),
        TierThreshold(AchievementTier.diamond, 75),
      ],
      progressCalculator: (store) => store.perfectHabitDaysCount.toDouble(),
      unitKey: 'days',
    ),

    // ----------------- PLANNING -----------------
    AchievementDefinition(
      id: 'time_blocker',
      category: AchievementCategory.planning,
      titleKey: 'ach_time_blocker_title',
      descKey: 'ach_time_blocker_desc',
      iconData: Icons.calendar_month_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 5),
        TierThreshold(AchievementTier.silver, 20),
        TierThreshold(AchievementTier.gold, 75),
        TierThreshold(AchievementTier.diamond, 200),
      ],
      progressCalculator: (store) => store.blocks.length.toDouble(),
      unitKey: 'blocks',
    ),
    AchievementDefinition(
      id: 'outcome_tracker',
      category: AchievementCategory.planning,
      titleKey: 'ach_outcome_tracker_title',
      descKey: 'ach_outcome_tracker_desc',
      iconData: Icons.assignment_turned_in_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 5),
        TierThreshold(AchievementTier.silver, 25),
        TierThreshold(AchievementTier.gold, 80),
        TierThreshold(AchievementTier.diamond, 200),
      ],
      progressCalculator: (store) =>
          store.blocks.where((b) => b.hasOutcome).length.toDouble(),
      unitKey: 'outcomes',
    ),
    AchievementDefinition(
      id: 'daily_reflector',
      category: AchievementCategory.planning,
      titleKey: 'ach_reflector_title',
      descKey: 'ach_reflector_desc',
      iconData: Icons.rate_review_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 3),
        TierThreshold(AchievementTier.silver, 14),
        TierThreshold(AchievementTier.gold, 30),
        TierThreshold(AchievementTier.diamond, 90),
      ],
      progressCalculator: (store) => store.reviews.length.toDouble(),
      unitKey: 'reviews',
    ),

    // ----------------- MASTERY -----------------
    AchievementDefinition(
      id: 'goal_setter',
      category: AchievementCategory.mastery,
      titleKey: 'ach_goal_setter_title',
      descKey: 'ach_goal_setter_desc',
      iconData: Icons.flag_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 1),
        TierThreshold(AchievementTier.silver, 3),
        TierThreshold(AchievementTier.gold, 7),
        TierThreshold(AchievementTier.diamond, 15),
      ],
      progressCalculator: (store) => store.goals.length.toDouble(),
      unitKey: 'goals',
    ),
    AchievementDefinition(
      id: 'note_collector',
      category: AchievementCategory.mastery,
      titleKey: 'ach_note_collector_title',
      descKey: 'ach_note_collector_desc',
      iconData: Icons.notes_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 3),
        TierThreshold(AchievementTier.silver, 15),
        TierThreshold(AchievementTier.gold, 45),
        TierThreshold(AchievementTier.diamond, 100),
      ],
      progressCalculator: (store) => store.notes.length.toDouble(),
      unitKey: 'notes',
    ),
    AchievementDefinition(
      id: 'discipline_master',
      category: AchievementCategory.mastery,
      titleKey: 'ach_discipline_master_title',
      descKey: 'ach_discipline_master_desc',
      iconData: Icons.military_tech_rounded,
      thresholds: const [
        TierThreshold(AchievementTier.bronze, 50),
        TierThreshold(AchievementTier.silver, 70),
        TierThreshold(AchievementTier.gold, 85),
        TierThreshold(AchievementTier.diamond, 95),
      ],
      progressCalculator: (store) => store.disciplineScore.toDouble(),
      unitKey: 'score',
    ),
  ];
}
