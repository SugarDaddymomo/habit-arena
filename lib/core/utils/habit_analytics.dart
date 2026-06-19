import 'package:habit_arena/features/habits/domain/habit.dart';

class HabitAnalytics {

  static int totalCompletions(Habit habit) {
    return habit.completionHistory.length;
  }

  static bool completedToday(Habit habit) {
    final today = _today();
    return habit.completionHistory.contains(today);
  }

  static String _today() {
    final now = DateTime.now();
    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  static int currentStreak(Habit habit) {
    if (habit.completionHistory.isEmpty) {
      return 0;
    }
    final dates = habit.completionHistory
        .map(DateTime.parse)
        .toList()
      ..sort((a, b) => b.compareTo(a));
    int streak = 0;
    DateTime expectedDate = DateTime.now();
    while (true) {
      final found = dates.any(
            (date) =>
        date.year == expectedDate.year &&
            date.month == expectedDate.month &&
            date.day == expectedDate.day,
      );
      if (!found) {
        break;
      }
      streak++;
      expectedDate = expectedDate.subtract(
        const Duration(days: 1),
      );
    }
    return streak;
  }

  static int longestStreak(Habit habit) {
    if (habit.completionHistory.isEmpty) {
      return 0;
    }
    final dates = habit.completionHistory
        .map(DateTime.parse)
        .toList()
      ..sort();
    int longest = 1;
    int current = 1;
    for (int i = 1; i < dates.length; i++) {
      final previous = DateTime(
        dates[i - 1].year,
        dates[i - 1].month,
        dates[i - 1].day,
      );
      final currentDate = DateTime(
        dates[i].year,
        dates[i].month,
        dates[i].day,
      );
      final difference = currentDate.difference(previous).inDays;
      if (difference == 1) {
        current++;
        if (current > longest) {
          longest = current;
        }
      } else if (difference > 1) {
        current = 1;
      }
    }
    return longest;
  }

  static double weeklyCompletionRate(Habit habit) {
    final completed = completedLast7Days(habit);
    return (completed / 7) * 100;
  }

  static int completedLast7Days(Habit habit) {
    final cutoff = DateTime.now().subtract(
      const Duration(days: 6),
    );
    return habit.completionHistory
        .map(DateTime.parse)
        .where(
          (date) => !date.isBefore(
        DateTime(
          cutoff.year,
          cutoff.month,
          cutoff.day,
        ),
      ),
    ).length;
  }

  static List<bool> last30Days(Habit habit) {
    final history = habit.completionHistory.toSet();
    return List.generate(35, (index) {
      final date = DateTime.now().subtract(
        Duration(days: 34 - index),
      );
      final key =
          '${date.year}-'
          '${date.month.toString().padLeft(2, '0')}-'
          '${date.day.toString().padLeft(2, '0')}';

      return history.contains(key);
    });
  }

  static List<int> contributionGrid(List<Habit> habits,) {
    return List.generate(35, (index) {
      final date = DateTime.now().subtract(
        Duration(days: 34 - index),
      );
      final key =
          '${date.year}-'
          '${date.month.toString().padLeft(2, '0')}-'
          '${date.day.toString().padLeft(2, '0')}';
      int count = 0;
      for (final habit in habits) {
        if (habit.completionHistory.contains(key)) {
          count++;
        }
      }
      return count;
    });
  }

  // bestWeek() {
  //
  // }
}