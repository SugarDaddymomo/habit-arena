import 'package:flutter/material.dart';
import '../../domain/habit.dart';
import '../../../../app/theme/app_colors.dart';

class HabitCircle extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;

  const HabitCircle({
    super.key,
    required this.habit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
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
              '${habit.streak}🔥',
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