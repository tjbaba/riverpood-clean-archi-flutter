import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entitites/task.dart';
import '../repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<Either<Failure, List<TaskM>>> call() {
    return repository.getTasks();
  }
}