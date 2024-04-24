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
      appBar: AppBar(),
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
        return null;
      },
    );
  }
}
