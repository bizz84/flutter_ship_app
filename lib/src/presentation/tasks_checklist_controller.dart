import 'dart:developer';

import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/data/in_app_review_counter.dart';
import 'package:flutter_ship_app/src/monitoring/analytics_facade.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_checklist_controller.g.dart';

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
        final completedTasksCount =
            await ref.read(appDatabaseProvider).fetchCompletedTasksCount();
        ref
            .read(analyticsFacadeProvider)
            .trackCompleteTask(completedTasksCount);
        // * Show app review prompt based on some conditional logic.
        // * The completedTasksCount thresholds can be determined from the
        // * analytics data
        final inAppReviewCount = ref.read(inAppReviewCounterProvider);
        if (completedTasksCount >= 5 && inAppReviewCount == 0 ||
            completedTasksCount >= 15 && inAppReviewCount == 1 ||
            completedTasksCount >= 35 && inAppReviewCount == 2) {
          ref
              .read(inAppReviewCounterProvider.notifier)
              .requestReviewAndIncrementCount(completedTasksCount);
        }
      }
    });
  }
}
