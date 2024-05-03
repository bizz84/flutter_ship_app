import 'package:flutter_ship_app/src/domain/task_model.dart';

/// A model class representing an epic (collection of tasks)
class EpicModel {
  EpicModel({required this.id, required this.name, required this.tasks});
  final String id;
  final String name;
  final List<TaskModel> tasks;
}
