import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/habit_provider.dart';

class AddHabitBottomSheet extends ConsumerStatefulWidget {
  const AddHabitBottomSheet({super.key});

  @override
  ConsumerState<AddHabitBottomSheet> createState() =>
      _AddHabitBottomSheetState();
}

class _AddHabitBottomSheetState
    extends ConsumerState<AddHabitBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  String selectedEmoji = '🏃';
  final emojis = [
    '🏃',
    '🏋️',
    '📚',
    '💧',
    '🧘',
    '💻',
    '🥗',
    '😴',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Create Habit',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _titleController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Habit Name',
                hintText: 'e.g., Kubernetes, Gym, Reading',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Icon',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface
                ),
              ),
            ),

            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
              children: emojis.map((emoji) {
                final isSelected = selectedEmoji == emoji;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEmoji = emoji;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: isSelected ? 2 : 1,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade700,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            const Text(
              'Preview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF22C55E),
              ),
              child: Center(
                child: Text(
                  selectedEmoji,
                  style: const TextStyle(fontSize: 42),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              _titleController.text.isEmpty
                  ? 'Habit Name'
                  : _titleController.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final title = _titleController.text.trim();

                  if (title.isEmpty) {
                    return;
                  }

                  ref.read(habitsProvider.notifier).addHabit(
                    title: title,
                    emoji: selectedEmoji,
                  );

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Create Habit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}