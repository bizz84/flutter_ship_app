import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/data/category.dart';
import 'package:flutter_ship_app/src/data/template_loader.dart';
import 'package:flutter_ship_app/src/presentation/tasks_checklist_screen.dart';

class CategoriesChecklistScreen extends ConsumerWidget {
  const CategoriesChecklistScreen({super.key, required this.appName});
  final String appName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(loadFromTemplateProvider);
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
      body: categoriesAsync.when(
        data: (categories) =>
            CategoriesChecklistListView(categories: categories),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class CategoriesChecklistListView extends ConsumerWidget {
  const CategoriesChecklistListView({super.key, required this.categories});
  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: categories.length,
      separatorBuilder: (context, index) => const Divider(height: 0.5),
      itemBuilder: (_, index) {
        final category = categories[index];
        return CategoryListTile(
          category: category,
          completedCount:
              (category.tasks.length - index) % category.tasks.length + 1,
        );
      },
    );
  }
}

class CategoryListTile extends StatelessWidget {
  const CategoryListTile(
      {super.key, required this.category, required this.completedCount});
  final Category category;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TasksChecklistScreen(category: category),
          ),
        );
      },
      leading: completedCount == category.tasks.length
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.check_circle_outline_rounded),
      title: Text(category.category),
      subtitle: Text('$completedCount of ${category.tasks.length} completed'),
      trailing: const Icon(Icons.chevron_right),
      dense: true,
    );
  }
}
