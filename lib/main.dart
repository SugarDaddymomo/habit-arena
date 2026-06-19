import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Firebase initialized successfully');
  // Hive
  await Hive.initFlutter();
  await Hive.openBox('habits');
  await Hive.openBox('tasks');

  runApp(
    const ProviderScope(
      child: HabitArenaApp(),
    ),
  );
}