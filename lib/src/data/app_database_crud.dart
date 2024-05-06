import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:flutter_ship_app/src/domain/epic.dart';
import 'package:flutter_ship_app/src/domain/task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/common.dart';

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
      final epicsData = epicsJson.map((epic) => Epic.fromJson(epic)).toList();
      // * Sync epics with the DB
      await transaction(() async {
        var epicOrder = 1;
        var taskOrder = 1;
        for (var epicData in epicsData) {
          // Insert epic
          final epic = EpicsCompanion(
            id: Value(epicData.id),
            order: Value(epicOrder),
            name: Value(epicData.name),
          );
          await into(epics).insertOnConflictUpdate(epic);
          epicOrder++;

          // Insert tasks for each epic
          for (var taskData in epicData.tasks) {
            final task = TasksCompanion(
              id: Value(taskData.id),
              epicId: Value(epicData.id),
              order: Value(taskOrder),
              name: Value(taskData.name),
            );
            await into(tasks).insertOnConflictUpdate(task);
            taskOrder++;
          }
        }
      });
    } on FormatException catch (e) {
      // TODO: Error monitoring
      log(e.toString());
      rethrow;
    } on SqliteException catch (e) {
      // TODO: Error monitoring
      log(e.toString());
      rethrow;
    }
  }

  // *************** Apps *****************

  /// Get all the apps stored in the DB
  Stream<List<App>> watchAppsList() {
    return select(apps).watch().map(
        (apps) => apps.map((app) => App(id: app.id, name: app.name)).toList());
  }

  /// Get a specific app by ID
  Stream<App?> watchAppById(int id) {
    return (select(apps)..where((app) => app.id.equals(id)))
        .watchSingleOrNull()
        .map((app) => app != null ? App(id: app.id, name: app.name) : null);
  }

  /// Create a new app by name
  Future<int> createNewApp({required String name}) async {
    return into(apps).insert(AppsCompanion(
      name: Value(name),
    ));
  }

  /// Edit the name of an existing app by ID
  Future<bool> editAppName(
      {required int appId, required String newName}) async {
    return update(apps).replace(AppsCompanion(
      id: Value(appId),
      name: Value(newName),
    ));
  }

  /// Delete an app by ID
  Future<void> deleteAppById(int appId) async {
    await transaction(() async {
      // Delete all associated TaskStatuses for the given appId
      await (delete(taskStatuses)
            ..where((taskStatus) => taskStatus.appId.equals(appId)))
          .go();

      // Now, delete the App row with the given appId
      await (delete(apps)..where((app) => app.id.equals(appId))).go();
    });
  }

  // *************** Epics *****************

  /// Check if the epics table is empty (used by the app startup logic)
  Future<bool> isEpicsTableEmpty() async {
    final query = selectOnly(epics)..addColumns([epics.id.count()]);
    final result =
        await query.map((row) => row.read<int>(epics.id.count())).getSingle();
    return result == 0;
  }

  /// Fetch all epics and tasks (needed by the EpicsChecklistScreen)
  Future<List<Epic>> fetchAllEpicsAndTasks() async {
    final epicWithTasks = await (select(epics).join(
      [leftOuterJoin(tasks, tasks.epicId.equalsExp(epics.id))],
    )..orderBy([
            OrderingTerm.asc(epics.order),
            OrderingTerm.asc(tasks.order),
          ]))
        .get();

    // Transform the query result into a list of Epics with their associated tasks
    final List<Epic> epicsResult = [];
    final Map<String, List<Task>> tasksMap = {};

    // Iterate through all the results (one row for each task)
    for (final row in epicWithTasks) {
      final epicEntry = row.readTable(epics);
      final taskEntry = row.readTableOrNull(tasks);

      // Add task to the corresponding list in tasksMap
      if (taskEntry != null) {
        final task = Task(
          id: taskEntry.id,
          name: taskEntry.name,
        );
        tasksMap.putIfAbsent(epicEntry.id, () => []).add(task);
      }

      // If the epic is not yet in the list, add it
      if (!epicsResult.any((epic) => epic.id == epicEntry.id)) {
        epicsResult.add(Epic(
          id: epicEntry.id,
          name: epicEntry.name,
          tasks: tasksMap[epicEntry.id] ?? [],
        ));
      }
    }

    // The list 'epics' is already ordered by the 'epicsTable.order' due to the SQL 'orderBy'
    return epicsResult;
  }

  // *************** Tasks *****************

  /// Get the total number of tasks (originally loaded from the JSON template)
  Stream<int> watchTotalTasksCount() {
    // Define the query to count all tasks
    final query = selectOnly(tasks)..addColumns([tasks.id.count()]);

    // Create the stream and map the result to the count of tasks
    return query
        .watchSingle()
        .map((row) => row.read<int>(tasks.id.count()) ?? 0);
  }

  // Get all the tasks for a given app and epic
  Stream<List<Task>> watchTasksForAppAndEpic(
      {required int appId, required String epicId}) {
    // Create a joined query that includes both TaskStatusesTable and TasksTable
    final query = select(tasks).join(
      [
        leftOuterJoin(
          taskStatuses,
          taskStatuses.taskId.equalsExp(tasks.id) &
              taskStatuses.appId.equals(appId),
        ),
      ],
    )
      // Filter by epicId
      ..where(tasks.epicId.equals(epicId))
      // Order by task order
      ..orderBy([OrderingTerm.asc(tasks.order)]);

    // Transform the query stream into a stream of TaskModel lists
    return query.watch().map((rows) {
      return rows.map((row) {
        // Read the task entry
        final taskEntry = row.readTable(tasks);
        // Read the task status entry or null if there is no match
        final taskStatusEntry = row.readTableOrNull(taskStatuses);

        // Create a TaskModel, with completed status defaulting to false if null
        return Task(
          id: taskEntry.id,
          name: taskEntry.name,
          completed: taskStatusEntry?.completed ?? false,
        );
      }).toList();
    });
  }

  /// Get the completed tasks for a given app
  /// - if epicId is not-null, filter by that epic
  /// - otherwise, filter by the appId only
  Stream<int> watchCompletedTasksCount({required int appId, String? epicId}) {
    // Create a joined query that includes both TaskStatusesTable and TasksTable
    final query = select(taskStatuses).join(
      [
        innerJoin(
          tasks,
          tasks.id.equalsExp(taskStatuses.taskId),
        )
      ],
    );

    // Apply the where clause to filter by appId and optionally by epicId
    query.where(
      taskStatuses.appId.equals(appId) &
          taskStatuses.completed.equals(true) &
          (epicId == null ? const Constant(true) : tasks.epicId.equals(epicId)),
    );

    // Watch the query and map the result to the count of completed tasks
    return query.watch().map((rows) {
      // Count only the rows that have a matching taskId in the taskStatusesTable
      return rows.where((row) => row.readTable(taskStatuses).completed).length;
    });
  }

  /// Update the completion status of a given task
  Future<void> updateTaskCompletionStatus({
    required int appId,
    required String taskId,
    required bool isCompleted,
  }) async {
    final taskStatus = TaskStatusesCompanion(
      appId: Value(appId),
      taskId: Value(taskId),
      completed: Value(isCompleted),
    );

    // Use upsert to insert or update the task status
    await into(taskStatuses).insertOnConflictUpdate(taskStatus);
  }
}

