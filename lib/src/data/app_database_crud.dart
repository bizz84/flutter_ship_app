import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/domain/app_model.dart';
import 'package:flutter_ship_app/src/domain/epic_model.dart';
import 'package:flutter_ship_app/src/domain/task_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database_crud.g.dart';

/// All the CRUD operations supported by the database
extension AppDatabaseCRUD on AppDatabase {
  // *************** Initialization *****************

  /// Insert or update the epics and tasks from the given template data
  Future<void> loadOrUpdateFromTemplate(
      Map<String, dynamic> checklistTemplate) async {
    try {
      // * Parse JSON to a List<EpicModel>
      final List<dynamic> epicsJson = checklistTemplate['epics'];
      final epics = epicsJson.map((epic) => EpicModel.fromJson(epic)).toList();
      // * Sync epics with the DB
      await transaction(() async {
        var epicOrder = 1;
        var taskOrder = 1;
        for (var epicData in epics) {
          // Insert epic
          final epic = EpicsTableCompanion(
            id: Value(epicData.id),
            order: Value(epicOrder),
            name: Value(epicData.name),
          );
          await into(epicsTable).insertOnConflictUpdate(epic);
          epicOrder++;

          // Insert tasks for each epic
          for (var taskData in epicData.tasks) {
            final task = TasksTableCompanion(
              id: Value(taskData.id),
              epicId: Value(epicData.id),
              order: Value(taskOrder),
              name: Value(taskData.name),
            );
            await into(tasksTable).insertOnConflictUpdate(task);
            taskOrder++;
          }
        }
      });
    } on FormatException catch (e) {
      // TODO: Error monitoring
      log(e.toString());
      rethrow;
    }
    return;
  }

  // *************** Apps *****************

  /// Get all the apps stored in the DB
  Stream<List<AppModel>> watchAppsList() {
    return select(appProjectsTable).watch().map((apps) =>
        apps.map((app) => AppModel(id: app.id, name: app.name)).toList());
  }

  /// Get a specific app by ID
  Stream<AppModel?> watchAppById(int id) {
    return (select(appProjectsTable)..where((app) => app.id.equals(id)))
        .watchSingleOrNull()
        .map(
            (app) => app != null ? AppModel(id: app.id, name: app.name) : null);
  }

  /// Create a new app by name
  Future<int> createNewApp({required String name}) async {
    return into(appProjectsTable).insert(AppProjectsTableCompanion(
      name: Value(name),
    ));
  }

  /// Edit the name of an existing app by ID
  Future<bool> editAppName(
      {required int projectId, required String newName}) async {
    return update(appProjectsTable).replace(AppProjectsTableCompanion(
      id: Value(projectId),
      name: Value(newName),
    ));
  }

  /// Delete an app by ID
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

  // *************** Epics *****************

  /// Check if the epics table is empty (used by the app startup logic)
  Future<bool> isEpicsTableEmpty() async {
    final query = selectOnly(epicsTable)..addColumns([epicsTable.id.count()]);
    final result = await query
        .map((row) => row.read<int>(epicsTable.id.count()))
        .getSingle();
    return result == 0;
  }

  /// Fetch all epics and tasks (needed by the EpicsChecklistScreen)
  Future<List<EpicModel>> fetchAllEpicsAndTasks() async {
    final epicWithTasks = await (select(epicsTable).join(
      [leftOuterJoin(tasksTable, tasksTable.epicId.equalsExp(epicsTable.id))],
    )..orderBy([
            OrderingTerm.asc(epicsTable.order),
            OrderingTerm.asc(tasksTable.order),
          ]))
        .get();

    // Transform the query result into a list of Epics with their associated tasks
    final List<EpicModel> epics = [];
    final Map<String, List<TaskModel>> tasksMap = {};

    // Iterate through all the results (one row for each task)
    for (final row in epicWithTasks) {
      final epicEntry = row.readTable(epicsTable);
      final taskEntry = row.readTableOrNull(tasksTable);

      // Add task to the corresponding list in tasksMap
      if (taskEntry != null) {
        final task = TaskModel(
          id: taskEntry.id,
          name: taskEntry.name,
        );
        tasksMap.putIfAbsent(epicEntry.id, () => []).add(task);
      }

      // If the epic is not yet in the list, add it
      if (!epics.any((epic) => epic.id == epicEntry.id)) {
        epics.add(EpicModel(
          id: epicEntry.id,
          name: epicEntry.name,
          tasks: tasksMap[epicEntry.id] ?? [],
        ));
      }
    }

    // The list 'epics' is already ordered by the 'epicsTable.order' due to the SQL 'orderBy'
    return epics;
  }

