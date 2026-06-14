import 'package:hive/hive.dart';
import '../domain/task.dart';

class TaskRepository {
  static const boxName = 'tasks';

  Box get _box => Hive.box(boxName);

  Future<void> saveTasks(List<Task> tasks) async {
    final data = tasks
        .map((task) => task.toMap())
        .toList();

    await _box.put('task_list', data);
  }

  List<Task> loadTasks() {
    final data = _box.get('task_list');

    if (data == null) {
      return [];
    }

    return (data as List)
        .map((item) => Task.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }
}