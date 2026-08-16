import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/controllers/app_settings.dart';
import 'core/controllers/planner_store.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_scope.dart';
import 'core/widgets/custom_nav_bar.dart';
import 'core/notifications/notification_service.dart';
import 'features/common/quick_create_modal.dart';

// Feature Screens
import 'features/home/home_today_screen.dart';
import 'features/calendar/calendar_week_screen.dart';
import 'features/tasks/task_list_screen.dart';
import 'features/tasks/task_detail_screen.dart';
import 'features/goals/goals_vision_screen.dart';
import 'features/habits/habits_consistency_screen.dart';
import 'features/focus/focus_session_screen.dart';
import 'features/reviews/daily_review_screen.dart';
import 'features/reviews/weekly_review_screen.dart';
import 'features/analytics/insights_analytics_screen.dart';
import 'features/notes/notes_screen.dart';
import 'features/projects/projects_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(ZedPlanApp(prefs: prefs));
}

class ZedPlanApp extends StatefulWidget {
  final SharedPreferences prefs;

  const ZedPlanApp({super.key, required this.prefs});

  @override
  State<ZedPlanApp> createState() => _ZedPlanAppState();
}

class _ZedPlanAppState extends State<ZedPlanApp> {
  late final AppSettings _settings = AppSettings(widget.prefs);
  late final PlannerStore _store = PlannerStore(widget.prefs);

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    final service = NotificationService.instance;
    await service.init(seedColor: _settings.seedColor);
    if (!_settings.notificationsEnabled) return;
    await service.reschedule(_store, fa: _settings.locale.languageCode == 'fa');
    // Keep the schedule in sync whenever blocks change.
    _store.addListener(() {
      if (!_settings.notificationsEnabled) return;
      service.setSeedColor(_settings.seedColor);
      service.reschedule(_store, fa: _settings.locale.languageCode == 'fa');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_settings, _store]),
      builder: (context, _) {
        return AppScope(
          settings: _settings,
          store: _store,
          child: MaterialApp(
            title: 'ZedPlan',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _settings.themeMode,
            locale: _settings.locale,
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
              // Resolve AppColors' theme-aware tokens for everything below.
              AppColors.brightness = Theme.of(context).brightness;
              AppColors.seed = _settings.seedColor;
              return Directionality(
                textDirection: _settings.locale.languageCode == 'fa'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: _settings.onboarded
                ? const MainNavigationShell()
                : OnboardingScreen(
                    settings: _settings,
                    onFinished: () {}, // settings notify → MaterialApp rebuilds with the shell
                  ),
          ),
        );
      },
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openTaskDetail(String taskId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: taskId)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final List<Widget> screens = [
      HomeTodayScreen(
        onStartFocus: () => _openScreen(const FocusSessionScreen()),
        onNavigate: (route) {
          if (route == 'tasks') setState(() => _currentTabIndex = 2);
          if (route == 'calendar') setState(() => _currentTabIndex = 1);
          if (route == 'habits') _openScreen(const HabitsConsistencyScreen());
        },
        onOpenProfile: () => _openScreen(const ProfileScreen()),
      ),
      const CalendarWeekScreen(),
      TaskListScreen(
        onOpenTaskDetail: _openTaskDetail,
      ),
      const FocusSessionScreen(),
      InsightsAnalyticsScreen(
        onOpenWeeklyReview: () => _openScreen(const WeeklyReviewScreen()),
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildAppDrawer(l10n),
      body: IndexedStack(
        index: _currentTabIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentTabIndex,
        onTap: (index) => setState(() => _currentTabIndex = index),
        onQuickCreateTap: () => QuickCreateModal.show(context),
      ),
    );
  }

  Widget _buildAppDrawer(AppLocalizations l10n) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ZedPlan',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.translate('analyticsSubtitle'),
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view_rounded),
            title: Text(l10n.home),
            onTap: () => _switchTab(0),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: Text(l10n.calendar),
            onTap: () => _switchTab(1),
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: Text(l10n.translate('goalsTitle')),
            onTap: () => _openScreen(const GoalsVisionScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.autorenew),
            title: Text(l10n.translate('habitsTitle')),
            onTap: () => _openScreen(const HabitsConsistencyScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.folder_open),
            title: Text(l10n.translate('projectsTitle')),
            onTap: () => _openScreen(const ProjectsScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.note_alt_outlined),
            title: Text(l10n.translate('notesTitle')),
            onTap: () => _openScreen(const NotesScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
            title: Text(l10n.reviews),
            onTap: () => _openScreen(const DailyReviewScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: Text(l10n.translate('profileTitle')),
            onTap: () => _openScreen(const ProfileScreen()),
          ),
        ],
      ),
    );
  }

  void _switchTab(int index) {
    Navigator.pop(context);
    setState(() => _currentTabIndex = index);
  }

  void _openScreen(Widget screen) {
    // Close the drawer first when this is triggered from it.
    final scaffold = _scaffoldKey.currentState;
    if (scaffold?.isDrawerOpen ?? false) scaffold!.closeDrawer();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}
