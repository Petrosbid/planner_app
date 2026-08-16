import 'package:flutter_test/flutter_test.dart';
import 'package:planner_app/core/controllers/planner_store.dart';
import 'package:planner_app/data/models/planner_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late PlannerStore store;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    store = PlannerStore(prefs);
  });

  test('addTask persists and reloads from SharedPreferences', () async {
    await store.addTask(title: 'اولین وظیفه', estimatedMinutes: 45, isCommitment: true);
    await store.addTask(title: 'دومین وظیفه');

    // Same prefs instance → a fresh store must see the same data.
    final prefs = await SharedPreferences.getInstance();
    final reloaded = PlannerStore(prefs);
    expect(reloaded.tasks.length, 2);
    // New tasks are inserted first, so the newest is at the head.
    expect(reloaded.tasks.first.title, 'دومین وظیفه');
    expect(reloaded.tasks.last.isCommitment, true);
    expect(reloaded.tasks.last.estimatedMinutes, 45);
  });

  test('toggleTaskDone flips completion and updates today rate', () async {
    final a = await store.addTask(title: 'a');
    await store.addTask(title: 'b');
    expect(store.todayCompletionRate, 0);

    await store.toggleTaskDone(a);
    expect(a.isCompleted, true);
    expect(store.todayCompletionRate, 0.5);

    await store.toggleTaskDone(a);
    expect(a.isCompleted, false);
  });

  test('habit streak counts consecutive days ending today', () async {
    final habit = await store.addHabit(title: 'مطالعه');
    final now = DateTime.now();

    // Mark today and the two previous days.
    for (var i = 0; i <= 2; i++) {
      final d = now.subtract(Duration(days: i));
      habit.markedDays.add('${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}');
    }
    expect(store.habitStreak(habit), 3);
    expect(store.habitDoneToday(habit), true);
  });

  test('toggleHabitToday marks and unmarks today', () async {
    final habit = await store.addHabit(title: 'ورزش');
    expect(store.habitDoneToday(habit), false);

    await store.toggleHabitToday(habit);
    expect(store.habitDoneToday(habit), true);

    await store.toggleHabitToday(habit);
    expect(store.habitDoneToday(habit), false);
  });

  test('plannedHoursForDay sums block durations for that day only', () async {
    final today = DateTime.now();
    final other = DateTime.now().add(const Duration(days: 1));
    await store.addBlock(title: 'deep', date: today, startHour: 9, durationHours: 2);
    await store.addBlock(title: 'meeting', date: today, startHour: 14, durationHours: 1.5);
    await store.addBlock(title: 'other day', date: other, startHour: 10, durationHours: 3);

    expect(store.plannedHoursForDay(today), 3.5);
    expect(store.plannedHoursForDay(other), 3);
    expect(store.blocksForDay(today).length, 2);
  });

  test('conflictingBlock detects overlaps but allows touching ranges', () async {
    final today = DateTime.now();
    await store.addBlock(title: 'busy', date: today, startHour: 10, durationHours: 2); // 10:00–12:00

    // Fully inside → conflict.
    expect(store.conflictingBlock(today, 10.5, 1)?.title, 'busy');
    // Partial overlap at the edges → conflict.
    expect(store.conflictingBlock(today, 9, 1.5)?.title, 'busy');
    expect(store.conflictingBlock(today, 11.5, 1)?.title, 'busy');
    // Touching boundaries (end == start) → allowed.
    expect(store.conflictingBlock(today, 8, 2), isNull); // ends at 10:00
    expect(store.conflictingBlock(today, 12, 1), isNull); // starts at 12:00
    // Completely separate → allowed.
    expect(store.conflictingBlock(today, 20, 2), isNull);
    // Other day → allowed.
    expect(store.conflictingBlock(today.add(const Duration(days: 1)), 10, 2), isNull);
  });

  test('custom categories persist and reject duplicates', () async {
    expect(store.allCategories, containsAll(['deep', 'meeting', 'review']));

    expect(await store.addCustomCategory('ورزش'), true);
    expect(store.allCategories, contains('ورزش'));

    // Duplicate (case-insensitive, even vs built-in) is rejected.
    expect(await store.addCustomCategory('ورزش'), false);
    expect(await store.addCustomCategory('Deep'), false);
    expect(await store.addCustomCategory('  '), false);

    // Custom categories get a stable color from the palette.
    final c1 = PlannerStore.categoryColor('ورزش');
    expect(c1, PlannerStore.categoryColor('ورزش'));
    expect(PlannerStore.categoryColor('deep'), 0xFF3C51C2);

    // Reload from the same prefs keeps the category.
    final prefs = await SharedPreferences.getInstance();
    expect(PlannerStore(prefs).customCategories, contains('ورزش'));
  });

  test('block outcome persists and reloads', () async {
    final block = await store.addBlock(title: 'deep session', date: DateTime.now(), startHour: 10);
    expect(block.isDone, false);
    expect(block.hasOutcome, false);

    block.isDone = true;
    block.hasOutcome = true;
    await store.updateBlock(block);

    final prefs = await SharedPreferences.getInstance();
    final reloaded = PlannerStore(prefs);
    expect(reloaded.blocks.first.isDone, true);
    expect(reloaded.blocks.first.hasOutcome, true);
  });

  test('distractions record, persist, and aggregate weekly', () async {
    await store.addDistraction(reason: 'phone', relatedTitle: 'کار عمیق');
    await store.addDistraction(reason: 'phone');
    await store.addDistraction(reason: 'lowEnergy');

    // All today → last day of the 7-day series has all three.
    expect(store.todayDistractions.length, 3);
    expect(store.distractionCountsLast7Days.last, 3);
    expect(store.distractionCountsLast7Days.reduce((a, b) => a + b), 3);

    // Top reason is the most frequent one.
    final reasons = store.weeklyReasonCounts;
    expect(reasons.first.key, 'phone');
    expect(reasons.first.value, 2);
    expect(reasons.length, 2);

    // Reload keeps records.
    final prefs = await SharedPreferences.getInstance();
    expect(PlannerStore(prefs).distractions.length, 3);
  });

  test('custom reasons persist and reject duplicates', () async {
    expect(store.allReasons.length, PlannerStore.builtInReasons.length);

    expect(await store.addCustomReason('سر و صدا'), true);
    expect(store.allReasons, contains('سر و صدا'));

    expect(await store.addCustomReason('سر و صدا'), false);
    expect(await store.addCustomReason('Phone'), false); // clashes with built-in key
    expect(await store.addCustomReason(''), false);

    final prefs = await SharedPreferences.getInstance();
    expect(PlannerStore(prefs).customReasons, contains('سر و صدا'));
  });

  test('recordFocus rolls up into today stats and weekly series', () async {
    // Fixed midday timestamp so a 50-minute session never crosses midnight.
    final noon = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12);
    await store.recordFocus(minutes: 25, at: noon);
    await store.recordFocus(minutes: 50, interruptions: 2, at: noon);

    expect(store.todayFocusMinutes, 75);
    expect(store.todayFocusRecords.length, 2);
    expect(store.weeklyFocusMinutes.last, 75);
    expect(store.weeklyFocusMinutes.every((m) => m >= 0), true);
  });

  test('executionRate and commitmentReliability compute from real data', () async {
    final a = await store.addTask(title: 'a', isCommitment: true);
    await store.addTask(title: 'b', isCommitment: true);
    await store.addTask(title: 'c');
    await store.toggleTaskDone(a);

    expect(store.executionRate, closeTo(1 / 3, 0.001));
    expect(store.commitmentReliability, 0.5);
  });

  test('saveDailyReview replaces the same-day record', () async {
    await store.saveDailyReview(DailyReviewRecord(date: DateTime.now(), energyRating: 2));
    await store.saveDailyReview(DailyReviewRecord(date: DateTime.now(), energyRating: 5));

    expect(store.reviews.length, 1);
    expect(store.todayReview?.energyRating, 5);
  });

  test('clearAll empties every collection', () async {
    await store.addTask(title: 't');
    await store.addHabit(title: 'h');
    await store.addNote(title: 'n');
    await store.recordFocus(minutes: 10);

    await store.clearAll();

    expect(store.tasks, isEmpty);
    expect(store.habits, isEmpty);
    expect(store.notes, isEmpty);
    expect(store.focusRecords, isEmpty);
  });
}
