class Habit {
  final String id;
  final String title;
  final String emoji;
  final bool completedToday;
  final List<String> completionHistory;

  const Habit({
    required this.id,
    required this.title,
    required this.emoji,
    required this.completedToday,
    required this.completionHistory,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? emoji,
    bool? completedToday,
    List<String>? completionHistory,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      completedToday: completedToday ?? this.completedToday,
      completionHistory: completionHistory ?? this.completionHistory
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'emoji': emoji,
      'completedToday': completedToday,
      'completionHistory': completionHistory,
    };
  }

  factory Habit.fromMap(Map map) {
    return Habit(
      id: map['id'],
      title: map['title'],
      emoji: map['emoji'],
      completedToday: map['completedToday'],
      completionHistory: List<String>.from(map['completionHistory'] ?? []),
    );
  }
}