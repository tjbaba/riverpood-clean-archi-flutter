import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entitites/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: "Task Title");
  final _descController =
      TextEditingController(text: "Need to complete this task");

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newTask = TaskM(
                    title: _titleController.text,
                    description: _descController.text,
                    date: DateTime.now(),
                  );
                  ref
                      .read(taskListNotifierProvider.notifier)
                      .addNewTask(newTask);
                  ref.read(taskListNotifierProvider.notifier).loadTasks();

                  _titleController.text = '';
                  _descController.text = '';

                  const snackBar = SnackBar(
                    content: Text('Task Added Successfully'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
