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
  // * This controller is stateless and doesn't require any initialization.
  // * It performs mutations, but does not set the UI state or handle errors,
  // * because local DB operations are fast and unlikely to fail.
  @override
  void build() {
    // no-op
  }

  Future<void> updateTaskCompletionStatus({
    required int appId,
    required String taskId,
    required bool isCompleted,
  }) async {
    await ref.read(appDatabaseProvider).updateTaskCompletionStatus(
          appId: appId,
          taskId: taskId,
          isCompleted: isCompleted,
        );
    if (isCompleted) {
      // TODO: Analytics
    }
  }
}

// ignore_for_file:no-empty-block
