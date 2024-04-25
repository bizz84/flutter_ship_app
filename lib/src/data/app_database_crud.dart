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

@riverpod
Stream<List<AppEntity>> appsList(AppsListRef ref) {
  return ref.watch(appDatabaseProvider).watchAppsList();
}

@riverpod
Stream<AppEntity?> appById(AppByIdRef ref, int id) {
  return ref.watch(appDatabaseProvider).watchAppById(id);
}
