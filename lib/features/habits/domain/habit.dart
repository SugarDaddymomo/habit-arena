class Habit {
  final String id;
  final String title;
  final String emoji;
  final bool completedToday;
  final int streak;

  const Habit({
    required this.id,
    required this.title,
    required this.emoji,
    required this.completedToday,
    required this.streak,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? emoji,
    bool? completedToday,
    int? streak,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      completedToday: completedToday ?? this.completedToday,
      streak: streak ?? this.streak,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'emoji': emoji,
      'completedToday': completedToday,
      'streak': streak,
    };
  }

  factory Habit.fromMap(Map map) {
    return Habit(
      id: map['id'],
      title: map['title'],
      emoji: map['emoji'],
      completedToday: map['completedToday'],
      streak: map['streak'],
    );
  }
}