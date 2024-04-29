import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/domain/app_entity.dart';
import 'package:flutter_ship_app/src/domain/epic_entity.dart';
import 'package:flutter_ship_app/src/domain/task_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database_crud.g.dart';

extension AppDatabaseCRUD on AppDatabase {
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

  // *************** Apps *****************

  Stream<List<AppEntity>> watchAppsList() {
    return select(appProjectsTable).watch().map((apps) =>
        apps.map((app) => AppEntity(id: app.id, name: app.name)).toList());
  }

  Stream<AppEntity?> watchAppById(int id) {
    return (select(appProjectsTable)..where((app) => app.id.equals(id)))
        .watchSingleOrNull()
        .map((app) =>
            app != null ? AppEntity(id: app.id, name: app.name) : null);
  }

  Future<int> createNewApp({required String name}) async {
    return into(appProjectsTable).insert(AppProjectsTableCompanion(
      name: Value(name),
    ));
  }

  Future<bool> editAppName(
      {required int projectId, required String newName}) async {
    return update(appProjectsTable).replace(AppProjectsTableCompanion(
      id: Value(projectId),
      name: Value(newName),
    ));
  }

  Future<void> deleteAppById(int projectId) async {
    await transaction(() async {
      // Delete all associated TaskStatuses for the given projectId
      await (delete(taskStatusesTable)
            ..where((taskStatus) => taskStatus.projectId.equals(projectId)))
          .go();

      // Now, delete the AppProject row with the given projectId
      await (delete(appProjectsTable)
            ..where((project) => project.id.equals(projectId)))
          .go();
    });
  }

  // *************** Tasks *****************

  /// The total number of tasks loaded from the JSON template
  Stream<int> watchTotalTasksCount() {
    // Define the query to count all tasks
    final query = selectOnly(tasksTable)..addColumns([tasksTable.id.count()]);

    // Create the stream and map the result to the count of tasks
    return query
        .watchSingle()
        .map((row) => row.read<int>(tasksTable.id.count()) ?? 0);
  }

  Stream<List<TaskEntity>> watchTasksForAppAndEpic(
      {required int projectId, required int epicId}) {
    // We use a custom select statement to perform a left join between tasks and task statuses.
    final query = customSelect(
      'SELECT t.id, t.description, IFNULL(ts.completed, 0) as completed '
      'FROM tasks_table AS t '
      'LEFT JOIN task_statuses_table AS ts ON t.id = ts.task_id AND t.epic_id = ts.epic_id AND ts.project_id = ? '
      'WHERE t.epic_id = ? '
      'ORDER BY t.id',
      variables: [
        Variable<int>(projectId),
        Variable<int>(epicId),
      ],
      readsFrom: {
        tasksTable,
        taskStatusesTable
      }, // Ensuring Drift knows which tables this query depends on
    ).watch();

    // Transform the query stream into a stream of TaskEntity lists.
    return query.map((rows) {
      return rows.map((row) {
        return TaskEntity(
          id: row.read<int>('id'),
          description: row.read<String>('description'),
          completed: row.read<int>('completed') != 0,
        );
      }).toList();
    });
  }

  Stream<int> watchCompletedTasksCount({required int projectId, int? epicId}) {
    // Define the query to select completed tasks for the given project and epic
    final whereExpr = epicId != null
        ? taskStatusesTable.projectId.equals(projectId) &
            taskStatusesTable.epicId.equals(epicId) &
            taskStatusesTable.completed.equals(true)
        : taskStatusesTable.projectId.equals(projectId) &
            taskStatusesTable.completed.equals(true);
    final query = selectOnly(taskStatusesTable)
      ..addColumns([taskStatusesTable.completed])
      ..where(whereExpr);

    // Create the stream and map the result to the count of completed tasks
    return query.watch().map((rows) => rows.length);
  }

  Future<void> updateTaskCompletionStatus({
    required int projectId,
    required int epicId,
    required int taskId,
    required bool isCompleted,
  }) async {
    final taskStatus = TaskStatusesTableCompanion(
      projectId: Value(projectId),
      epicId: Value(epicId),
      taskId: Value(taskId),
      completed: Value(isCompleted),
    );

    // Use upsert to insert or update the task status
    await into(taskStatusesTable).insertOnConflictUpdate(taskStatus);
  }
}

@Riverpod(keepAlive: true)
Future<void> updateDatabaseFromJsonTemplate(
    UpdateDatabaseFromJsonTemplateRef ref) async {
  String jsonString =
      await rootBundle.loadString('assets/checklist_template.json');
  List<dynamic> jsonResponse = jsonDecode(jsonString);
  final db = ref.watch(appDatabaseProvider);
  await db.loadFromJson(jsonResponse);
}

@riverpod
Future<List<EpicEntity>> loadAllEpicsAndTasks(LoadAllEpicsAndTasksRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.loadAllEpicsAndTasks();
}

// *************** Apps *****************

@riverpod
Stream<List<AppEntity>> appsList(AppsListRef ref) {
  return ref.watch(appDatabaseProvider).watchAppsList();
}

@riverpod
Stream<AppEntity?> appById(AppByIdRef ref, int id) {
  return ref.watch(appDatabaseProvider).watchAppById(id);
}

// *************** Tasks *****************

@riverpod
Stream<int> watchTotalTasksCount(WatchTotalTasksCountRef ref) {
  return ref.watch(appDatabaseProvider).watchTotalTasksCount();
}

@riverpod
Stream<List<TaskEntity>> watchTasksForAppAndEpic(WatchTasksForAppAndEpicRef ref,
    {required int projectId, required int epicId}) {
  return ref
      .watch(appDatabaseProvider)
      .watchTasksForAppAndEpic(projectId: projectId, epicId: epicId);
}

@riverpod
Stream<int> watchCompletedTasksCount(WatchCompletedTasksCountRef ref,
    {required int projectId, int? epicId}) {
  return ref
      .watch(appDatabaseProvider)
      .watchCompletedTasksCount(projectId: projectId, epicId: epicId);
}
