import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entitites/task.dart';

abstract class TaskRepository{
  Future<Either<Failure, List<TaskM>>> getTasks();
  Future<void> addTask(TaskM trip);
  Future<void> deleteTask(int index);
}