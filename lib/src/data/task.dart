class Task {
  Task({required this.id, required this.description});
  final int id;
  final String description;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
    );
  }
}
