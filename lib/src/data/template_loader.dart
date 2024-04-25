import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/epic_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'template_loader.g.dart';

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
