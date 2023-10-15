import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:task_app/data/models/task_model.dart';
import 'package:task_app/data/sources/local_task_data_source.dart';
import 'package:task_app/ui/widgets/date_time_container.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  DateTime time = DateTime.now();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 40),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 56,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Add New ',
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Task',
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      TextField(
                        maxLines: 3,
                        minLines: 2,
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'What are you planning?'),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: subTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Add Note',
                          prefixIcon: Icon(Icons.bookmark_border_rounded),
                        ),
                      ),
                      const SizedBox(height: 50),
                      DateTimeContainer(dateOrTime: DateOrTime.time, onTap: (t) => time = t),
                      const SizedBox(height: 20),
                      DateTimeContainer(dateOrTime: DateOrTime.date, onTap: (d) => date = d),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          onPressed: () {
            if (titleController.text.isNotEmpty && subTitleController.text.isNotEmpty) {
              var task = TaskModel.create(
                title: titleController.text,
                subtitle: subTitleController.text,
                time: time,
                date: date,
              );
              LocalTaskDataSource.addTask(task: task);
              Navigator.of(context).pop();
            } else {
              BotToast.showText(text: 'make sure to add all info');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Text('Add Task', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
