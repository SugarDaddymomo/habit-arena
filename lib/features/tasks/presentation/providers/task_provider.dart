import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/task.dart';

final tasksProvider = Provider<List<Task>>(
      (ref) => [
    Task(
      id: '1',
      title: 'Finish Flutter Setup',
      completed: true,
    ),
    Task(
      id: '2',
      title: 'Create Habit Screen',
      completed: false,
    ),
    Task(
      id: '3',
      title: 'Push to GitHub',
      completed: false,
    ),
  ],
);