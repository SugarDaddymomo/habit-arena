import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/habit_repository.dart';
import '../../domain/habit.dart';

class HabitNotifier extends Notifier<List<Habit>> {

  final HabitRepository _repository = HabitRepository();

  @override
  List<Habit> build() {
    final savedHabits = _repository.loadHabits();
    if (savedHabits.isNotEmpty) {
      return savedHabits;
    }
    return [
      const Habit(
        id: '1',
        title: 'Workout',
        emoji: '🏋️',
        completedToday: true,
        streak: 12,
      ),
      const Habit(
        id: '2',
        title: 'Read',
        emoji: '📚',
        completedToday: false,
        streak: 5,
      ),
      const Habit(
        id: '3',
        title: 'Water',
        emoji: '💧',
        completedToday: true,
        streak: 21,
      ),
    ];
  }

  void toggleHabit(String habitId) {
    final updatedHabits = state.map((habit) {
      if (habit.id == habitId) {
        return habit.copyWith(
          completedToday: !habit.completedToday,
        );
      }
      return habit;
    }).toList();
    state = updatedHabits;
    _repository.saveHabits(updatedHabits);
  }
}

final habitsProvider =
NotifierProvider<HabitNotifier, List<Habit>>(
  HabitNotifier.new,
);