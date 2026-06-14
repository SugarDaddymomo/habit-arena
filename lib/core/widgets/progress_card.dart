import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class ProgressCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final int completionPercentage;

  const ProgressCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.completionPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Progress",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              '$completedTasks / $totalTasks Tasks Completed',
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(20),
              minHeight: 10,
              value: totalTasks == 0
                  ? 0
                  : completedTasks / totalTasks,
            ),

            const SizedBox(height: 8),

            Text(
              '$completionPercentage%',
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