class CommitmentStats {
  final int totalCommitments;
  final int keptCommitments;
  final int postponedCommitments;
  final int cancelledCommitments;

  CommitmentStats({
    required this.totalCommitments,
    required this.keptCommitments,
    required this.postponedCommitments,
    required this.cancelledCommitments,
  });

  double get reliabilityRate =>
      totalCommitments > 0 ? (keptCommitments / totalCommitments) : 1.0;

  int get reliabilityPercentage => (reliabilityRate * 100).round();
}

class PlanningAccuracyStats {
  final int totalEstimatedMinutes;
  final int totalActualMinutes;
  final int taskCount;

  PlanningAccuracyStats({
    required this.totalEstimatedMinutes,
    required this.totalActualMinutes,
    required this.taskCount,
  });

  double get ratio =>
      totalEstimatedMinutes > 0 ? (totalActualMinutes / totalEstimatedMinutes) : 1.0;

  bool get isUnderestimating => ratio > 1.2;
  bool get isOverestimating => ratio < 0.8;

  String get feedbackMessage {
    if (taskCount == 0) return 'به اندازه کافی داده برای سنجش وجود ندارد.';
    if (isUnderestimating) {
      final diff = ((ratio - 1.0) * 100).round();
      return 'شما معمولاً زمان کارها را $diff٪ کمتر از حد واقعی تخمین می‌زنید.';
    } else if (isOverestimating) {
      final diff = ((1.0 - ratio) * 100).round();
      return 'شما معمولاً زمان کارها را $diff٪ بیشتر از حد واقعی تخمین می‌زنید.';
    }
    return 'دقت تخمین زمان شما فوق‌العاده و واقع‌بینانه است!';
  }
}

class WorkloadCapacityResult {
  final int scheduledMinutes;
  final int availableMinutes;
  final bool isOverloaded;

  WorkloadCapacityResult({
    required this.scheduledMinutes,
    required this.availableMinutes,
  }) : isOverloaded = scheduledMinutes > availableMinutes;

  double get workloadPercentage =>
      availableMinutes > 0 ? (scheduledMinutes / availableMinutes) * 100 : 0.0;

  String get summaryText {
    if (isOverloaded) {
      final overflow = scheduledMinutes - availableMinutes;
      final overflowHours = (overflow / 60).toStringAsFixed(1);
      return 'برنامه امروز شما $overflowHours ساعت بیشتر از ظرفیت روزانه است. سرعت خود را تنظیم کنید.';
    }
    return 'فشار کاری امروز متناسب با ظرفیت شماست.';
  }
}

class BehavioralInsightItem {
  final String id;
  final String title;
  final String message;
  final String type; // underestimation, overplanning, peak_energy, commitment_lag
  final String severity; // info, warning, tip

  BehavioralInsightItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.severity,
  });
}

class BehavioralEngine {
  static CommitmentStats calculateCommitments(List<dynamic> tasks) {
    int total = 0;
    int kept = 0;
    int postponed = 0;
    int cancelled = 0;

    for (var task in tasks) {
      // task duck typing or entity inspection
      final isCommitment = task.isCommitment ?? false;
      if (!isCommitment) continue;

      total++;
      final status = task.status;
      if (status == 'completed') {
        kept++;
      } else if (status == 'postponed') {
        postponed++;
      } else if (status == 'cancelled') {
        cancelled++;
      }
    }

    return CommitmentStats(
      totalCommitments: total,
      keptCommitments: kept,
      postponedCommitments: postponed,
      cancelledCommitments: cancelled,
    );
  }

  static PlanningAccuracyStats calculatePlanningAccuracy(List<dynamic> tasks) {
    int estimated = 0;
    int actual = 0;
    int count = 0;

    for (var task in tasks) {
      if (task.status == 'completed' && (task.actualDurationMinutes ?? 0) > 0) {
        estimated += (task.estimatedDurationMinutes ?? 30) as int;
        actual += (task.actualDurationMinutes ?? 0) as int;
        count++;
      }
    }

    return PlanningAccuracyStats(
      totalEstimatedMinutes: estimated,
      totalActualMinutes: actual,
      taskCount: count,
    );
  }

  static WorkloadCapacityResult checkOverload({
    required int scheduledMinutes,
    int availableMinutes = 390, // Default 6.5 hours daily deep work capacity
  }) {
    return WorkloadCapacityResult(
      scheduledMinutes: scheduledMinutes,
      availableMinutes: availableMinutes,
    );
  }

  static List<BehavioralInsightItem> generateInsights({
    required PlanningAccuracyStats accuracyStats,
    required WorkloadCapacityResult capacityResult,
    required CommitmentStats commitmentStats,
  }) {
    final List<BehavioralInsightItem> list = [];

    if (accuracyStats.isUnderestimating && accuracyStats.taskCount >= 3) {
      list.add(BehavioralInsightItem(
        id: 'underestimation_warning',
        title: 'الگوی کم‌تخمینی زمان',
        message: accuracyStats.feedbackMessage,
        type: 'underestimation',
        severity: 'warning',
      ));
    }

    if (capacityResult.isOverloaded) {
      list.add(BehavioralInsightItem(
        id: 'overplanning_alert',
        title: 'تکمیل بیش از ظرفیت',
        message: capacityResult.summaryText,
        type: 'overplanning',
        severity: 'warning',
      ));
    }

    if (commitmentStats.reliabilityRate >= 0.8 && commitmentStats.totalCommitments >= 3) {
      list.add(BehavioralInsightItem(
        id: 'high_reliability_tip',
        title: 'پایبندی عالی به تعهدات',
        message: 'شما به ${commitmentStats.reliabilityPercentage}٪ از تعهدات خود عمل کرده‌اید. این روند را حفظ کنید.',
        type: 'commitment_lag',
        severity: 'tip',
      ));
    }

    // Default encouragement insight if list empty
    if (list.isEmpty) {
      list.add(BehavioralInsightItem(
        id: 'default_insight',
        title: 'تمرکز و ریتم روزانه',
        message: 'کارهای بزرگ را به گام‌های کوچک و قابل مدیریت تقسیم کنید.',
        type: 'peak_energy',
        severity: 'info',
      ));
    }

    return list;
  }
}
