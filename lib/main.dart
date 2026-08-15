import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/localization/app_localizations.dart';
import 'core/widgets/custom_nav_bar.dart';
import 'features/common/quick_create_modal.dart';

// Feature Screens
import 'features/home/home_today_screen.dart';
import 'features/calendar/calendar_week_screen.dart';
import 'features/tasks/task_detail_screen.dart';
import 'features/goals/goals_vision_screen.dart';
import 'features/habits/habits_consistency_screen.dart';
import 'features/focus/focus_session_screen.dart';
import 'features/reviews/daily_review_screen.dart';
import 'features/reviews/weekly_review_screen.dart';
import 'features/analytics/insights_analytics_screen.dart';
import 'features/notes/notes_screen.dart';
import 'features/projects/projects_screen.dart';
import 'features/settings/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZedPlanApp());
}

class ZedPlanApp extends StatefulWidget {
  const ZedPlanApp({super.key});

  @override
  State<ZedPlanApp> createState() => _ZedPlanAppState();
}

class _ZedPlanAppState extends State<ZedPlanApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('fa');

  void toggleTheme(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  void toggleLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZedPlan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''),
        Locale('en', ''),
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: _locale.languageCode == 'fa' ? TextDirection.rtl : TextDirection.ltr,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeTodayScreen(
        onStartFocus: _openFocusMode,
        onNavigate: (route) {
          if (route == 'tasks') setState(() => _currentTabIndex = 2);
        },
      ),
      CalendarWeekScreen(
        onOpenTaskDetail: () => _openScreen(const TaskDetailScreen()),
      ),
      TaskDetailScreen(),
      FocusSessionScreen(),
      InsightsAnalyticsScreen(
        onOpenWeeklyReview: () => _openScreen(const WeeklyReviewScreen()),
      ),
    ];

    return Scaffold(
      drawer: _buildAppDrawer(),
      body: IndexedStack(
        index: _currentTabIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentTabIndex,
        onTap: (index) => setState(() => _currentTabIndex = index),
        onQuickCreateTap: () {
          QuickCreateModal.show(context, (type, data) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('مورد جدید با موفقیت ایجاد شد: ${data['title']}')),
            );
          });
        },
      ),
    );
  }

  Widget _buildAppDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF3C51C2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ZedPlan', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 4),
                Text('مدیریت خود و دیسیپلین رفتاری', style: TextStyle(fontSize: 13, color: Colors.white70)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view_rounded),
            title: const Text('امروز / خانه'),
            onTap: () {
              Navigator.pop(context);
              setState(() => _currentTabIndex = 0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: const Text('تقویم & برنامه‌ریزی'),
            onTap: () {
              Navigator.pop(context);
              setState(() => _currentTabIndex = 1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text('اهداف & چشم‌انداز'),
            onTap: () {
              Navigator.pop(context);
              _openScreen(const GoalsVisionScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.autorenew),
            title: const Text('عادت‌ها & استمرار'),
            onTap: () {
              Navigator.pop(context);
              _openScreen(const HabitsConsistencyScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder_open),
            title: const Text('پروژه‌ها'),
            onTap: () {
              Navigator.pop(context);
              _openScreen(const ProjectsScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_alt_outlined),
            title: const Text('یادداشت‌ها'),
            onTap: () {
              Navigator.pop(context);
              _openScreen(const NotesScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
            title: const Text('ارزیابی روزانه'),
            onTap: () {
              Navigator.pop(context);
              _openScreen(const DailyReviewScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('تنظیمات'),
            onTap: () {
              Navigator.pop(context);
              _openScreen(const SettingsScreen());
            },
          ),
        ],
      ),
    );
  }

  void _openFocusMode() {
    _openScreen(const FocusSessionScreen());
  }

  void _openScreen(Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}
