import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/presentation/categories_checklist_screen.dart';

class AppsListScreen extends ConsumerWidget {
  const AppsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Watch list of apps
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Apps'),
        actions: [
          IconButton(
            onPressed: () => log('TODO: Implement me'),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      // TODO: Empty UI
      body: const AppsListView(),
    );
  }
}

class AppsListView extends StatelessWidget {
  const AppsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 1,
      separatorBuilder: (context, index) => const Divider(height: 0.5),
      itemBuilder: (_, index) {
        return ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const CategoriesChecklistScreen(
              appName: 'Flutter Tips',
            ),
          )),
          title: const Text('Flutter Tips'),
          trailing: const Icon(Icons.chevron_right),
        );
      },
    );
  }
}
