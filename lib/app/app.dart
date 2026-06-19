import 'package:flutter/material.dart';
import 'package:habit_arena/app/navigation/main_navigation_screen.dart';
import 'theme/app_theme.dart';

class HabitArenaApp extends StatelessWidget {
  const HabitArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitArena',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainNavigationScreen(),
    );
  }
}