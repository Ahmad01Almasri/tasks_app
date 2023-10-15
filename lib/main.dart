import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_app/data/models/task_model.dart';
import 'package:task_app/ui/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<TaskModel>(TaskAdapter());
  await Hive.openBox<TaskModel>('tasksBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      builder: botToastBuilder,
      home: const HomeScreen(),
    );
  }
}
