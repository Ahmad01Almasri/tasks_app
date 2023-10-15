import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subtitle;
  @HiveField(3)
  DateTime time;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.date,
    required this.isCompleted,
  });

  factory TaskModel.create({
    required String? title,
    required String? subtitle,
    final DateTime? time,
    final DateTime? date,
  }) =>
      TaskModel(
        id: const Uuid().v1(),
        title: title ?? "",
        subtitle: subtitle ?? "",
        time: time ?? DateTime.now(),
        isCompleted: false,
        date: date ?? DateTime.now(),
      );
}
