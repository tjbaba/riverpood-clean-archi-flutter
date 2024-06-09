import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_model.dart';

class TaskLocalDataSource {
  final Box<TaskModel> taskBox;

  TaskLocalDataSource(this.taskBox);

  List<TaskModel> getTask(){
    return taskBox.values.toList();
  }

  void addTask(TaskModel task) {
    taskBox.add(task);
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);
  }

}