import 'package:flutter_ship_app/src/domain/task_entity.dart';

class EpicEntity {
  EpicEntity({required this.id, required this.epic, required this.tasks});
  final int id;
  final String epic;
  final List<TaskEntity> tasks;
}
