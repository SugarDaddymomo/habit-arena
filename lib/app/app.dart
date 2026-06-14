import 'package:flutter/material.dart';

import '../features/habits/presentation/screens/focus_screen.dart';

class HabitArenaApp extends StatelessWidget {
  const HabitArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitArena',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const FocusScreen(),
    );
  }
}