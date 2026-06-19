import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../habits/presentation/providers/habit_provider.dart';
import '../../../tasks/presentation/providers/task_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final habits = ref.watch(habitsProvider);
    final tasks = ref.watch(tasksProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              const SizedBox(height: 16),

              Column(
                children: [

                  CircleAvatar(
                    radius: 45,
                    backgroundColor:
                    Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Habit Warrior',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${habits.length} Habits • ${tasks.length} Tasks',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🏆 Arena Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _profileRow('Arena Coins', '0'),
                      const Divider(),
                      _profileRow('Current Streak', '--'),
                      const Divider(),
                      _profileRow('Active Squads', '0'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        '📊 Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _profileRow(
                        'Habits Created',
                        habits.length.toString(),
                      ),

                      const Divider(),

                      _profileRow(
                        'Tasks Created',
                        tasks.length.toString(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {},
                      ),
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.dark_mode),
                        title: const Text('Theme'),
                        subtitle: const Text('Coming Soon'),
                        onTap: () {},
                      ),
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.cloud_sync),
                        title: const Text('Cloud Sync'),
                        subtitle: const Text('Coming Soon'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'HabitArena v0.1',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileRow(
      String title,
      String value,
      ) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}