import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_database.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app_entity.dart';
import 'package:flutter_ship_app/src/domain/epic_entity.dart';
import 'package:flutter_ship_app/src/domain/task_entity.dart';

class TasksChecklistScreen extends ConsumerWidget {
  const TasksChecklistScreen(
      {super.key, required this.app, required this.epic});
  final AppEntity app;
  final EpicEntity epic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(
        watchTasksForAppAndEpicProvider(projectId: app.id, epicId: epic.id));
    final tasks = tasksAsync.valueOrNull ?? epic.tasks;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          epic.epic,
          maxLines: 1,
        ),
      ),
      body: ResponsiveCenter(
        child: ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (context, index) => const Divider(height: 0.5),
          itemBuilder: (_, index) {
            final task = tasks[index];
            return TaskListTile(
              task: task,
              completed: task.completed,
              onChanged: (completed) async {
                log('appId: ${app.id}, epicId: ${epic.id}, taskId: ${task.id}, completed: $completed');
                await ref.read(appDatabaseProvider).updateTaskCompletionStatus(
                      projectId: app.id,
                      epicId: epic.id,
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

class TaskListTile extends StatelessWidget {
  const TaskListTile(
      {super.key,
      required this.task,
      required this.completed,
      required this.onChanged});
  final TaskEntity task;
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
        task.description,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.only(
          left: Sizes.p8, top: Sizes.p8, right: Sizes.p24, bottom: Sizes.p8),
    );
  }
}
