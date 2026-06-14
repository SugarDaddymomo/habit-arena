class Task {
  final String id;
  final String title;
  final bool completed;

  const Task({
    required this.id,
    required this.title,
    required this.completed,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}