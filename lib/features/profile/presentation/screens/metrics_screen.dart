import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/habit_analytics.dart';
import '../../../habits/presentation/providers/habit_provider.dart';
import '../../../tasks/presentation/providers/task_provider.dart';
import '../../../leaderboard/presentation/widgets/contribution_grid.dart';

class MetricsScreen extends ConsumerWidget {
  const MetricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final habits = ref.watch(habitsProvider);
    final tasks = ref.watch(tasksProvider);
    final totalCompletions = habits.fold(0, (sum, habit) => sum + HabitAnalytics.totalCompletions(habit),);
    final currentStreak = habits.isEmpty ? 0 : habits.map(HabitAnalytics.currentStreak).reduce((a, b) => a > b ? a : b);
    final longestStreak = habits.isEmpty ? 0 : habits.map(HabitAnalytics.longestStreak).reduce((a, b) => a > b ? a : b);
    final weeklySuccessRate = habits.isEmpty ? 0 : (habits.map(HabitAnalytics.weeklyCompletionRate,).reduce((a, b) => a + b) / habits.length);
    final completedHabits = habits.where((h) => h.completedToday).length;;
    final completedTasks = tasks.where((t) => t.completed).length;
    final totalHabits = habits.length;
    final totalTasks = tasks.length;
    final totalItems = totalHabits + totalTasks;
    final completedItems = completedHabits + completedTasks;
    final completionPercentage = totalItems == 0 ? 0 : ((completedItems / totalItems) * 100).round();
    final contributionDays = HabitAnalytics.contributionGrid(habits,);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                '📊 Metrics',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              _buildCompletionCard(
                completionPercentage,
              ),

              const SizedBox(height: 16),

              Row(
                children: [

                  Expanded(
                    child: _buildStatCard(
                      title: 'Habits',
                      value: totalHabits.toString(),
                      icon: Icons.repeat,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildStatCard(
                      title: 'Tasks',
                      value: totalTasks.toString(),
                      icon: Icons.task_alt,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Today\'s Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Habits Completed'),
                          Text(
                            '$completedHabits / $totalHabits',
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tasks Completed'),
                          Text(
                            '$completedTasks / $totalTasks',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        '🏆 Arena Stats',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Arena Coins'),
                          Text('0'),
                        ],
                      ),

                      SizedBox(height: 12),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Current Streak'),
                          Text('$currentStreak 🔥'),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Longest Streak'),
                          Text('$longestStreak 🏆'),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Completions'),
                          Text('$totalCompletions'),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Weekly Success'),
                          Text(
                            '${weeklySuccessRate.toStringAsFixed(0)}%',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        '📅 Consistency Grid',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ContributionGrid(
                        days: contributionDays,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionCard(int percent) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Today\'s Completion',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            LinearProgressIndicator(
              value: percent / 100,
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
        ),
        child: Column(
          children: [

            Icon(
              icon,
              size: 28,
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(title),
          ],
        ),
      ),
    );
  }
}