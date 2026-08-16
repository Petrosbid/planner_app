import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'dart:ui' show Color;

import '../controllers/planner_store.dart';
import 'notification_planner.dart';

/// Schedules the app's local notifications:
///  - time-block start / "did you do it?" end prompts, and
///  - the end-of-day wrap-up reminder.
///
/// All content is produced by the pure planners in [notification_planner];
/// this class only talks to the platform plugin. Unsupported platforms
/// (tests, desktop) no-op safely.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _enabled = true;
  int _seedColor = 0xFF3C51C2;

  bool get isReady => _initialized && _enabled;

  /// Initializes the plugin, channels, and timezone data. Safe to call once
  /// at startup; failures (missing plugin on tests/desktop) disable the service.
  Future<void> init({required int seedColor}) async {
    _seedColor = seedColor;
    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }
    try {
      tzdata.initializeTimeZones();

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const ios = DarwinInitializationSettings();
      await _plugin.initialize(const InitializationSettings(android: android, iOS: ios));

      // Android 13+ runtime permission; iOS uses the standard prompt.
      final androidImpl = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidImpl?.requestNotificationsPermission();
      await _plugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);

      await _ensureChannels();
      _initialized = true;
    } catch (_) {
      _initialized = false;
    }
  }

  void setSeedColor(int argb) => _seedColor = argb;

  Future<void> _ensureChannels() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.createNotificationChannel(const AndroidNotificationChannel(
      'blocks',
      'زمان‌بندی و بلوک‌ها',
      description: 'شروع و پایان بلوک‌های زمانی و ثبت نتیجه',
      importance: Importance.high,
    ));
    await androidImpl?.createNotificationChannel(const AndroidNotificationChannel(
      'daily',
      'یادآور جمع‌بندی روز',
      description: 'یادآوری پایان روز برای ثبت عادت‌ها و ارزیابی',
      importance: Importance.defaultImportance,
    ));
  }

  /// Enables or disables everything. When re-enabled, [reschedule] should be
  /// called with the current store.
  Future<void> setEnabled(bool enabled, PlannerStore store) async {
    _enabled = enabled;
    if (!_initialized) return;
    if (!enabled) {
      await _plugin.cancelAll();
      return;
    }
    await reschedule(store, fa: true);
  }

  /// Cancels everything and re-plans from the store's current blocks.
  /// Call on startup, after data changes, and after enabling notifications.
  Future<void> reschedule(PlannerStore store, {required bool fa}) async {
    if (!_initialized || !_enabled) return;
    try {
      await _plugin.cancelAll();

      final planned = BlockNotificationPlanner.plan(store.blocks, fa: fa);
      for (final n in planned) {
        await _schedule(n);
      }

      await _schedule(DailyReminderPlanner.plan(fa: fa));
    } catch (_) {
      // Scheduling is best-effort; never let it break the app.
    }
  }

  Future<void> _schedule(PlannedNotification n) async {
    final when = tz.TZDateTime.from(n.time, tz.local);

    final androidDetails = AndroidNotificationDetails(
      n.channel,
      n.channel == 'blocks' ? 'زمان‌بندی و بلوک‌ها' : 'یادآور جمع‌بندی روز',
      channelDescription: n.channel == 'blocks' ? 'شروع و پایان بلوک‌های زمانی' : 'ثبت عادت‌ها و ارزیابی روزانه',
      importance: n.channel == 'blocks' ? Importance.high : Importance.defaultImportance,
      priority: n.channel == 'blocks' ? Priority.high : Priority.defaultPriority,
      color: Color(_seedColor),
      colorized: true,
      category: AndroidNotificationCategory.reminder,
      styleInformation: BigTextStyleInformation(n.body, contentTitle: n.title),
    );

    const iosDetails = DarwinNotificationDetails();

    await _plugin.zonedSchedule(
      n.id,
      n.title,
      n.body,
      when,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: n.dailyRepeat ? DateTimeComponents.time : null,
    );
  }
}
