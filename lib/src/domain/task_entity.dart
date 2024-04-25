class TaskEntity {
  TaskEntity(
      {required this.id, required this.description, this.completed = false});
  final int id;
  final String description;
  final bool completed;
}
