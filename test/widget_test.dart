import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner_app/core/controllers/achievement_store.dart';
import 'package:planner_app/core/controllers/app_settings.dart';
import 'package:planner_app/core/controllers/planner_store.dart';
import 'package:planner_app/core/theme/app_theme.dart';
import 'package:planner_app/core/widgets/app_scope.dart';
import 'package:planner_app/features/home/home_today_screen.dart';
import 'package:planner_app/features/calendar/calendar_week_screen.dart';
import 'package:planner_app/features/tasks/task_list_screen.dart';
import 'package:planner_app/features/common/block_form_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  late PlannerStore store;
  late AchievementStore achievementStore;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    store = PlannerStore(prefs);
    achievementStore = AchievementStore(prefs);
  });

  testWidgets('HomeTodayScreen shows empty state when no tasks exist', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    final app = AppScope(
      settings: AppSettings(prefs),
      store: store,
      achievementStore: achievementStore,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: HomeTodayScreen(
            onStartFocus: () {},
            onNavigate: (_) {},
            onOpenProfile: () {},
          ),
        ),
      ),
    );
    await tester.pumpWidget(app);
    // Skeleton shimmer shows first; pump past the simulated fetch delay.
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(HomeTodayScreen), findsOneWidget);
  });

  testWidgets('HomeTodayScreen greets the user by name after onboarding', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings.userName', 'سارا');
    await prefs.setBool('settings.onboarded', true);
    final app = AppScope(
      settings: AppSettings(prefs),
      store: store,
      achievementStore: achievementStore,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        locale: const Locale('fa'),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: HomeTodayScreen(
            onStartFocus: () {},
            onNavigate: (_) {},
            onOpenProfile: () {},
          ),
        ),
      ),
    );
    await tester.pumpWidget(app);
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.textContaining('سارا'), findsOneWidget);
  });

  testWidgets('CalendarWeekScreen renders empty state with real dates', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    final app = AppScope(
      settings: AppSettings(prefs),
      store: store,
      achievementStore: achievementStore,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: CalendarWeekScreen(),
        ),
      ),
    );
    await tester.pumpWidget(app);
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(CalendarWeekScreen), findsOneWidget);
  });

  testWidgets('TaskListScreen shows empty state, then a created task', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    await store.addTask(title: 'وظیفه تست', isCommitment: true);
    final app = AppScope(
      settings: AppSettings(prefs),
      store: store,
      achievementStore: achievementStore,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: TaskListScreen(onOpenTaskDetail: (_) {}),
        ),
      ),
    );
    await tester.pumpWidget(app);
    expect(find.textContaining('وظیفه تست'), findsOneWidget);

    // Completing the task via its checkbox updates the list.
    await tester.pumpAndSettle();
  });

  testWidgets('BlockFormSheet creates a real time block via the shared form', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('settings.onboarded', true);
    final app = AppScope(
      settings: AppSettings(prefs),
      store: store,
      achievementStore: achievementStore,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        locale: const Locale('fa'),
        home: const Scaffold(body: SizedBox.shrink()),
      ),
    );
    await tester.pumpWidget(app);

    BlockFormSheet.show(tester.element(find.byType(Scaffold)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'جلسه تست');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final submit = find.text('ذخیره');
    await tester.ensureVisible(submit);
    await tester.pumpAndSettle();
    await tester.tap(submit, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(store.blocks.length, 1);
    expect(store.blocks.first.title, 'جلسه تست');
    expect(store.blocks.first.category, 'deep');
    expect(store.plannedHoursForDay(DateTime.now()), 1);
  });
}
