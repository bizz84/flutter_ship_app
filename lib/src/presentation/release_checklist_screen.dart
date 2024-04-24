import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/data/category.dart';
import 'package:flutter_ship_app/src/data/template_loader.dart';

class ReleaseChecklistScreen extends ConsumerWidget {
  const ReleaseChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(loadFromTemplateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('App Release Checklist')),
      body: categoriesAsync.when(
        data: (categories) => ReleaseChecklistListView(categories: categories),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class ReleaseChecklistListView extends ConsumerWidget {
  const ReleaseChecklistListView({super.key, required this.categories});
  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: categories.length,
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
