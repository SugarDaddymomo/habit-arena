import 'package:flutter/material.dart';

import '../../domain/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: CheckboxListTile(
        title: Text(task.title),
        value: task.completed,
        onChanged: (_) => onToggle(),
      ),
    );
  }
}