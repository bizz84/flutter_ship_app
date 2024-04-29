import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// Conditional import implementation based on the Drift Flutter web example:
// https://github.com/simolus3/drift/tree/develop/examples/app
import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

/// Represents a new app created by the user
@DataClassName('AppProject')
class AppProjectsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
}

/// Epic definition data (synced from the JSON template)
@DataClassName('Epic')
class EpicsTable extends Table {
  IntColumn get id => integer().customConstraint('UNIQUE NOT NULL')();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Task definition data (synced from the JSON template)
@DataClassName('Task')
class TasksTable extends Table {
  IntColumn get id => integer()();
  IntColumn get epicId =>
      integer().customConstraint('NOT NULL REFERENCES epics_table(id)')();
  TextColumn get description => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id, epicId};
}

/// Task completed status for a given app and epic
@DataClassName('TaskStatus')
class TaskStatusesTable extends Table {
  IntColumn get projectId => integer()
      .customConstraint('NOT NULL REFERENCES app_projects_table(id)')();
  IntColumn get taskId =>
      integer().customConstraint('NOT NULL REFERENCES tasks_table(id)')();
  IntColumn get epicId =>
      integer().customConstraint('NOT NULL REFERENCES epics_table(id)')();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {taskId, epicId, projectId};

  @override
  List<String> get customConstraints =>
      ['UNIQUE (project_id, epic_id, task_id)'];
}

@DriftDatabase(tables: [
  AppProjectsTable,
  EpicsTable,
  TasksTable,
  TaskStatusesTable,
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
