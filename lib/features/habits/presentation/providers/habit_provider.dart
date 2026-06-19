import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/habit_repository.dart';
import '../../domain/habit.dart';
import 'package:uuid/uuid.dart';

class HabitNotifier extends Notifier<List<Habit>> {

  final _uuid = const Uuid();
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
        completionHistory: [],
      ),
      const Habit(
        id: '2',
        title: 'Read',
        emoji: '📚',
        completedToday: false,
        completionHistory: [],
      ),
      const Habit(
        id: '3',
        title: 'Water',
        emoji: '💧',
        completedToday: true,
        completionHistory: [],
      ),
    ];
  }

  String _today() {
    final now = DateTime.now();

    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  void toggleHabit(String habitId) {
    final today = _today();

    final updatedHabits = state.map((habit) {
      if (habit.id != habitId) {
        return habit;
      }

      final newCompletedState = !habit.completedToday;

      final history = List<String>.from(
        habit.completionHistory,
      );

      if (newCompletedState) {
        if (!history.contains(today)) {
          history.add(today);
        }
      } else {
        history.remove(today);
      }

      return habit.copyWith(
        completedToday: newCompletedState,
        completionHistory: history,
      );
    }).toList();

    state = updatedHabits;
    _repository.saveHabits(updatedHabits);
  }

  void printHistory(String habitId) {
    final habit = state.firstWhere(
          (habit) => habit.id == habitId,
    );

    print(habit.completionHistory);
  }

  void addHabit({
    required String title,
    required String emoji,
  }) {
    final newHabit = Habit(
      id: _uuid.v4(),
      title: title,
      emoji: emoji,
      completedToday: false,
      completionHistory: const [],
    );

    final updatedHabits = [
      ...state,
      newHabit,
    ];

    state = updatedHabits;
    _repository.saveHabits(updatedHabits);
  }

  void deleteHabit(String habitId) {
    final updatedHabits = state
        .where((habit) => habit.id != habitId)
        .toList();

    state = updatedHabits;
    _repository.saveHabits(updatedHabits);
  }
}

final habitsProvider =
NotifierProvider<HabitNotifier, List<Habit>>(
  HabitNotifier.new,
);