import 'package:flutter_test/flutter_test.dart';
import 'package:planner_app/domain/engines/behavioral_engine.dart';

class MockTask {
  final bool isCommitment;
  final String status;
  final int estimatedDurationMinutes;
  final int actualDurationMinutes;

  MockTask({
    required this.isCommitment,
    required this.status,
    required this.estimatedDurationMinutes,
    required this.actualDurationMinutes,
  });
}

void main() {
  group('BehavioralEngine Tests', () {
    test('Commitment Reliability Calculation', () {
      final tasks = [
        MockTask(isCommitment: true, status: 'completed', estimatedDurationMinutes: 60, actualDurationMinutes: 60),
        MockTask(isCommitment: true, status: 'completed', estimatedDurationMinutes: 30, actualDurationMinutes: 45),
        MockTask(isCommitment: true, status: 'postponed', estimatedDurationMinutes: 45, actualDurationMinutes: 0),
        MockTask(isCommitment: false, status: 'completed', estimatedDurationMinutes: 20, actualDurationMinutes: 20),
      ];

      final stats = BehavioralEngine.calculateCommitments(tasks);
      expect(stats.totalCommitments, equals(3));
      expect(stats.keptCommitments, equals(2));
      expect(stats.postponedCommitments, equals(1));
      expect(stats.reliabilityPercentage, equals(67));
    });

    test('Planning Accuracy Underestimation Test', () {
      final tasks = [
        MockTask(isCommitment: true, status: 'completed', estimatedDurationMinutes: 30, actualDurationMinutes: 60),
        MockTask(isCommitment: true, status: 'completed', estimatedDurationMinutes: 60, actualDurationMinutes: 90),
      ];

      final accuracy = BehavioralEngine.calculatePlanningAccuracy(tasks);
      expect(accuracy.totalEstimatedMinutes, equals(90));
      expect(accuracy.totalActualMinutes, equals(150));
      expect(accuracy.isUnderestimating, isTrue);
    });

    test('Workload Overload Detection', () {
      final resultOverloaded = BehavioralEngine.checkOverload(scheduledMinutes: 480, availableMinutes: 390);
      expect(resultOverloaded.isOverloaded, isTrue);

      final resultNormal = BehavioralEngine.checkOverload(scheduledMinutes: 300, availableMinutes: 390);
      expect(resultNormal.isOverloaded, isFalse);
    });
  });
}