// * Riverpod providers for the DB methods above

// *************** Epics *****************

@riverpod
Future<List<Epic>> fetchAllEpicsAndTasks(FetchAllEpicsAndTasksRef ref) {
  return ref.watch(appDatabaseProvider).fetchAllEpicsAndTasks();
}

// *************** Apps *****************

@riverpod
Stream<List<App>> watchAppsList(WatchAppsListRef ref) {
  return ref.watch(appDatabaseProvider).watchAppsList();
}

@riverpod
Stream<App?> watchAppById(WatchAppByIdRef ref, int id) {
  return ref.watch(appDatabaseProvider).watchAppById(id);
}

// *************** Tasks *****************

@riverpod
Stream<int> watchTotalTasksCount(WatchTotalTasksCountRef ref) {
  return ref.watch(appDatabaseProvider).watchTotalTasksCount();
}

@riverpod
Stream<List<Task>> watchTasksForAppAndEpic(WatchTasksForAppAndEpicRef ref,
    {required int appId, required String epicId}) {
  return ref
      .watch(appDatabaseProvider)
      .watchTasksForAppAndEpic(appId: appId, epicId: epicId);
}

@riverpod
Stream<int> watchCompletedTasksCount(WatchCompletedTasksCountRef ref,
    {required int appId, String? epicId}) {
  return ref
      .watch(appDatabaseProvider)
      .watchCompletedTasksCount(appId: appId, epicId: epicId);
}
