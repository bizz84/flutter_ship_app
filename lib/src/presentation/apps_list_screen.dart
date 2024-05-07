import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/custom_completion_list_tile.dart';
import 'package:flutter_ship_app/src/common_widgets/custom_progress_checkmark.dart';
import 'package:flutter_ship_app/src/common_widgets/error_prompt.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center_scrollable.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:flutter_ship_app/src/presentation/create_edit_app_screen.dart';
import 'package:flutter_ship_app/src/presentation/epics_checklist_screen.dart';
import 'package:flutter_ship_app/src/presentation/settings_screen.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';

/// This is the home page for the app
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
    final appsListAsync = ref.watch(watchAppsListProvider);
    final appsListNotEmpty = appsListAsync.valueOrNull?.isNotEmpty == true;
    final scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Settings'.hardcoded,
          icon: Icon(
            Icons.settings,
            semanticLabel: 'Settings'.hardcoded,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => const SettingsScreen(),
            ),
          ),
        ),
        title: appsListNotEmpty ? Text('My Apps'.hardcoded) : null,
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
          onNewApp: () => _createNewApp(context),
        ),
      ),
    );
  }
}

/// A list view used to show the list of apps, or a WelcomeAppIntro widget
/// if the list is empty
class AppsListView extends ConsumerWidget {
  const AppsListView({super.key, required this.onNewApp, this.controller});
  final VoidCallback onNewApp;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * The totalTasksCount is the same for all apps, because tasks are loaded
    // * from the same teplate. So we can watch it here and pass it to each
    // * AppListTile below.
    final totalTasksCount = ref.watch(watchTotalTasksCountProvider).valueOrNull;
    final appsListAsync = ref.watch(watchAppsListProvider);
    return appsListAsync.when(
      data: (appsList) {
        if (appsList.isEmpty) {
          return WelcomeAppIntro(onNewApp: onNewApp);
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
      error: (e, st) => Center(child: ErrorPrompt(message: e.toString())),
    );
  }
}

/// A ListTile for showing a single app with its completion status
class AppListTile extends ConsumerWidget {
  const AppListTile({
    super.key,
    required this.totalTasksCount,
    required this.app,
  });
  final int? totalTasksCount;
  final App app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedCountAsync =
        ref.watch(watchCompletedTasksCountProvider(appId: app.id));
    final completedCount = completedCountAsync.valueOrNull ?? 0;
    return CustomCompletionListTile(
      title: app.name,
      // * use 1 as fallback to prevent division by 0
      totalCount: totalTasksCount ?? 1,
      completedCount: completedCount,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EpicsChecklistScreen(app: app),
        ),
      ),
    );
  }
}

/// A welcome widget for when the list of apps is empty
class WelcomeAppIntro extends StatelessWidget {
  const WelcomeAppIntro({super.key, required this.onNewApp});
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
            style: Theme.of(context).textTheme.headlineSmall,
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
                  ExampleListTile(
                    title: 'Flutter Flavors'.hardcoded,
                    completedCount: 4,
                    totalCount: 4,
                  ),
                  gapH12,
                  ExampleListTile(
                    title: 'Error Monitoring'.hardcoded,
                    completedCount: 4,
                    totalCount: 6,
                  ),
                  gapH12,
                  ExampleListTile(
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

/// An example list tile to be used in the WelcomeAppIntro
class ExampleListTile extends StatelessWidget {
  const ExampleListTile({
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
              value: min(completedCount / totalCount, 1.0),
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
