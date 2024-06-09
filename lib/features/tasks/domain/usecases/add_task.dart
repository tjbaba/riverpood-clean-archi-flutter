import '../entitites/task.dart';
import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(TaskM task){
    return repository.addTask(task);
  }
}