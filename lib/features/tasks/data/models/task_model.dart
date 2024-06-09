
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entitites/task.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String title;


  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime date;


  TaskModel({
    required this.title,
    required this.description,
    required this.date,
  });

  // Conversion from Entity to Model
  factory TaskModel.fromEntity(TaskM task) => TaskModel(
      title: task.title,
      description: task.description,
      date: task.date,
  );

  // Conversion from Model to Entity
  TaskM toEntity() => TaskM(
      title: title,
      description: description,
      date: date,
  );

}