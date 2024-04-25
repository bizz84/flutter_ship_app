import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/error_prompt.dart';
import 'package:flutter_ship_app/src/data/app_database_crud.dart';
import 'package:flutter_ship_app/src/presentation/create_edit_app_screen.dart';
import 'package:flutter_ship_app/src/presentation/epics_checklist_screen.dart';

class AppsListScreen extends ConsumerWidget {
  const AppsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Apps'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const CreateOrEditAppScreen(),
              ),
            ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const AppsListView(),
    );
  }
}

class AppsListView extends ConsumerWidget {
  const AppsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsListAsync = ref.watch(appsListProvider);
    return appsListAsync.when(
      data: (appsList) {
        if (appsList.isEmpty) {
          return const Placeholder();
        } else {
          return ListView.separated(
            itemCount: appsList.length,
            separatorBuilder: (context, index) => const Divider(height: 0.5),
            itemBuilder: (_, index) {
              final app = appsList[index];
              return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => EpicsChecklistScreen(app: app),
                )),
                title: Text(app.name),
                trailing: const Icon(Icons.chevron_right),
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
