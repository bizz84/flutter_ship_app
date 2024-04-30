import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/custom_completion_list_tile.dart';
import 'package:flutter_ship_app/src/common_widgets/custom_progress_checkmark.dart';
import 'package:flutter_ship_app/src/common_widgets/error_prompt.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center_scrollable.dart';
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
    final scrollController = ScrollController();
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
      body: ResponsiveCenterScrollable(
        controller: scrollController,
        child: AppsListView(
          controller: scrollController,
          totalTasksCount: totalTasksCount,
          onNewApp: () => _createNewApp(context),
        ),
      ),
    );
  }
}

class AppsListView extends ConsumerWidget {
  const AppsListView(
      {super.key,
      required this.totalTasksCount,
      required this.onNewApp,
      this.controller});
  final int? totalTasksCount;
  final VoidCallback onNewApp;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsListAsync = ref.watch(appsListProvider);
    return appsListAsync.when(
      data: (appsList) {
        if (appsList.isEmpty) {
          return EmptyPlaceholderAppIntro(
            onNewApp: onNewApp,
          );
        } else {
          return ListView.separated(
            controller: controller,
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

class EmptyPlaceholderAppIntro extends StatelessWidget {
  const EmptyPlaceholderAppIntro({super.key, required this.onNewApp});
  final VoidCallback onNewApp;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaler.scale(1.0);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome to Flutter Ship'.hardcoded,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          gapH4,
          Text(
            'Your App Release Checklist'.hardcoded,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          gapH12,
          Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 80 + 150 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH8,
                  EmptyPlaceholderListTile(
                    title: 'Flutter Flavors'.hardcoded,
                    completedCount: 4,
                    totalCount: 4,
                  ),
                  gapH12,
                  EmptyPlaceholderListTile(
                    title: 'Error Monitoring'.hardcoded,
                    completedCount: 4,
                    totalCount: 6,
                  ),
                  gapH12,
                  EmptyPlaceholderListTile(
                    title: 'Analytics'.hardcoded,
                    completedCount: 5,
                    totalCount: 7,
                  ),
                  gapH8,
                ],
              ),
            ),
          ),
          gapH48,
          Text(
            'Add a new app to get started'.hardcoded,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          gapH16,
          ElevatedButton(
            onPressed: onNewApp,
            child: Text('New App'.hardcoded),
          )
        ],
      ),
    );
  }
}

class EmptyPlaceholderListTile extends StatelessWidget {
  const EmptyPlaceholderListTile({
    super.key,
    required this.title,
    required this.completedCount,
    required this.totalCount,
  });
  final String title;
  final int completedCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Sizes.p20, vertical: Sizes.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Sizes.p24,
            height: Sizes.p24,
            child: CustomProgressCheckmark(
              value: completedCount / totalCount,
              fillColor: Theme.of(context).colorScheme.secondary,
              checkmarkColor: Colors.white,
              strokeWidth: 2.5,
            ),
          ),
          gapW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                ),
                gapH4,
                AutoSizeText(
                  '$completedCount of $totalCount completed'.hardcoded,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
