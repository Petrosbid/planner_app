import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planner_app/core/theme/app_theme.dart';
import 'package:planner_app/features/home/home_today_screen.dart';
import 'package:planner_app/features/calendar/calendar_week_screen.dart';
import 'package:planner_app/features/analytics/insights_analytics_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('HomeTodayScreen renders clean visual layout', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: HomeTodayScreen(
            onStartFocus: () {},
            onNavigate: (_) {},
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(HomeTodayScreen), findsOneWidget);
    expect(find.textContaining('جولیان'), findsOneWidget);
  });

  testWidgets('CalendarWeekScreen renders clean calendar grid', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: const CalendarWeekScreen(),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(CalendarWeekScreen), findsOneWidget);
  });

  testWidgets('InsightsAnalyticsScreen renders clean charts', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: const InsightsAnalyticsScreen(),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(InsightsAnalyticsScreen), findsOneWidget);
  });
}
