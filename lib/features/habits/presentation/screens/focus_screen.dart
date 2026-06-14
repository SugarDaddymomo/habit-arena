import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/progress_card.dart';
import '../widgets/habit_circle.dart';
import '../../../tasks/presentation/widgets/task_tile.dart';
import '../providers/habit_provider.dart';
import '../../../tasks/presentation/providers/task_provider.dart';

class FocusScreen extends ConsumerWidget {
  const FocusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    final tasks = ref.watch(tasksProvider);

    final completedTasks =
        tasks.where((task) => task.completed).length;

    final totalTasks = tasks.length;

    final completionPercentage =
    totalTasks == 0
        ? 0
        : ((completedTasks / totalTasks) * 100).round();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Focus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Arena',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Metrics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Good Evening, Ashutosh',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Stay consistent today 🔥',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),

              // Progress Card
              ProgressCard(
                completedTasks: completedTasks,
                totalTasks: totalTasks,
                completionPercentage: completionPercentage,
              ),

              const SizedBox(height: 24),

              const Text(
                "Today's Habits",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Habits Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: habits.map((habit) {
                    return HabitCircle(
                      habit: habit,
                      onTap: () {
                        ref
                            .read(habitsProvider.notifier)
                            .toggleHabit(habit.id);
                      },
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return TaskTile(
                      task: task,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}