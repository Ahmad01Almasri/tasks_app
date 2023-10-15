import 'package:flutter/cupertino.dart' show CupertinoIcons, CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:task_app/data/models/task_model.dart';
import 'package:task_app/data/sources/local_task_data_source.dart';
import 'package:task_app/ui/screens/add_task_screen.dart';
import 'package:task_app/ui/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Checking Done Tasks
  int checkDoneTask(List<TaskModel> task) {
    int numberOfDoneTasks = 0;
    for (TaskModel doneTasks in task) {
      if (doneTasks.isCompleted) numberOfDoneTasks++;
    }
    return numberOfDoneTasks;
  }

  /// Checking The Value Of the Circle Indicator
  int valueOfTheIndicator(List<TaskModel> task) => task.isNotEmpty ? task.length : 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.trash, size: 40),
            onPressed: () => PanaraConfirmDialog.show(
              context,
              title: 'Are You Sure?!',
              message: "Do You really want to delete all tasks? You will no be able to undo this action!",
              confirmButtonText: "Yes",
              cancelButtonText: "No",
              onTapCancel: () {
                Navigator.pop(context);
              },
              onTapConfirm: () {
                LocalTaskDataSource.clear();
                Navigator.pop(context);
              },
              panaraDialogType: PanaraDialogType.error,
              barrierDismissible: false,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<Box<TaskModel>>(
          valueListenable: LocalTaskDataSource.listenToTask(),
          builder: (__, box, _) {
            final List<TaskModel> tasks = box.values.toList();
            tasks.sort(((a, b) => a.date.compareTo(b.date)));

            return Column(
              children: [
                const SizedBox(height: 24),
                ListTile(
                  leading: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation(null),
                    backgroundColor: Colors.grey,
                    value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                  ),
                  title: const Text(
                    'My Tasks',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${checkDoneTask(tasks)} of ${tasks.length} task',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 2, indent: 70),
                if (tasks.isEmpty)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Lottie.asset('assets/1.json', height: 250)),
                        const Text('You have done all tasks')
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        final TaskModel task = tasks[index];
                        return Dismissible(
                          key: Key(task.id),
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) => LocalTaskDataSource.delateTask(task: task),
                          background: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_outline, color: Colors.grey),
                              SizedBox(width: 8),
                              Text('Delete Task', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          child: TaskCard(task: tasks[index]),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const AddTaskScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
