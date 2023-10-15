import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_app/data/models/task_model.dart';

class LocalTaskDataSource {
  LocalTaskDataSource._();

  static const _boxName = "tasksBox";

  static final Box<TaskModel> _box = Hive.box<TaskModel>(_boxName);

  static ValueListenable<Box<TaskModel>> listenToTask() => _box.listenable();

  static Future<void> addTask({required TaskModel task}) async => await _box.put(task.id, task);

  static Future<void> updateTask({required TaskModel task}) async => await task.save();

  static Future<void> delateTask({required TaskModel task}) async => await task.delete();

  static void clear() => _box.clear();
}
