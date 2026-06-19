import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/task_repository.dart';
import '../../domain/task.dart';

class TaskNotifier extends Notifier<List<Task>> {

  final TaskRepository _repository = TaskRepository();

  @override
  List<Task> build() {
    final savedTasks = _repository.loadTasks();
    if (savedTasks.isNotEmpty) {
      return savedTasks;
    }
    return [
      const Task(
        id: '1',
        title: 'Finish Flutter Setup',
        completed: true,
        timePeriod: 'Morning',
      ),
      const Task(
        id: '2',
        title: 'Create Habit Screen',
        completed: false,
        timePeriod: 'Afternoon',
      ),
      const Task(
        id: '3',
        title: 'Push To GitHub',
        completed: false,
        timePeriod: 'Evening',
      ),
    ];
  }

  void toggleTask(String taskId) {
    final updatedTasks = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(
          completed: !task.completed,
        );
      }
      return task;
    }).toList();
    state = updatedTasks;
    _repository.saveTasks(updatedTasks);
  }

  Future<void> addTask({
    required String title,
    required String timePeriod,
  }) async {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      completed: false,
      timePeriod: timePeriod,
    );
    state = [...state, task];
    await _repository.saveTasks(state);
  }

  void deleteTask(String taskId) {
    final updatedTasks = state
        .where((task) => task.id != taskId)
        .toList();

    state = updatedTasks;
    _repository.saveTasks(updatedTasks);
  }
}

final tasksProvider =
NotifierProvider<TaskNotifier, List<Task>>(
  TaskNotifier.new,
);