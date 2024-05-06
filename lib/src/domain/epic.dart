import 'package:flutter_ship_app/src/domain/task.dart';

/// A model class representing an epic (collection of tasks)
class Epic {
  Epic({required this.id, required this.name, required this.tasks});
  final String id;
  final String name;
  final List<Task> tasks;

  // parse from template
  factory Epic.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! String) {
      throw FormatException(
          'Invalid JSON: required "id" field of type String in $json');
    }
    final name = json['epic'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "epic" field of type String in $json');
    }
    final tasks = json['tasks'];
    if (tasks is! List<dynamic>) {
      throw FormatException(
          'Invalid JSON: required "tasks" field of type List in $json');
    }
    final decodedTasks = tasks.map((task) => Task.fromJson(task)).toList();
    return Epic(id: id, name: name, tasks: decodedTasks);
  }

  @override
  String toString() => 'Epic(id: $id, name: $name, tasks: $tasks)';
}
