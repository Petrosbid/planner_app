/// Plain data models for the planner store.
/// JSON-serializable so [PlannerStore] can persist them with SharedPreferences
/// until the Drift database layer replaces it.
library;

class TaskItem {
  final String id;
  String title;
  String description;
  int priority; // 0 low, 1 medium, 2 high
  int estimatedMinutes;
  int actualMinutes;
  bool isCommitment;
  bool isCompleted;
  int postponementCount;
  final DateTime createdAt;

  TaskItem({
    required this.id,
    required this.title,
    this.description = '',
    this.priority = 1,
    this.estimatedMinutes = 30,
    this.actualMinutes = 0,
    this.isCommitment = false,
    this.isCompleted = false,
    this.postponementCount = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'estimatedMinutes': estimatedMinutes,
        'actualMinutes': actualMinutes,
        'isCommitment': isCommitment,
        'isCompleted': isCompleted,
        'postponementCount': postponementCount,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TaskItem.fromMap(Map<String, dynamic> map) => TaskItem(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String? ?? '',
        priority: map['priority'] as int? ?? 1,
        estimatedMinutes: map['estimatedMinutes'] as int? ?? 30,
        actualMinutes: map['actualMinutes'] as int? ?? 0,
        isCommitment: map['isCommitment'] as bool? ?? false,
        isCompleted: map['isCompleted'] as bool? ?? false,
        postponementCount: map['postponementCount'] as int? ?? 0,
        createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );
}

class TimeBlockItem {
  final String id;
  String title;
  DateTime date; // the calendar day this block belongs to
  double startHour; // e.g. 8.0, 10.5
  double durationHours;
  int colorValue;
  String category; // 'deep' | 'meeting' | 'review' | custom
  bool isDone; // user-submitted outcome
  bool hasOutcome; // whether any outcome was submitted yet
  String repeatType; // none|daily|everyOtherDay|weekly|biweekly|monthly
  String? repeatParentId; // series identifier for repeated blocks

  TimeBlockItem({
    required this.id,
    required this.title,
    required this.date,
    required this.startHour,
    this.durationHours = 1,
    this.colorValue = 0xFF3C51C2,
    this.category = 'deep',
    this.isDone = false,
    this.hasOutcome = false,
    this.repeatType = 'none',
    this.repeatParentId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'date': date.toIso8601String(),
        'startHour': startHour,
        'durationHours': durationHours,
        'colorValue': colorValue,
        'category': category,
        'isDone': isDone,
        'hasOutcome': hasOutcome,
        'repeatType': repeatType,
        'repeatParentId': repeatParentId,
      };

  factory TimeBlockItem.fromMap(Map<String, dynamic> map) => TimeBlockItem(
        id: map['id'] as String,
        title: map['title'] as String,
        date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
        startHour: (map['startHour'] as num?)?.toDouble() ?? 9,
        durationHours: (map['durationHours'] as num?)?.toDouble() ?? 1,
        colorValue: map['colorValue'] as int? ?? 0xFF3C51C2,
        category: map['category'] as String? ?? 'deep',
        isDone: map['isDone'] as bool? ?? false,
        hasOutcome:
            map['hasOutcome'] as bool? ?? map['isDone'] as bool? ?? false,
        repeatType: map['repeatType'] as String? ?? 'none',
        repeatParentId: map['repeatParentId'] as String?,
      );
}

/// One logged distraction / not-done reason.
/// [reason] is a canonical key for built-ins or free text for custom ones.
class DistractionRecord {
  final String id;
  final DateTime at;
  final String reason;
  final String? relatedTitle; // task or block it relates to, if any

  DistractionRecord({
    required this.id,
    required this.at,
    required this.reason,
    this.relatedTitle,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'at': at.toIso8601String(),
        'reason': reason,
        'relatedTitle': relatedTitle,
      };

  factory DistractionRecord.fromMap(Map<String, dynamic> map) =>
      DistractionRecord(
        id: map['id'] as String,
        at: DateTime.tryParse(map['at'] as String? ?? '') ?? DateTime.now(),
        reason: map['reason'] as String? ?? 'other',
        relatedTitle: map['relatedTitle'] as String?,
      );
}

class HabitItem {
  final String id;
  String title;
  int colorValue;
  final List<String> markedDays; // ISO dates (yyyy-mm-dd) the habit was done

  HabitItem({
    required this.id,
    required this.title,
    this.colorValue = 0xFF3C51C2,
    List<String>? markedDays,
  }) : markedDays = markedDays ?? [];

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'colorValue': colorValue,
        'markedDays': markedDays,
      };

  factory HabitItem.fromMap(Map<String, dynamic> map) => HabitItem(
        id: map['id'] as String,
        title: map['title'] as String,
        colorValue: map['colorValue'] as int? ?? 0xFF3C51C2,
        markedDays: (map['markedDays'] as List?)?.cast<String>() ?? [],
      );
}

class NoteItem {
  final String id;
  String title;
  String body;
  final DateTime updatedAt;

  NoteItem(
      {required this.id,
      required this.title,
      this.body = '',
      DateTime? updatedAt})
      : updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'body': body,
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory NoteItem.fromMap(Map<String, dynamic> map) => NoteItem(
        id: map['id'] as String,
        title: map['title'] as String,
        body: map['body'] as String? ?? '',
        updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? '') ??
            DateTime.now(),
      );
}

class GoalItem {
  final String id;
  String title;
  String description;
  double progress; // 0..1

  GoalItem({
    required this.id,
    required this.title,
    this.description = '',
    this.progress = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'progress': progress,
      };

  factory GoalItem.fromMap(Map<String, dynamic> map) => GoalItem(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String? ?? '',
        progress: (map['progress'] as num?)?.toDouble() ?? 0,
      );
}

class ProjectItem {
  final String id;
  String title;
  String description;
  double progress;

  ProjectItem({
    required this.id,
    required this.title,
    this.description = '',
    this.progress = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'progress': progress
      };

  factory ProjectItem.fromMap(Map<String, dynamic> map) => ProjectItem(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String? ?? '',
        progress: (map['progress'] as num?)?.toDouble() ?? 0,
      );
}

class FocusRecord {
  final String id;
  final DateTime startedAt;
  final int minutes;
  final int interruptions;
  final String? taskTitle;

  FocusRecord({
    required this.id,
    required this.startedAt,
    required this.minutes,
    this.interruptions = 0,
    this.taskTitle,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'startedAt': startedAt.toIso8601String(),
        'minutes': minutes,
        'interruptions': interruptions,
        'taskTitle': taskTitle,
      };

  factory FocusRecord.fromMap(Map<String, dynamic> map) => FocusRecord(
        id: map['id'] as String,
        startedAt: DateTime.tryParse(map['startedAt'] as String? ?? '') ??
            DateTime.now(),
        minutes: map['minutes'] as int? ?? 0,
        interruptions: map['interruptions'] as int? ?? 0,
        taskTitle: map['taskTitle'] as String?,
      );
}

class DailyReviewRecord {
  final DateTime date;
  int energyRating; // 1..5
  int focusRating; // 1..5
  String obstacles;
  String reflection;

  DailyReviewRecord({
    required this.date,
    this.energyRating = 3,
    this.focusRating = 3,
    this.obstacles = '',
    this.reflection = '',
  });

  Map<String, dynamic> toMap() => {
        'date': date.toIso8601String(),
        'energyRating': energyRating,
        'focusRating': focusRating,
        'obstacles': obstacles,
        'reflection': reflection,
      };

  factory DailyReviewRecord.fromMap(Map<String, dynamic> map) =>
      DailyReviewRecord(
        date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
        energyRating: map['energyRating'] as int? ?? 3,
        focusRating: map['focusRating'] as int? ?? 3,
        obstacles: map['obstacles'] as String? ?? '',
        reflection: map['reflection'] as String? ?? '',
      );
}
