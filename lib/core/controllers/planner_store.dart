import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/planner_models.dart';

/// Single source of truth for all planner data.
///
/// In-memory lists exposed as [List.unmodifiable] views; every mutation goes
/// through a method, notifies listeners, and persists the affected collection
/// to SharedPreferences as JSON. Swap this class for Drift-backed
/// repositories later without touching the screens' consumption API.
class PlannerStore extends ChangeNotifier {
  static const _uuid = Uuid();

  static const _kTasks = 'store.tasks';
  static const _kBlocks = 'store.blocks';
  static const _kHabits = 'store.habits';
  static const _kNotes = 'store.notes';
  static const _kGoals = 'store.goals';
  static const _kProjects = 'store.projects';
  static const _kFocus = 'store.focus';
  static const _kReviews = 'store.reviews';
  static const _kCategories = 'store.categories';
  static const _kDistractions = 'store.distractions';
  static const _kReasons = 'store.distractionReasons';

  /// Built-in time-block categories; users can add their own.
  static const builtInCategories = ['deep', 'meeting', 'review'];

  /// Built-in distraction / not-done reason keys; users can add their own.
  static const builtInReasons = [
    'phone', 'lowEnergy', 'environment', 'unexpected', 'clarity', 'motivation', 'other',
  ];

  final SharedPreferences _prefs;

  final List<TaskItem> _tasks = [];
  final List<TimeBlockItem> _blocks = [];
  final List<HabitItem> _habits = [];
  final List<NoteItem> _notes = [];
  final List<GoalItem> _goals = [];
  final List<ProjectItem> _projects = [];
  final List<FocusRecord> _focusRecords = [];
  final List<DailyReviewRecord> _reviews = [];
  final List<String> _customCategories = [];
  final List<DistractionRecord> _distractions = [];
  final List<String> _customReasons = [];

  PlannerStore(this._prefs) {
    _loadAll();
  }

  // ---------- loading ----------

  void _loadAll() {
    _tasks.addAll(_read<TaskItem>(_kTasks, TaskItem.fromMap));
    _blocks.addAll(_read<TimeBlockItem>(_kBlocks, TimeBlockItem.fromMap));
    _habits.addAll(_read<HabitItem>(_kHabits, HabitItem.fromMap));
    _notes.addAll(_read<NoteItem>(_kNotes, NoteItem.fromMap));
    _goals.addAll(_read<GoalItem>(_kGoals, GoalItem.fromMap));
    _projects.addAll(_read<ProjectItem>(_kProjects, ProjectItem.fromMap));
    _focusRecords.addAll(_read<FocusRecord>(_kFocus, FocusRecord.fromMap));
    _reviews.addAll(_read<DailyReviewRecord>(_kReviews, DailyReviewRecord.fromMap));
    _customCategories.addAll(((_prefs.getStringList(_kCategories) ?? [])));
    _distractions.addAll(_read<DistractionRecord>(_kDistractions, DistractionRecord.fromMap));
    _customReasons.addAll((_prefs.getStringList(_kReasons) ?? []));
  }

