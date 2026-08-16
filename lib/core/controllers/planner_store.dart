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

  final SharedPreferences _prefs;

  final List<TaskItem> _tasks = [];
  final List<TimeBlockItem> _blocks = [];
  final List<HabitItem> _habits = [];
  final List<NoteItem> _notes = [];
  final List<GoalItem> _goals = [];
  final List<ProjectItem> _projects = [];
  final List<FocusRecord> _focusRecords = [];
  final List<DailyReviewRecord> _reviews = [];

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

  Future<void> deleteBlock(TimeBlockItem block) async {
    _blocks.remove(block);
    await _write(_kBlocks, _blocks, (b) => b.toMap());
    notifyListeners();
  }

  List<TimeBlockItem> blocksForDay(DateTime date) =>
      _blocks.where((b) => _sameDay(b.date, date)).toList()..sort((a, b) => a.startHour.compareTo(b.startHour));

  double plannedHoursForDay(DateTime date) => blocksForDay(date)
      .fold(0.0, (sum, b) => sum + b.durationHours);

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

  Future<void> deleteGoal(GoalItem goal) async {
    _goals.remove(goal);
    await _write(_kGoals, _goals, (g) => g.toMap());
    notifyListeners();
  }

  Future<void> updateGoalProgress(GoalItem goal, double progress) async {
    goal.progress = progress.clamp(0.0, 1.0);
    await _write(_kGoals, _goals, (g) => g.toMap());
    notifyListeners();
  }

  Future<ProjectItem> addProject({required String title}) async {
    final project = ProjectItem(id: _uuid.v4(), title: title);
    _projects.add(project);
    await _write(_kProjects, _projects, (p) => p.toMap());
    notifyListeners();
    return project;
  }

  Future<void> deleteProject(ProjectItem project) async {
    _projects.remove(project);
    await _write(_kProjects, _projects, (p) => p.toMap());
    notifyListeners();
  }

  Future<void> updateProjectProgress(ProjectItem project, double progress) async {
    project.progress = progress.clamp(0.0, 1.0);
    await _write(_kProjects, _projects, (p) => p.toMap());
    notifyListeners();
  }

  // ---------- focus ----------

  Future<void> recordFocus({required int minutes, int interruptions = 0, String? taskTitle}) async {
    _focusRecords.add(FocusRecord(
      id: _uuid.v4(),
      startedAt: DateTime.now().subtract(Duration(minutes: minutes)),
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
    for (final key in [_kTasks, _kBlocks, _kHabits, _kNotes, _kGoals, _kProjects, _kFocus, _kReviews]) {
      await _prefs.remove(key);
    }
    notifyListeners();
  }

  // ---------- helpers ----------

  static bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  static String _dayKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
