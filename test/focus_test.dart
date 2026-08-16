import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner_app/core/controllers/app_settings.dart';
import 'package:planner_app/core/controllers/planner_store.dart';
import 'package:planner_app/core/theme/app_theme.dart';
import 'package:planner_app/core/widgets/app_scope.dart';
import 'package:planner_app/features/focus/focus_session_screen.dart';
import 'package:planner_app/features/focus/widgets/focus_timer_ring.dart';
import 'package:planner_app/features/focus/widgets/focus_mode_selector.dart';
import 'package:planner_app/features/focus/widgets/focus_task_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<Widget> wrapApp(Widget child) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return AppScope(
      settings: AppSettings(prefs),
      store: PlannerStore(prefs),
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: Directionality(textDirection: TextDirection.rtl, child: child),
      ),
    );
  }

  testWidgets('FocusSessionScreen renders properly in center and displays components', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(await wrapApp(const FocusSessionScreen()));
    await tester.pump();

    // Verify main components are present
    expect(find.byType(FocusSessionScreen), findsOneWidget);
    expect(find.byType(FocusTimerRing), findsOneWidget);
    expect(find.byType(FocusModeSelector), findsOneWidget);
    expect(find.byType(FocusTaskCard), findsOneWidget);
    expect(find.text('حالت تمرکز عمیق'), findsOneWidget);
  });

  testWidgets('FocusSessionScreen timer starts and pauses upon clicking play/pause button', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(await wrapApp(const FocusSessionScreen()));
    await tester.pump();

    // Find play icon
    final playBtn = find.byIcon(Icons.play_arrow_rounded);
    expect(playBtn, findsOneWidget);

    // Tap play
    await tester.tap(playBtn);
    await tester.pump();

    // Now should show pause icon
    expect(find.byIcon(Icons.pause_rounded), findsOneWidget);

    // Advance 2 seconds
    await tester.pump(const Duration(seconds: 2));

    // Tap pause
    await tester.tap(find.byIcon(Icons.pause_rounded));
    await tester.pump();

    expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
  });

  testWidgets('FocusSessionScreen mode selector switches preset modes', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(await wrapApp(const FocusSessionScreen()));
    await tester.pump();

    // Switch to Deep Work (کار عمیق)
    final deepWorkChip = find.text('کار عمیق');
    expect(deepWorkChip, findsWidgets);
    await tester.tap(deepWorkChip.first);
    await tester.pump();

    // Switch to Short Break (استراحت کوتاه)
    final shortBreakChip = find.text('استراحت کوتاه');
    expect(shortBreakChip, findsOneWidget);
    await tester.ensureVisible(shortBreakChip);
    await tester.tap(shortBreakChip);
    await tester.pump();
  });
}
