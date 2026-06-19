import 'package:flutter/material.dart';
import '../../domain/habit.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/habit_analytics.dart';

class HabitCircle extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const HabitCircle({
    super.key,
    required this.habit,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: habit.completedToday
                    ? AppColors.success
                    : AppColors.surface,
                border: Border.all(
                  color: habit.completedToday
                      ? AppColors.success
                      : AppColors.border,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  habit.emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              habit.title,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),

            Text(
              '${HabitAnalytics.currentStreak(habit)}🔥',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}