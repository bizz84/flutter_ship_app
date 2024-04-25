import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app_entity.dart';
import 'package:flutter_ship_app/src/domain/epic_entity.dart';
import 'package:flutter_ship_app/src/presentation/create_edit_app_screen.dart';
import 'package:flutter_ship_app/src/presentation/custom_checkmark.dart';
import 'package:flutter_ship_app/src/presentation/tasks_checklist_screen.dart';

class EpicsChecklistScreen extends ConsumerWidget {
  const EpicsChecklistScreen({super.key, required this.app});
  final AppEntity app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            // * Observe app name since it can change during editing
            Consumer(
              builder: (context, ref, child) {
                final updatedApp =
                    ref.watch(appByIdProvider(app.id)).valueOrNull ?? app;
                return Text(updatedApp.name);
              },
            ),
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
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => CreateOrEditAppScreen(app: app),
              ),
            ),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: EpicsChecklistListView(app: app),
    );
  }
}

class EpicsChecklistListView extends ConsumerWidget {
  const EpicsChecklistListView({super.key, required this.app});
  final AppEntity app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final epicsAsync = ref.watch(loadAllEpicsAndTasksProvider);
    return epicsAsync.when(
      data: (epics) => ListView.separated(
        itemCount: epics.length,
        separatorBuilder: (context, index) => const Divider(height: 0.5),
        itemBuilder: (_, index) {
          final epic = epics[index];
          return EpicListTile(
            app: app,
            epic: epic,
            completedCount: (epic.tasks.length - index) % epic.tasks.length + 1,
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text(e.toString())),
    );
  }
}

class EpicListTile extends ConsumerWidget {
  const EpicListTile({
    super.key,
    required this.app,
    required this.epic,
    required this.completedCount,
  });
  final AppEntity app;
  final EpicEntity epic;
  final int completedCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedCountAsync = ref.watch(
        watchCompletedTasksCountProvider(projectId: app.id, epicId: epic.id));
    final completedCount = completedCountAsync.valueOrNull ?? 0;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TasksChecklistScreen(app: app, epic: epic),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p20, vertical: Sizes.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CustomCheckmark(
                value: completedCount / epic.tasks.length,
                fillColor: Theme.of(context).colorScheme.secondary,
                strokeWidth: 2,
              ),
            ),
            gapW24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  epic.epic,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                gapH4,
                Text(
                  '$completedCount of ${epic.tasks.length} completed',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              // TODO: what color to use here?
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
