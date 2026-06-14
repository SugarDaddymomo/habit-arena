import 'package:flutter/material.dart';
import '../../domain/habit.dart';

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
            CircleAvatar(
              radius: 30,
              backgroundColor:
              habit.completedToday
                  ? Colors.green.shade200
                  : Colors.grey.shade300,
              child: Text(
                habit.emoji,
                style: const TextStyle(
                  fontSize: 24,
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