import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center_scrollable.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:flutter_ship_app/src/domain/epic.dart';
import 'package:flutter_ship_app/src/domain/task.dart';

/// Screen for showing a list of tasks for a given epic
class TasksChecklistScreen extends ConsumerWidget {
  const TasksChecklistScreen(
      {super.key, required this.app, required this.epic});
  final App app;
  final Epic epic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Watch tasks and rebuild the UI if their completion status changes
    final tasksAsync = ref
        .watch(watchTasksForAppAndEpicProvider(appId: app.id, epicId: epic.id));
    final tasks = tasksAsync.valueOrNull ?? epic.tasks;
    final scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          epic.name,
          maxLines: 1,
        ),
      ),
      body: ResponsiveCenterScrollable(
        controller: scrollController,
        child: ListView.separated(
          controller: scrollController,
          itemCount: tasks.length,
          separatorBuilder: (context, index) => const Divider(height: 0.5),
          itemBuilder: (_, index) {
            final task = tasks[index];
            return CheckboxTaskListTile(
              task: task,
              completed: task.completed,
              onChanged: (completed) async {
                log('appId: ${app.id}, taskId: ${task.id}, completed: $completed');
                await ref.read(appDatabaseProvider).updateTaskCompletionStatus(
                      appId: app.id,
                      taskId: task.id,
                      isCompleted: completed,
                    );
              },
            );
          },
        ),
      ),
    );
  }
}

/// A widget for updating the status of a task using a checkbox
class CheckboxTaskListTile extends StatelessWidget {
  const CheckboxTaskListTile(
      {super.key,
      required this.task,
      required this.completed,
      required this.onChanged});
  final Task task;
  final bool completed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: completed,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      title: Text(
        task.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.only(
          left: Sizes.p8, top: Sizes.p8, right: Sizes.p24, bottom: Sizes.p8),
    );
  }
}