  List<T> _read<T>(String key, T Function(Map<String, dynamic>) fromMap) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List;
      return list.map((e) => fromMap(Map<String, dynamic>.from(e as Map))).toList();
    } catch (_) {
      return []; // corrupted entry: start clean rather than crash
    }
  }

  Future<void> _write<T>(String key, List<T> items, Map<String, dynamic> Function(T) toMap) async {
    await _prefs.setString(key, jsonEncode(items.map(toMap).toList()));
  }

  // ---------- views ----------

  List<TaskItem> get tasks => List.unmodifiable(_tasks);
  List<TimeBlockItem> get blocks => List.unmodifiable(_blocks);
  List<HabitItem> get habits => List.unmodifiable(_habits);
  List<NoteItem> get notes => List.unmodifiable(_notes);
  List<GoalItem> get goals => List.unmodifiable(_goals);
  List<ProjectItem> get projects => List.unmodifiable(_projects);
  List<FocusRecord> get focusRecords => List.unmodifiable(_focusRecords);
  List<DailyReviewRecord> get reviews => List.unmodifiable(_reviews);
  List<DistractionRecord> get distractions => List.unmodifiable(_distractions);

  TaskItem? taskById(String id) {
    for (final t in _tasks) {
      if (t.id == id) return t;
    }
    return null;
  }

  // ---------- tasks ----------

  Future<TaskItem> addTask({
    required String title,
    String description = '',
    int priority = 1,
    int estimatedMinutes = 30,
    bool isCommitment = false,
  }) async {
    final task = TaskItem(
      id: _uuid.v4(),
      title: title,
      description: description,
      priority: priority,
      estimatedMinutes: estimatedMinutes,
      isCommitment: isCommitment,
    );
    _tasks.insert(0, task);
    await _write(_kTasks, _tasks, (t) => t.toMap());
    notifyListeners();
    return task;
  }

  Future<void> updateTask(TaskItem task) async {
    await _write(_kTasks, _tasks, (t) => t.toMap());
    notifyListeners();
  }

  Future<void> toggleTaskDone(TaskItem task) async {
    task.isCompleted = !task.isCompleted;
    await updateTask(task);
  }

  Future<void> deleteTask(TaskItem task) async {
    _tasks.remove(task);
    await _write(_kTasks, _tasks, (t) => t.toMap());
    notifyListeners();
  }

  /// Tasks created today (simple day-scope until scheduling lands).
  List<TaskItem> get todayTasks {
    final now = DateTime.now();
    return _tasks.where((t) => _sameDay(t.createdAt, now)).toList();
  }

  double get todayCompletionRate {
    final today = todayTasks;
    if (today.isEmpty) return 0;
    return today.where((t) => t.isCompleted).length / today.length;
  }

  // ---------- time blocks ----------

  Future<TimeBlockItem> addBlock({
    required String title,
    required DateTime date,
    required double startHour,
    double durationHours = 1,
    int colorValue = 0xFF3C51C2,
    String category = 'deep',
  }) async {
    final block = TimeBlockItem(
      id: _uuid.v4(),
      title: title,
      date: date,
      startHour: startHour,
      durationHours: durationHours,
      colorValue: colorValue,
      category: category,
    );
    _blocks.add(block);
    await _write(_kBlocks, _blocks, (b) => b.toMap());
    notifyListeners();
    return block;
  }

  Future<void> updateBlock(TimeBlockItem block) async {
    await _write(_kBlocks, _blocks, (b) => b.toMap());
    notifyListeners();
  }

  Future<void> toggleBlockDone(TimeBlockItem block) async {
    block.isDone = !block.isDone;
    await updateBlock(block);
  }

  Future<void> deleteBlock(TimeBlockItem block) async {
    _blocks.remove(block);
    await _write(_kBlocks, _blocks, (b) => b.toMap());
    notifyListeners();
  }

  List<TimeBlockItem> blocksForDay(DateTime date) =>
      _blocks.where((b) => _sameDay(b.date, date)).toList()..sort((a, b) => a.startHour.compareTo(b.startHour));

  double plannedHoursForDay(DateTime date) => blocksForDay(date)
      .fold(0.0, (sum, b) => sum + b.durationHours);

  /// Returns the conflicting block's title when [startHour, startHour + durationHours)
  /// overlaps an existing block on [date]; null when the range is free.
  /// Ranges that merely touch (end == next start) are allowed.
  TimeBlockItem? conflictingBlock(DateTime date, double startHour, double durationHours) {
    for (final b in blocksForDay(date)) {
      final bs = b.startHour;
      final be = b.startHour + b.durationHours;
      final ns = startHour;
      final ne = startHour + durationHours;
      if (ns < be && bs < ne) return b;
    }
    return null;
  }

  // ---------- custom categories ----------

  List<String> get customCategories => List.unmodifiable(_customCategories);

  /// All selectable categories: built-ins first, then the user's own.
  List<String> get allCategories => [...builtInCategories, ..._customCategories];

  /// Adds [name] if it is non-empty and not already known (case-insensitive).
  /// Returns true when the category was added.
  Future<bool> addCustomCategory(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;
    final lower = trimmed.toLowerCase();
    final clash = allCategories.any((c) => c.toLowerCase() == lower);
    if (clash) return false;
    _customCategories.add(trimmed);
    await _prefs.setStringList(_kCategories, _customCategories);
    notifyListeners();
    return true;
  }

  /// Stable color for a category; built-ins map to brand colors, custom ones
  /// cycle through a fixed palette so each gets a consistent identity.
  static int categoryColor(String category) {
    switch (category) {
      case 'deep':
        return 0xFF3C51C2; // AppColors.primary
      case 'meeting':
        return 0xFF10B981; // AppColors.success
      case 'review':
        return 0xFFF59E0B; // AppColors.warning
      default:
        const palette = [
          0xFF8B5CF6, 0xFF14B8A6, 0xFFEC4899, 0xFF6366F1, 0xFFEA580C, 0xFF65A30D,
        ];
        var hash = 0;
        for (final code in category.codeUnits) {
          hash = (hash * 31 + code) & 0x7FFFFFFF;
        }
        return palette[hash % palette.length];
    }
  }

  // ---------- habits ----------

  Future<HabitItem> addHabit({required String title, int colorValue = 0xFF3C51C2}) async {
    final habit = HabitItem(id: _uuid.v4(), title: title, colorValue: colorValue);
    _habits.add(habit);
    await _write(_kHabits, _habits, (h) => h.toMap());
    notifyListeners();
    return habit;
  }

  Future<void> deleteHabit(HabitItem habit) async {
    _habits.remove(habit);
    await _write(_kHabits, _habits, (h) => h.toMap());
    notifyListeners();
  }

  Future<void> toggleHabitToday(HabitItem habit) async {
    final key = _dayKey(DateTime.now());
    if (habit.markedDays.contains(key)) {
      habit.markedDays.remove(key);
    } else {
      habit.markedDays.add(key);
    }
    await _write(_kHabits, _habits, (h) => h.toMap());
    notifyListeners();
  }

  bool habitDoneToday(HabitItem habit) => habit.markedDays.contains(_dayKey(DateTime.now()));

  /// Consecutive marked days ending today (or yesterday if today is unmarked).
  int habitStreak(HabitItem habit) {
    var streak = 0;
    var day = DateTime.now();
    if (!habit.markedDays.contains(_dayKey(day))) {
      day = day.subtract(const Duration(days: 1));
      if (!habit.markedDays.contains(_dayKey(day))) return 0;
    }
    while (habit.markedDays.contains(_dayKey(day))) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  // ---------- notes / goals / projects ----------

  Future<NoteItem> addNote({required String title, String body = ''}) async {
    final note = NoteItem(id: _uuid.v4(), title: title, body: body);
    _notes.insert(0, note);
    await _write(_kNotes, _notes, (n) => n.toMap());
    notifyListeners();
    return note;
  }

  Future<void> updateNote(NoteItem note, {required String title, required String body}) async {
    note.title = title;
    note.body = body;
    await _write(_kNotes, _notes, (n) => n.toMap());
    notifyListeners();
  }

  Future<void> deleteNote(NoteItem note) async {
    _notes.remove(note);
    await _write(_kNotes, _notes, (n) => n.toMap());
    notifyListeners();
  }

  Future<GoalItem> addGoal({required String title, String description = ''}) async {
    final goal = GoalItem(id: _uuid.v4(), title: title, description: description);
    _goals.add(goal);
    await _write(_kGoals, _goals, (g) => g.toMap());
    notifyListeners();
    return goal;
  }

  Future<void> updateGoal(GoalItem goal) async {
    await _write(_kGoals, _goals, (g) => g.toMap());
    notifyListeners();
  }

  Future<void> deleteGoal(GoalItem goal) async {
    _goals.remove(goal);
    await _write(_kGoals, _goals, (g) => g.toMap());
    notifyListeners();
  }

  Future<ProjectItem> addProject({required String title, String description = ''}) async {
    final project = ProjectItem(id: _uuid.v4(), title: title, description: description);
    _projects.add(project);
    await _write(_kProjects, _projects, (p) => p.toMap());
    notifyListeners();
    return project;
  }

  Future<void> updateProject(ProjectItem project) async {
    await _write(_kProjects, _projects, (p) => p.toMap());
    notifyListeners();
  }

  Future<void> deleteProject(ProjectItem project) async {
    _projects.remove(project);
    await _write(_kProjects, _projects, (p) => p.toMap());
    notifyListeners();
  }

  // ---------- distractions / not-done reasons ----------

  /// All selectable reasons: built-in keys first, then the user's own.
  List<String> get allReasons => [...builtInReasons, ..._customReasons];

  List<String> get customReasons => List.unmodifiable(_customReasons);

  /// Adds [name] if non-empty and not already known (case-insensitive).
  Future<bool> addCustomReason(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;
    final lower = trimmed.toLowerCase();
    if (allReasons.any((r) => r.toLowerCase() == lower)) return false;
    _customReasons.add(trimmed);
    await _prefs.setStringList(_kReasons, _customReasons);
    notifyListeners();
    return true;
  }

  Future<void> addDistraction({required String reason, String? relatedTitle}) async {
    _distractions.add(DistractionRecord(
      id: _uuid.v4(),
      at: DateTime.now(),
      reason: reason,
      relatedTitle: relatedTitle,
    ));
    await _write(_kDistractions, _distractions, (d) => d.toMap());
    notifyListeners();
  }

  List<DistractionRecord> get todayDistractions =>
      _distractions.where((d) => _sameDay(d.at, DateTime.now())).toList();

  /// Distraction counts per day, oldest → newest, for the last 7 days.
  List<int> get distractionCountsLast7Days {
    final result = <int>[];
    for (var i = 6; i >= 0; i--) {
      final day = DateTime.now().subtract(Duration(days: i));
      result.add(_distractions.where((d) => _sameDay(d.at, day)).length);
    }
    return result;
  }

  /// Reason → count over the last 7 days, most frequent first.
  List<MapEntry<String, int>> get weeklyReasonCounts {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    final counts = <String, int>{};
    for (final d in _distractions.where((d) => d.at.isAfter(cutoff))) {
      counts[d.reason] = (counts[d.reason] ?? 0) + 1;
    }
    final entries = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  // ---------- focus ----------

  Future<void> recordFocus({
    required int minutes,
    int interruptions = 0,
    String? taskTitle,
    DateTime? at,
  }) async {
    final end = at ?? DateTime.now();
    _focusRecords.add(FocusRecord(
      id: _uuid.v4(),
      startedAt: end.subtract(Duration(minutes: minutes)),
      minutes: minutes,
      interruptions: interruptions,
      taskTitle: taskTitle,
    ));
    await _write(_kFocus, _focusRecords, (f) => f.toMap());
    notifyListeners();
  }

  List<FocusRecord> get todayFocusRecords => _focusRecords
      .where((r) => _sameDay(r.startedAt, DateTime.now()))
      .toList();

  int get todayFocusMinutes => todayFocusRecords.fold(0, (sum, r) => sum + r.minutes);

  // ---------- reviews ----------

  DailyReviewRecord? get todayReview {
    for (final r in _reviews) {
      if (_sameDay(r.date, DateTime.now())) return r;
    }
    return null;
  }

  Future<void> saveDailyReview(DailyReviewRecord review) async {
    _reviews.removeWhere((r) => _sameDay(r.date, review.date));
    _reviews.add(review);
    await _write(_kReviews, _reviews, (r) => r.toMap());
    notifyListeners();
  }

  // ---------- computed analytics ----------

  /// Completed tasks / all tasks ever created (0 when empty).
  double get executionRate =>
      _tasks.isEmpty ? 0 : _tasks.where((t) => t.isCompleted).length / _tasks.length;

  double get commitmentReliability {
    final commitments = _tasks.where((t) => t.isCommitment).toList();
    if (commitments.isEmpty) return 0;
    return commitments.where((t) => t.isCompleted).length / commitments.length;
  }

  /// Minutes per focus category block, for the analytics donut.
  Map<String, double> get focusMinutesByCategory {
    final map = <String, double>{};
    for (final b in _blocks) {
      map[b.category] = (map[b.category] ?? 0) + b.durationHours * 60;
    }
    return map;
  }

  /// Total minutes focused over the last 7 days, oldest first.
  List<double> get weeklyFocusMinutes {
    final result = <double>[];
    for (var i = 6; i >= 0; i--) {
      final day = DateTime.now().subtract(Duration(days: i));
      final minutes = _focusRecords
          .where((r) => _sameDay(r.startedAt, day))
          .fold(0, (sum, r) => sum + r.minutes);
      result.add(minutes.toDouble());
    }
    return result;
  }

  // ---------- maintenance ----------

  Future<void> clearAll() async {
    _tasks.clear();
    _blocks.clear();
    _habits.clear();
    _notes.clear();
    _goals.clear();
    _projects.clear();
    _focusRecords.clear();
    _reviews.clear();
    _customCategories.clear();
    _distractions.clear();
    _customReasons.clear();
    for (final key in [
      _kTasks, _kBlocks, _kHabits, _kNotes, _kGoals, _kProjects, _kFocus, _kReviews, _kCategories,
      _kDistractions, _kReasons,
    ]) {
      await _prefs.remove(key);
    }
    notifyListeners();
  }

  // ---------- helpers ----------

  static bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  static String _dayKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
