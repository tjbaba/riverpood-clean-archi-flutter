import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/datasources/task_local_datasource.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/trip_repository_impl.dart';
import '../../domain/entitites/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';

final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  final Box<TaskModel> TaskBox = Hive.box('Tasks');
  return TaskLocalDataSource(TaskBox);
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final localDataSource = ref.read(taskLocalDataSourceProvider);
  return TaskRepositoryImpl(localDataSource);
});

final getTasksProvider = Provider<GetTasks>((ref) {
  final repository = ref.read(taskRepositoryProvider);
  return GetTasks(repository);
});

final addTaskProvider = Provider<AddTask>((ref) {
  final repository = ref.read(taskRepositoryProvider);
  return AddTask(repository);
});

final deleteTaskProvider = Provider<DeleteTask>((ref) {
  final repository = ref.read(taskRepositoryProvider);
  return DeleteTask(repository);
});

// This provider will manage fetching Tasks from the repository.
final taskListNotifierProvider = StateNotifierProvider<TaskListNotifier, List<TaskM>>((ref) {
  final getTasks = ref.read(getTasksProvider);
  final addTask = ref.read(addTaskProvider);
  final deleteTask = ref.read(deleteTaskProvider);

  return TaskListNotifier(getTasks, addTask, deleteTask);
});

class TaskListNotifier extends StateNotifier<List<TaskM>> {
  final GetTasks _getTasks;
  final AddTask _addTask;
  final DeleteTask _deleteTask;

  TaskListNotifier(this._getTasks, this._addTask, this._deleteTask) : super([]);

  // Load Tasks from the repository and update the state.
  Future<void> loadTasks() async {
    final TasksOrFailure = await _getTasks();
    TasksOrFailure.fold((error) => state = [], (tasks) => state = tasks);
  }

  Future<void> addNewTask(TaskM task) async {
    await _addTask(task);
    //state = [...state, Task];
  }

  Future<void> removeTask(int taskId) async {
    await _deleteTask(taskId);
  }
}