import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/task_provider.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/task_card.dart';

class MyTasksScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.read(TaskListNotifierProvider.notifier).loadTasks();
    final TaskList = ref.watch(taskListNotifierProvider);

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          // CustomSearchBar(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: TaskList.length,
            itemBuilder: (context, index) {
              final task = TaskList[index];
              return TaskCard(
                title: task.title,
                description: task.description,
                date: DateFormat.yMMMEd().format(task.date).toString(),

                onDelete: (){
                  ref.read(taskListNotifierProvider.notifier).removeTask(index);
                  ref.read(taskListNotifierProvider.notifier).loadTasks();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}