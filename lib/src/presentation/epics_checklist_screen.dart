import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/epic_entity.dart';
import 'package:flutter_ship_app/src/presentation/tasks_checklist_screen.dart';

class EpicsChecklistScreen extends ConsumerWidget {
  const EpicsChecklistScreen({super.key, required this.appName});
  final String appName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final epicsAsync = ref.watch(loadAllEpicsAndTasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(appName),
            Text(
              'Release Checklist',
              // TODO: Styling
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => log('TODO: Implement me'),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: epicsAsync.when(
        data: (epics) => EpicsChecklistListView(epics: epics),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class EpicsChecklistListView extends ConsumerWidget {
  const EpicsChecklistListView({super.key, required this.epics});
  final List<EpicEntity> epics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: epics.length,
      separatorBuilder: (context, index) => const Divider(height: 0.5),
      itemBuilder: (_, index) {
        final epic = epics[index];
        return EpicListTile(
          epic: epic,
          completedCount: (epic.tasks.length - index) % epic.tasks.length + 1,
        );
      },
    );
  }
}

class EpicListTile extends StatelessWidget {
  const EpicListTile(
      {super.key, required this.epic, required this.completedCount});
  final EpicEntity epic;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TasksChecklistScreen(epic: epic),
          ),
        );
      },
      leading: completedCount == epic.tasks.length
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.check_circle_outline_rounded),
      title: Text(epic.epic),
      subtitle: Text('$completedCount of ${epic.tasks.length} completed'),
      trailing: const Icon(Icons.chevron_right),
      dense: true,
    );
  }
}
