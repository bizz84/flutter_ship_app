import 'package:flutter_ship_app/src/data/task.dart';

class Category {
  Category({required this.id, required this.category, required this.tasks});
  final int id;
  final String category;
  final List<Task> tasks;

  factory Category.fromJson(Map<String, dynamic> json) {
    var taskList = json['tasks'] as List;
    List<Task> tasksList = taskList.map((i) => Task.fromJson(i)).toList();
    return Category(
      id: json['id'],
      category: json['category'],
      tasks: tasksList,
    );
  }
}
