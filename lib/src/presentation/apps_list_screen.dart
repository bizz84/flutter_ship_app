import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/custom_completion_list_tile.dart';
import 'package:flutter_ship_app/src/common_widgets/error_prompt.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/constants/strings.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app_entity.dart';
import 'package:flutter_ship_app/src/presentation/create_edit_app_screen.dart';
import 'package:flutter_ship_app/src/presentation/epics_checklist_screen.dart';
import 'package:flutter_ship_app/src/presentation/settings_screen.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';

class AppsListScreen extends ConsumerWidget {
  const AppsListScreen({super.key});

  Future<void> _createNewApp(BuildContext context) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const CreateOrEditAppScreen(),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalTasksCount = ref.watch(watchTotalTasksCountProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Settings'.hardcoded,
          icon: Icon(
            Icons.settings,
            semanticLabel: 'Settings'.hardcoded,
          ),
          onPressed: () {
            Navigator.of(context).push<int>(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const SettingsScreen(),
              ),
            );
          },
        ),
        title: Text(Strings.myAppsTitle),
        actions: [
          IconButton(
            tooltip: 'Create a new app'.hardcoded,
            onPressed: () => _createNewApp(context),
            icon: Icon(
              Icons.add,
              semanticLabel: 'Create a new app'.hardcoded,
            ),
          )
        ],
      ),
      body: AppsListView(
        totalTasksCount: totalTasksCount,
        onNewApp: () => _createNewApp(context),
      ),
    );
  }
}

class AppsListView extends ConsumerWidget {
  const AppsListView(
      {super.key, required this.totalTasksCount, required this.onNewApp});
  final int? totalTasksCount;
  final VoidCallback onNewApp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsListAsync = ref.watch(appsListProvider);
    return appsListAsync.when(
      data: (appsList) {
        if (appsList.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add a new app to get started'.hardcoded,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                gapH16,
                ElevatedButton(
                  onPressed: onNewApp,
                  child: Text('New App'.hardcoded),
                )
              ],
            ),
          );
        } else {
          return ListView.separated(
            itemCount: appsList.length,
            separatorBuilder: (context, index) => const Divider(height: 0.5),
            itemBuilder: (_, index) {
              final app = appsList[index];
              return AppListTile(
                totalTasksCount: totalTasksCount,
                app: app,
              );
            },
          );
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: ErrorPrompt(exception: e)),
    );
  }
}

class AppListTile extends ConsumerWidget {
  const AppListTile({
    super.key,
    required this.totalTasksCount,
    required this.app,
  });
  final int? totalTasksCount;
  final AppEntity app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedCountAsync =
        ref.watch(watchCompletedTasksCountProvider(projectId: app.id));
    final completedCount = completedCountAsync.valueOrNull ?? 0;
    return CustomCompletionListTile(
      title: app.name,
      totalCount: totalTasksCount ?? 0,
      completedCount: completedCount,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => EpicsChecklistScreen(app: app),
        ));
      },
    );
  }
}
