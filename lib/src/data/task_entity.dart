class TaskEntity {
  TaskEntity({required this.id, required this.description});
  final int id;
  final String description;

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'],
      description: json['description'],
    );
  }
}
