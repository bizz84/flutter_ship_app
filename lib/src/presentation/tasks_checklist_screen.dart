import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/data/category.dart';
import 'package:flutter_ship_app/src/data/task.dart';

class TasksChecklistScreen extends ConsumerWidget {
  const TasksChecklistScreen({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(category.category)),
      body: TasksChecklistListView(tasks: category.tasks),
    );
  }
}

class TasksChecklistListView extends ConsumerWidget {
  const TasksChecklistListView({super.key, required this.tasks});
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (context, index) => const Divider(height: 0.5),
      itemBuilder: (_, index) {
        final task = tasks[index];
        return TaskListTile(
          task: task,
          completed: index % 2 == 0,
        );
      },
    );
  }
}

class TaskListTile extends StatelessWidget {
  const TaskListTile({super.key, required this.task, required this.completed});
  final Task task;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: completed
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.check_circle_outline_rounded),
      title: Text(task.description),
      //subtitle: Text('$completedCount of ${category.tasks.length} completed'),
      dense: true,
    );
  }
}
