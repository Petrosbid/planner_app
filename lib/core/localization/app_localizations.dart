import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizations(const Locale('fa'));
  }

  bool get isFa => locale.languageCode == 'fa';

  String translate(String key) {
    return (isFa ? _fa[key] : _en[key]) ?? key;
  }

  // Getters for common app strings
  String get appTitle => translate('appTitle');
  String get home => translate('home');
  String get calendar => translate('calendar');
  String get tasks => translate('tasks');
  String get goals => translate('goals');
  String get projects => translate('projects');
  String get habits => translate('habits');
  String get notes => translate('notes');
  String get focus => translate('focus');
  String get reviews => translate('reviews');
  String get analytics => translate('analytics');
  String get settings => translate('settings');

  String get todayWorkload => translate('todayWorkload');
  String get timeline => translate('timeline');
  String get topCommitments => translate('topCommitments');
  String get startFocus => translate('startFocus');
  String get disciplineScore => translate('disciplineScore');
  String get planningAccuracy => translate('planningAccuracy');
  String get commitmentReliability => translate('commitmentReliability');
  String get quickCreate => translate('quickCreate');
  String get newTask => translate('newTask');
  String get newGoal => translate('newGoal');
  String get newHabit => translate('newHabit');
  String get newProject => translate('newProject');
  String get newNote => translate('newNote');

  static final Map<String, String> _fa = {
    'appTitle': 'ZedPlan',
    'home': 'خانه',
    'calendar': 'تقویم',
    'tasks': 'وظایف',
    'goals': 'اهداف',
    'projects': 'پروژه‌ها',
    'habits': 'عادت‌ها',
    'notes': 'یادداشت‌ها',
    'focus': 'تمرکز',
    'reviews': 'ارزیابی',
    'analytics': 'تحلیل',
    'settings': 'تنظیمات',
    'todayWorkload': 'فشار کاری امروز',
    'timeline': 'جدول زمانی',
    'topCommitments': 'تعهدات اصلی',
    'startFocus': 'شروع تمرکز',
    'disciplineScore': 'امتیاز دیسیپلین',
    'planningAccuracy': 'دقت برنامه‌ریزی',
    'commitmentReliability': 'پایبندی به تعهدات',
    'quickCreate': 'ایجاد سریع',
    'newTask': 'وظیفه جدید',
    'newGoal': 'هدف جدید',
    'newHabit': 'عادت جدید',
    'newProject': 'پروژه جدید',
    'newNote': 'یادداشت جدید',
    'goodMorning': 'صبح بخیر',
    'goodAfternoon': 'عصر بخیر',
    'goodEvening': 'شب بخیر',
    'estimated': 'تخمینی',
    'actual': 'واقعی',
    'minutes': 'دقیقه',
    'hours': 'ساعت',
    'completed': 'تکمیل شده',
    'postponed': 'به تعویق افتاده',
    'inProgress': 'در حال انجام',
    'pending': 'در انتظار',
    'overloadWarning': 'برنامه شما امروز بیش از حد ظرفیت به نظر می‌رسد.',
    'reviewSchedule': 'بررسی جدول زمانی',
    'keepAnyway': 'ادامه برنامه',
    'dailyReviewTitle': 'ارزیابی و انعکاس روزانه',
    'weeklyReviewTitle': 'ارزیابی استراتژیک هفتگی',
    'energyLevel': 'سطح انرژی',
    'focusScore': 'امتیاز تمرکز',
    'mainObstacles': 'موانع اصلی',
    'tomorrowPriorities': 'اولویت‌های فردا',
    'saveReview': 'ثبت ارزیابی',
    'searchPlaceholder': 'جستجوی کامل در وظایف، اهداف، یادداشت‌ها...',
    'backupRestore': 'پشتیبان‌گیری و بازیابی',
    'exportData': 'خروجی داده‌ها (JSON)',
    'importData': 'ورودی داده‌ها (JSON)',
    'languageRtl': 'زبان و راست‌چین',
    'appearance': 'ظاهر برنامه',
    'lightMode': 'روشن',
    'darkMode': 'تاریک',
    'systemMode': 'پیروی از سیستم',
  };

  static final Map<String, String> _en = {
    'appTitle': 'ZedPlan',
    'home': 'Home',
    'calendar': 'Calendar',
    'tasks': 'Tasks',
    'goals': 'Goals',
    'projects': 'Projects',
    'habits': 'Habits',
    'notes': 'Notes',
    'focus': 'Focus',
    'reviews': 'Reviews',
    'analytics': 'Analytics',
    'settings': 'Settings',
    'todayWorkload': "Today's Workload",
    'timeline': 'Timeline',
    'topCommitments': 'Top Commitments',
    'startFocus': 'Start Focus',
    'disciplineScore': 'Discipline Score',
    'planningAccuracy': 'Planning Accuracy',
    'commitmentReliability': 'Commitment Reliability',
    'quickCreate': 'Quick Create',
    'newTask': 'New Task',
    'newGoal': 'New Goal',
    'newHabit': 'New Habit',
    'newProject': 'New Project',
    'newNote': 'New Note',
    'goodMorning': 'Good Morning',
    'goodAfternoon': 'Good Afternoon',
    'goodEvening': 'Good Evening',
    'estimated': 'Estimated',
    'actual': 'Actual',
    'minutes': 'min',
    'hours': 'hrs',
    'completed': 'Completed',
    'postponed': 'Postponed',
    'inProgress': 'In Progress',
    'pending': 'Pending',
    'overloadWarning': 'Your schedule looks unusually full today.',
    'reviewSchedule': 'Review Schedule',
    'keepAnyway': 'Keep Anyway',
    'dailyReviewTitle': 'Daily Reflection & Review',
    'weeklyReviewTitle': 'Weekly Strategic Review',
    'energyLevel': 'Energy Level',
    'focusScore': 'Focus Score',
    'mainObstacles': 'Main Obstacles',
    'tomorrowPriorities': "Tomorrow's Priorities",
    'saveReview': 'Save Review',
    'searchPlaceholder': 'Search tasks, goals, notes...',
    'backupRestore': 'Backup & Restore',
    'exportData': 'Export Data (JSON)',
    'importData': 'Import Data (JSON)',
    'languageRtl': 'Language & Layout',
    'appearance': 'Appearance',
    'lightMode': 'Light',
    'darkMode': 'Dark',
    'systemMode': 'System',
  };
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fa', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
