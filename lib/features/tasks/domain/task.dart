class Task {
  final String id;
  final String title;
  final bool completed;
  final String timePeriod;

  const Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.timePeriod,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? completed,
    String? timePeriod,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      timePeriod: timePeriod ?? this.timePeriod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'timePeriod': timePeriod,
    };
  }

  factory Task.fromMap(Map map) {
    return Task(
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
      timePeriod: map['timePeriod'] ?? 'Morning',
    );
  }
}