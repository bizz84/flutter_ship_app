/// A model class representing a task
class TaskModel {
  TaskModel({required this.id, required this.name, this.completed = false});
  final String id;
  final String name;
  final bool completed;
}
