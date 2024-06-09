import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entitites/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository{
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTask(TaskM task) async {
    final taskModel = TaskModel.fromEntity(task);
    localDataSource.addTask(taskModel);
  }

  @override
  Future<void> deleteTask(int index) async {
    localDataSource.deleteTask(index);
  }

  @override
  Future<Either<Failure, List<TaskM>>> getTasks() async {
    try {
      final taskModels = localDataSource.getTask();
      List<TaskM> res = taskModels.map((model) => model.toEntity()).toList();
      return Right(res);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

}