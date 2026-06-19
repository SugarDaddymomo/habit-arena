import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/progress_card.dart';
import '../widgets/habit_circle.dart';
import '../../../tasks/presentation/widgets/task_tile.dart';
import '../providers/habit_provider.dart';
import '../../../tasks/presentation/providers/task_provider.dart';
import '../widgets/add_habit_bottom_sheet.dart';
import '../../../tasks/presentation/widgets/add_task_bottom_sheet.dart';
import '../../../tasks/domain/task.dart';

class FocusScreen extends ConsumerWidget {
  const FocusScreen({super.key});

  Widget buildTaskSection({
    required String title,
    required List<Task> tasks,
    required WidgetRef ref,
  }) {
    if (tasks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title (${tasks.length})',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        ...tasks.map(
              (task) => TaskTile(
              task: task,
              onToggle: () {
                ref
                    .read(tasksProvider.notifier)
                    .toggleTask(task.id);
              },
              onDelete: () {
                ref
                    .read(tasksProvider.notifier)
                    .deleteTask(task.id);
              },
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    final tasks = ref.watch(tasksProvider);

    final morningTasks = tasks.where((task) => task.timePeriod == 'Morning').toList();
    final afternoonTasks = tasks.where((task) => task.timePeriod == 'Afternoon').toList();
    final eveningTasks = tasks.where((task) => task.timePeriod == 'Evening').toList();
    final completedTasks = tasks.where((task) => task.completed).length;
    final totalTasks = tasks.length;
    final completionPercentage =
    totalTasks == 0
        ? 0
        : ((completedTasks / totalTasks) * 100).round();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final choice = await showModalBottomSheet<String>(
            context: context,
            builder: (context) {
              return SafeArea(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.repeat),
                      title: const Text('Add Habit'),
                      onTap: () {
                        Navigator.pop(context, 'habit');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.task_alt),
                      title: const Text('Add Task'),
                      onTap: () {
                        Navigator.pop(context, 'task');
                      },
                    ),
                  ],
                ),
              );
            },
          );

          if (choice == 'habit') {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: const AddHabitBottomSheet(),
                );
              },
            );
          }

          if (choice == 'task') {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: const AddTaskBottomSheet(),
                );
              },
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Your arena is waiting.',
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
                      onLongPress: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Habit'),
                              content: Text(
                                'Are you sure you want to delete "${habit.title}"?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Cancel'),
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldDelete == true) {
                          ref
                              .read(habitsProvider.notifier)
                              .deleteHabit(habit.id);
                        }
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      buildTaskSection(
                        title: '🌅 Morning',
                        tasks: morningTasks,
                        ref: ref,
                      ),

                      buildTaskSection(
                        title: '☀️ Afternoon',
                        tasks: afternoonTasks,
                        ref: ref,
                      ),

                      buildTaskSection(
                        title: '🌙 Evening',
                        tasks: eveningTasks,
                        ref: ref,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}