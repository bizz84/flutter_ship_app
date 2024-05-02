import 'package:flutter_ship_app/src/domain/task_model.dart';

/// A model class representing an epic (collection of tasks)
class EpicModel {
  EpicModel({required this.id, required this.epic, required this.tasks});
  final int id;
  final String epic;
  final List<TaskModel> tasks;
}
