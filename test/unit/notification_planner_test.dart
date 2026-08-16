import 'package:flutter_test/flutter_test.dart';
import 'package:planner_app/core/notifications/notification_planner.dart';
import 'package:planner_app/data/models/planner_models.dart';

void main() {
  // A fixed "now": 2026-08-17 (Monday) 08:00.
  final now = DateTime(2026, 8, 17, 8);

  TimeBlockItem block(
    String id,
    double start,
    double duration, {
    DateTime? date,
  }) =>
      TimeBlockItem(
        id: id,
        title: 'بلوک $id',
        date: date ?? DateTime(2026, 8, 17),
        startHour: start,
        durationHours: duration,
      );

  group('BlockNotificationPlanner', () {
    test('plans start and end notifications for a future block', () {
      final planned = BlockNotificationPlanner.plan(
        [block('a', 10, 1.5)],
        fa: true,
        now: now,
      );

      expect(planned.length, 2);
      final start = planned.firstWhere((n) => n.id == 'a-start'.hashCode & 0x7FFFFFFF);
      final end = planned.firstWhere((n) => n.id == 'a-end'.hashCode & 0x7FFFFFFF);

      expect(start.time, DateTime(2026, 8, 17, 10));
      expect(start.title, contains('شروع'));
      expect(end.time, DateTime(2026, 8, 17, 11, 30));
      expect(end.title, contains('انجامش دادید'));
      expect(end.body, isNot(contains('بلوک بعدی')), reason: 'single block → no next line');
    });

    test('end notification names the next block of the day', () {
      final planned = BlockNotificationPlanner.plan(
        [block('a', 9, 1), block('b', 13, 1), block('c', 15, 1)],
        fa: true,
        now: now,
      );

      final endA = planned.firstWhere((n) => n.id == 'a-end'.hashCode & 0x7FFFFFFF);
      expect(endA.body, contains('بلوک b'));
      expect(endA.body, contains('۱۳:۰۰'));

      final endC = planned.firstWhere((n) => n.id == 'c-end'.hashCode & 0x7FFFFFFF);
      expect(endC.body, isNot(contains('بلوک بعدی')), reason: 'c is the last of the day');
    });

    test('skips blocks entirely in the past', () {
      final planned = BlockNotificationPlanner.plan(
        [block('past', 6, 1), block('future', 10, 1)],
        fa: true,
        now: now,
      );
      // Only the future block's start+end are planned.
      expect(planned.length, 2);
      expect(planned.every((n) => n.time.isAfter(now)), true);
    });

    test('still plans the end prompt for a block already running', () {
      // Started at 7:30 (before now=8:00), ends 8:30 → start skipped, end kept.
      final planned = BlockNotificationPlanner.plan(
        [block('running', 7.5, 1)],
        fa: true,
        now: now,
      );
      expect(planned.length, 1);
      expect(planned.single.id, 'running-end'.hashCode & 0x7FFFFFFF);
    });

    test('english content when fa is false', () {
      final planned = BlockNotificationPlanner.plan(
        [block('a', 10, 1)],
        fa: false,
        now: now,
      );
      expect(planned.first.title, startsWith('Starting:'));
      expect(planned.last.title, startsWith('Did you do it?'));
    });
  });

  group('DailyReminderPlanner', () {
    test('schedules today at 21:00 when still ahead', () {
      final n = DailyReminderPlanner.plan(fa: true, now: DateTime(2026, 8, 17, 20));
      expect(n.time, DateTime(2026, 8, 17, 21));
      expect(n.dailyRepeat, true);
      expect(n.channel, 'daily');
    });

    test('rolls to tomorrow when 21:00 already passed', () {
      final n = DailyReminderPlanner.plan(fa: true, now: DateTime(2026, 8, 17, 22));
      expect(n.time, DateTime(2026, 8, 18, 21));
    });
  });
}
