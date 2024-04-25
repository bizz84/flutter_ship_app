import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_ship_app/src/data/epic_entity.dart';
import 'package:flutter_ship_app/src/data/task_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

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

@DriftDatabase(
    tables: [AppProjectsTable, EpicsTable, TasksTable, TaskStatusesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> loadFromJson(List<dynamic> checklistTemplate) async {
    await transaction(() async {
      for (var epicData in checklistTemplate) {
        // Insert epic
        final epic = EpicsTableCompanion(
          id: Value(epicData['id']),
          name: Value(epicData['epic']),
        );
        await into(epicsTable).insertOnConflictUpdate(epic);

        // Insert tasks for each epic
        final tasks = epicData['tasks'] as List<dynamic>;
        for (var taskData in tasks) {
          final task = TasksTableCompanion(
            id: Value(taskData['id']),
            epicId: Value(epicData['id']),
            description: Value(taskData['description']),
          );
          await into(tasksTable).insertOnConflictUpdate(task);
        }
      }
    });
  }

  Future<List<EpicEntity>> loadAllEpicsAndTasks() async {
    final epicWithTasks = await (select(epicsTable).join(
      [leftOuterJoin(tasksTable, tasksTable.epicId.equalsExp(epicsTable.id))],
    )..orderBy([
            OrderingTerm.asc(epicsTable.id),
            OrderingTerm.asc(tasksTable.id),
          ]))
        .get();

    // Transform the query result into a list of Epics with their associated tasks
    final Map<int, EpicEntity> epicsMap = {};
    for (final row in epicWithTasks) {
      final epicEntry = row.readTable(epicsTable);
      final taskEntry = row.readTableOrNull(tasksTable);

      final epic = epicsMap.putIfAbsent(
          epicEntry.id,
          () => EpicEntity(
                id: epicEntry.id,
                epic: epicEntry.name,
                tasks: [],
              ));

      if (taskEntry != null) {
        epic.tasks.add(TaskEntity(
          id: taskEntry.id,
          description: taskEntry.description,
        ));
      }
    }

    return epicsMap.values.toList();
  }

  static LazyDatabase _openConnection() {
    // the LazyDatabase util lets us find the right location for the file async.
    return LazyDatabase(() async {
      // put the database file, called tips.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      // Also work around limitations on old Android versions
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      // Make sqlite3 pick a more suitable location for temporary files - the
      // one from the system may be inaccessible due to sandboxing.
      final cachebase = (await getTemporaryDirectory()).path;
      // We can't access /tmp on Android, which sqlite3 would try by default.
      // Explicitly tell it about the correct temporary directory.
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}
