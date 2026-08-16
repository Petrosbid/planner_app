import '../../data/models/planner_models.dart';

/// One planned local notification, produced by the pure planners below so the
/// scheduling rules are unit-testable without the platform plugin.
class PlannedNotification {
  final int id;
  final DateTime time;
  final String title;
  final String body;
  final String channel; // 'blocks' | 'daily'
  final bool dailyRepeat;

  const PlannedNotification({
    required this.id,
    required this.time,
    required this.title,
    required this.body,
    required this.channel,
    this.dailyRepeat = false,
  });
}

/// Pure planner for time-block notifications.
///
/// For every future block it plans:
///  - a *start* notification when the block begins, and
///  - an *end* notification that asks whether the user did it and names the
///    next block of that day, if any.
class BlockNotificationPlanner {
  BlockNotificationPlanner._();

  static int _id(String key) => key.hashCode & 0x7FFFFFFF;

  static String _hourLabel(double hour, bool fa) {
    final h = hour.floor();
    final m = ((hour - h) * 60).round();
    final mm = m == 0 ? '00' : m.toString().padLeft(2, '0');
    final label = '${h.toString().padLeft(2, '0')}:$mm';
    if (!fa) return label;
    const digits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return label.replaceAllMapped(RegExp(r'\d'), (m) => digits[int.parse(m.group(0)!)]);
  }

  static String _rangeLabel(TimeBlockItem b, bool fa) =>
      '${_hourLabel(b.startHour, fa)} - ${_hourLabel(b.startHour + b.durationHours, fa)}';

  static List<PlannedNotification> plan(
    List<TimeBlockItem> blocks, {
    required bool fa,
    DateTime? now,
  }) {
    final result = <PlannedNotification>[];
    final current = now ?? DateTime.now();

    for (final block in blocks) {
      final start = DateTime(
        block.date.year, block.date.month, block.date.day,
        block.startHour.floor(), ((block.startHour % 1) * 60).round(),
      );
      final end = start.add(Duration(minutes: (block.durationHours * 60).round()));
      if (!end.isAfter(current)) continue; // fully in the past

      final range = _rangeLabel(block, fa);

      if (start.isAfter(current)) {
        result.add(PlannedNotification(
          id: _id('${block.id}-start'),
          time: start,
          channel: 'blocks',
          title: fa ? 'شروع: ${block.title}' : 'Starting: ${block.title}',
          body: fa
              ? 'بلوک زمانی شما آغاز شد ($range). وقت تمرکز است!'
              : 'Your time block has begun ($range). Focus time!',
        ));
      }

      if (end.isAfter(current)) {
        // The next block of the same day starting after this one ends.
        final sameDay = blocks.where((b) => b.date == block.date || _sameDay(b.date, block.date));
        TimeBlockItem? next;
        for (final b in sameDay) {
          if (b == block) continue;
          if (b.startHour >= block.startHour + block.durationHours - 0.01) {
            if (next == null || b.startHour < next.startHour) next = b;
          }
        }
        final nextLine = next == null
            ? ''
            : (fa
                ? '\n\n🔵 بلوک بعدی: «${next.title}» (${_hourLabel(next.startHour, fa)})'
                : '\n\n🔵 Up next: "${next.title}" (${_hourLabel(next.startHour, fa)})');
        result.add(PlannedNotification(
          id: _id('${block.id}-end'),
          time: end,
          channel: 'blocks',
          title: fa ? 'انجامش دادید؟ ${block.title}' : 'Did you do it? ${block.title}',
          body: (fa
                  ? 'بلوک «${block.title}» تمام شد ($range). وارد برنامه شوید و نتیجه را ثبت کنید.'
                  : 'The block "${block.title}" finished ($range). Open the app and submit the outcome.')
              + nextLine,
        ));
      }
    }

    return result;
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Pure planner for the end-of-day wrap-up reminder (default 21:00).
class DailyReminderPlanner {
  DailyReminderPlanner._();

  static int get id => 'daily-review-reminder'.hashCode & 0x7FFFFFFF;

  static PlannedNotification plan({required bool fa, DateTime? now, int hour = 21}) {
    final current = now ?? DateTime.now();
    var when = DateTime(current.year, current.month, current.day, hour);
    if (!when.isAfter(current)) {
      when = when.add(const Duration(days: 1));
    }
    return PlannedNotification(
      id: id,
      time: when,
      channel: 'daily',
      dailyRepeat: true,
      title: fa ? 'جمع‌بندی روز 🌙' : 'Wrap up your day 🌙',
      body: fa
          ? 'روزتان را ببندید: عادت‌های امروز را ثبت کنید، نتیجه وظایف و بلوک‌ها را مشخص کنید و ارزیابی روزانه را انجام دهید.'
          : 'Close your day: check off habits, submit task and block outcomes, and complete your daily review.',
    );
  }
}