  // *************** Tasks *****************

  /// Get the total number of tasks (originally loaded from the JSON template)
  Stream<int> watchTotalTasksCount() {
    // Define the query to count all tasks
    final query = selectOnly(tasksTable)..addColumns([tasksTable.id.count()]);

    // Create the stream and map the result to the count of tasks
    return query
        .watchSingle()
        .map((row) => row.read<int>(tasksTable.id.count()) ?? 0);
  }

  // Get all the tasks for a given app and epic
  Stream<List<TaskModel>> watchTasksForAppAndEpic(
      {required int projectId, required String epicId}) {
    // Create a joined query that includes both TaskStatusesTable and TasksTable
    final query = select(tasksTable).join(
      [
        leftOuterJoin(
          taskStatusesTable,
          taskStatusesTable.taskId.equalsExp(tasksTable.id) &
              taskStatusesTable.projectId.equals(projectId),
        ),
      ],
    )
      // Filter by epicId
      ..where(tasksTable.epicId.equals(epicId))
      // Order by task order
      ..orderBy([OrderingTerm.asc(tasksTable.order)]);

    // Transform the query stream into a stream of TaskModel lists
    return query.watch().map((rows) {
      return rows.map((row) {
        // Read the task entry
        final taskEntry = row.readTable(tasksTable);
        // Read the task status entry or null if there is no match
        final taskStatusEntry = row.readTableOrNull(taskStatusesTable);

        // Create a TaskModel, with completed status defaulting to false if null
        return TaskModel(
          id: taskEntry.id,
          name: taskEntry.name,
          completed: taskStatusEntry?.completed ?? false,
        );
      }).toList();
    });
  }

  /// Get the completed tasks for a given project
  /// - if epicId is not-null, filter by that epic
  /// - otherwise, filter by the projectId only
  Stream<int> watchCompletedTasksCount(
      {required int projectId, String? epicId}) {
    // Create a joined query that includes both TaskStatusesTable and TasksTable
    final query = select(taskStatusesTable).join(
      [
        innerJoin(
          tasksTable,
          tasksTable.id.equalsExp(taskStatusesTable.taskId),
        )
      ],
    );

    // Apply the where clause to filter by projectId and optionally by epicId
    query.where(
      taskStatusesTable.projectId.equals(projectId) &
          taskStatusesTable.completed.equals(true) &
          (epicId == null
              ? const Constant(true)
              : tasksTable.epicId.equals(epicId)),
    );

    // Watch the query and map the result to the count of completed tasks
    return query.watch().map((rows) {
      // Count only the rows that have a matching taskId in the taskStatusesTable
      return rows
          .where((row) => row.readTable(taskStatusesTable).completed)
          .length;
    });
  }

  /// Update the completion status of a given task
  Future<void> updateTaskCompletionStatus({
    required int projectId,
    required String taskId,
    required bool isCompleted,
  }) async {
    final taskStatus = TaskStatusesTableCompanion(
      projectId: Value(projectId),
      taskId: Value(taskId),
      completed: Value(isCompleted),
    );

    // Use upsert to insert or update the task status
    await into(taskStatusesTable).insertOnConflictUpdate(taskStatus);
  }
}

// * Riverpod providers for the DB methods above

// *************** Epics *****************

@riverpod
Future<List<EpicModel>> fetchAllEpicsAndTasks(FetchAllEpicsAndTasksRef ref) {
  return ref.watch(appDatabaseProvider).fetchAllEpicsAndTasks();
}

// *************** Apps *****************

@riverpod
Stream<List<AppModel>> watchAppsList(WatchAppsListRef ref) {
  return ref.watch(appDatabaseProvider).watchAppsList();
}

@riverpod
Stream<AppModel?> watchAppById(WatchAppByIdRef ref, int id) {
  return ref.watch(appDatabaseProvider).watchAppById(id);
}

// *************** Tasks *****************

@riverpod
Stream<int> watchTotalTasksCount(WatchTotalTasksCountRef ref) {
  return ref.watch(appDatabaseProvider).watchTotalTasksCount();
}

@riverpod
Stream<List<TaskModel>> watchTasksForAppAndEpic(WatchTasksForAppAndEpicRef ref,
    {required int projectId, required String epicId}) {
  return ref
      .watch(appDatabaseProvider)
      .watchTasksForAppAndEpic(projectId: projectId, epicId: epicId);
}

@riverpod
Stream<int> watchCompletedTasksCount(WatchCompletedTasksCountRef ref,
    {required int projectId, String? epicId}) {
  return ref
      .watch(appDatabaseProvider)
      .watchCompletedTasksCount(projectId: projectId, epicId: epicId);
}
