import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/data/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: widget.task.isCompleted ? Theme.of(context).primaryColor.withOpacity(.75) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), offset: const Offset(0, 4), blurRadius: 10)],
      ),
      child: ListTile(
        /// Check icon
        leading: GestureDetector(
          onTap: () {
            widget.task.isCompleted = !widget.task.isCompleted;
            widget.task.save();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              color: widget.task.isCompleted ? Theme.of(context).primaryColor : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: .8),
            ),
            child: const Icon(Icons.check, color: Colors.white),
          ),
        ),

        /// title of Task
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 3),
          child: Text(
            widget.task.title,
            style: TextStyle(
              color: widget.task.isCompleted ? Theme.of(context).primaryColor : Colors.black,
              fontWeight: FontWeight.w500,
              decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),

        /// Description of task
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.subtitle,
              style: TextStyle(
                color: widget.task.isCompleted ? Theme.of(context).primaryColor : Colors.grey.shade600,
                fontWeight: FontWeight.w300,
                decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),

            /// Date & Time of Task
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(widget.task.time),
                      style: TextStyle(fontSize: 14, color: widget.task.isCompleted ? Colors.white : Colors.grey),
                    ),
                    Text(
                      DateFormat.yMMMEd().format(widget.task.date),
                      style: TextStyle(fontSize: 12, color: widget.task.isCompleted ? Colors.white : Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
