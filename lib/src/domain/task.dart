/// A model class representing a task
class Task {
  Task({required this.id, required this.name, this.completed = false});
  final String id;
  final String name;
  final bool completed;

  factory Task.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! String) {
      throw FormatException(
          'Invalid JSON: required "id" field of type String in $json');
    }
    final name = json['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $json');
    }
    // * Note: completed flag doesn't exist in the JSON and will be ignored
    // * when syncing with the DB
    return Task(id: id, name: name, completed: false);
  }

  @override
  String toString() => 'Task(id: $id, name: $name, completed: $completed)';
}
