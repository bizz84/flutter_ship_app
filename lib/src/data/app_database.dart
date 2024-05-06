import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// Conditional import implementation based on the Drift Flutter web example:
// https://github.com/simolus3/drift/tree/develop/examples/app
import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

// * Table definitions

/// Represents a new app created by the user
@DataClassName('AppData')
class Apps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
}

/// Epic definition data (synced from the JSON template)
@DataClassName('EpicData')
class Epics extends Table {
  TextColumn get id =>
      text().withLength(min: 1, max: 8).customConstraint('UNIQUE NOT NULL')();
  IntColumn get order => integer().customConstraint('UNIQUE NOT NULL')();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Task definition data (synced from the JSON template)
@DataClassName('TaskData')
class Tasks extends Table {
  TextColumn get id => text().withLength(min: 1, max: 8)();
  TextColumn get epicId => text()
      .withLength(min: 1, max: 8)
      .customConstraint('NOT NULL REFERENCES epics(id)')();
  IntColumn get order => integer().customConstraint('UNIQUE NOT NULL')();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Task completed status for a given app and epic
@DataClassName('TaskStatusData')
class TaskStatuses extends Table {
  IntColumn get appId =>
      integer().customConstraint('NOT NULL REFERENCES apps(id)')();
  TextColumn get taskId => text()
      .withLength(min: 1, max: 8)
      .customConstraint('NOT NULL REFERENCES tasks(id)')();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {taskId, appId};

  @override
  List<String> get customConstraints => ['UNIQUE (app_id, task_id)'];
}

/// The database class declaring all the tables used in this project
@DriftDatabase(tables: [
  Apps,
  Epics,
  Tasks,
  TaskStatuses,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}
