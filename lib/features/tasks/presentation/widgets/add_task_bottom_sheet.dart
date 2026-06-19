import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';

class AddTaskBottomSheet extends ConsumerStatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  ConsumerState<AddTaskBottomSheet> createState() =>
      _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState
    extends ConsumerState<AddTaskBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  String selectedPeriod = 'Morning';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
              'Create Task',
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
                labelText: 'Task Name',
                hintText: 'e.g., Finish API, Read Chapter 5',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            DropdownButtonFormField<String>(
              value: selectedPeriod,
              decoration: InputDecoration(
                labelText: 'Time Period',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Morning',
                  child: Text('Morning'),
                ),
                DropdownMenuItem(
                  value: 'Afternoon',
                  child: Text('Afternoon'),
                ),
                DropdownMenuItem(
                  value: 'Evening',
                  child: Text('Evening'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPeriod = value!;
                });
              },
            ),

            const SizedBox(height: 28),

            Text(
              _titleController.text.isEmpty
                  ? 'Task Name'
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
                  ref.read(tasksProvider.notifier).addTask(
                    title: title,
                    timePeriod: selectedPeriod,
                  );
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Create Task',
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