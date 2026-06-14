import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/task.dart';

class TaskNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() {
    return [
      const Task(
        id: '1',
        title: 'Finish Flutter Setup',
        completed: true,
      ),
      const Task(
        id: '2',
        title: 'Create Habit Screen',
        completed: false,
      ),
      const Task(
        id: '3',
        title: 'Push To GitHub',
        completed: false,
      ),
    ];
  }

  void toggleTask(String taskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(
          completed: !task.completed,
        );
      }

      return task;
    }).toList();
  }
}

final tasksProvider =
NotifierProvider<TaskNotifier, List<Task>>(
  TaskNotifier.new,
);