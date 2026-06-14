import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('habits');
  await Hive.openBox('tasks');

  runApp(
    const ProviderScope(
      child: HabitArenaApp(),
    ),
  );
}