import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Tables Definitions

class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withDefault(const Constant('Julian'))();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get energyPreference => text().withDefault(const Constant('morning'))();
  TextColumn get locale => text().withDefault(const Constant('fa'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LifeAreas extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get icon => text().withDefault(const Constant('spa'))();
  TextColumn get colorHex => text().withDefault(const Constant('#3C51C2'))();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get lifeAreaId => text().nullable()();
  TextColumn get visionText => text().nullable()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Milestones extends Table {
  TextColumn get id => text()();
  TextColumn get goalId => text()();
  TextColumn get title => text()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Projects extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get goalId => text().nullable()();
  TextColumn get lifeAreaId => text().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, scheduled, inProgress, completed, postponed, cancelled
  TextColumn get priority => text().withDefault(const Constant('medium'))(); // low, medium, high
  IntColumn get estimatedDurationMinutes => integer().withDefault(const Constant(30))();
  IntColumn get actualDurationMinutes => integer().withDefault(const Constant(0))();
  DateTimeColumn get scheduledStart => dateTime().nullable()();
  DateTimeColumn get scheduledEnd => dateTime().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  BoolColumn get isFlexible => boolean().withDefault(const Constant(true))();
  BoolColumn get isCommitment => boolean().withDefault(const Constant(false))();
  IntColumn get energyLevel => integer().withDefault(const Constant(2))(); // 1: Low, 2: Medium, 3: High
  IntColumn get difficulty => integer().withDefault(const Constant(2))();
  TextColumn get projectId => text().nullable()();
  TextColumn get goalId => text().nullable()();
  TextColumn get lifeAreaId => text().nullable()();
  TextColumn get parentTaskId => text().nullable()();
  TextColumn get recurrenceRule => text().nullable()();
  IntColumn get postponementCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Subtasks extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text()();
  TextColumn get title => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskHistories extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text()();
  TextColumn get actionType => text()(); // created, scheduled, started, paused, postponed, completed
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get lifeAreaId => text().nullable()();
  TextColumn get frequencyType => text().withDefault(const Constant('daily'))(); // daily, weekly, custom
  IntColumn get targetDaysOfWeekMask => integer().withDefault(const Constant(127))(); // 7 days bitmask
  IntColumn get targetCountPerPeriod => integer().withDefault(const Constant(1))();
  TextColumn get colorHex => text().withDefault(const Constant('#3C51C2'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class HabitOccurrences extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(true))();
  IntColumn get valueCount => integer().withDefault(const Constant(1))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class CalendarEvents extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  BoolColumn get isAllDay => boolean().withDefault(const Constant(false))();
  TextColumn get colorHex => text().withDefault(const Constant('#3C51C2'))();

  @override
  Set<Column> get primaryKey => {id};
}

class TimeBlocks extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text().nullable()();
  TextColumn get title => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  TextColumn get source => text().withDefault(const Constant('user'))();
  TextColumn get status => text().withDefault(const Constant('scheduled'))();

  @override
  Set<Column> get primaryKey => {id};
}

class FocusSessions extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get plannedDurationMinutes => integer()();
  IntColumn get actualDurationMinutes => integer().withDefault(const Constant(0))();
  IntColumn get interruptedCount => integer().withDefault(const Constant(0))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get folderName => text().withDefault(const Constant('General'))();
  TextColumn get projectId => text().nullable()();
  TextColumn get goalId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class NoteBlocks extends Table {
  TextColumn get id => text()();
  TextColumn get noteId => text()();
  TextColumn get blockType => text().withDefault(const Constant('paragraph'))(); // paragraph, heading, checklist, bullet, quote, code
  TextColumn get content => text()();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class DailyReviews extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get energyRating => integer().withDefault(const Constant(3))();
  IntColumn get focusRating => integer().withDefault(const Constant(3))();
  TextColumn get obstaclesText => text().nullable()();
  TextColumn get reflectionText => text().nullable()();
  TextColumn get tomorrowPrioritiesJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class WeeklyReviews extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get reflectionText => text().nullable()();
  TextColumn get strategicAdjustmentsText => text().nullable()();
  RealColumn get completionRate => real().withDefault(const Constant(0.0))();
  RealColumn get commitmentReliabilityRate => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class BehavioralInsights extends Table {
  TextColumn get id => text()();
  TextColumn get insightType => text()(); // underestimation, overplanning, peak_energy, commitment_lag
  TextColumn get title => text()();
  TextColumn get message => text()();
  TextColumn get severity => text().withDefault(const Constant('info'))(); // info, warning, tip
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDismissed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  UserProfiles,
  LifeAreas,
  Goals,
  Milestones,
  Projects,
  Tasks,
  Subtasks,
  TaskHistories,
  Habits,
  HabitOccurrences,
  CalendarEvents,
  TimeBlocks,
  FocusSessions,
  Notes,
  NoteBlocks,
  DailyReviews,
  WeeklyReviews,
  BehavioralInsights,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'zedplan.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
