import 'dart:developer';

import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_checklist_controller.g.dart';

/// Helper controller class for the TasksChecklistScreen widget.
/// This class holds the business logic updating the task completion status
/// using the underlying AppDatabase class for data persistence.
/// More info here: https://codewithandrea.com/articles/flutter-presentation-layer/
@riverpod
class TasksChecklistController extends _$TasksChecklistController {
  @override
  // ignore:no-empty-block
  FutureOr<void> build() async {
    // no-op
  }

  Future<void> updateTaskCompletionStatus({
    required int appId,
    required String taskId,
    required bool isCompleted,
  }) async {
    log('appId: $appId, taskId: $taskId, completed: $isCompleted');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(appDatabaseProvider).updateTaskCompletionStatus(
            appId: appId,
            taskId: taskId,
            isCompleted: isCompleted,
          );
      if (isCompleted) {
        // TODO: Analytics
      }
    });
  }
}
