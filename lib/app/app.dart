import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../features/habits/presentation/screens/focus_screen.dart';

class HabitArenaApp extends StatelessWidget {
  const HabitArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitArena',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const FocusScreen(),
    );
  }
}