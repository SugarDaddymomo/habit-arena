import 'package:hive/hive.dart';
import '../domain/habit.dart';

class HabitRepository {
  static const boxName = 'habits';

  Box get _box => Hive.box(boxName);

  Future<void> saveHabits(List<Habit> habits) async {
    final data = habits
        .map((habit) => habit.toMap())
        .toList();

    await _box.put('habit_list', data);
  }

  List<Habit> loadHabits() {
    final data = _box.get('habit_list');

    if (data == null) {
      return [];
    }

    return (data as List)
        .map((item) => Habit.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }
}