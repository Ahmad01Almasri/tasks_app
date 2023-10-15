import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateOrTime { date, time }

class DateTimeContainer extends StatefulWidget {
  const DateTimeContainer({
    super.key,
    this.dateOrTime = DateOrTime.time,
    required this.onTap,
  });

  final DateOrTime dateOrTime;
  final Function(DateTime) onTap;

  @override
  State<DateTimeContainer> createState() => _DateTimeContainerState();
}

class _DateTimeContainerState extends State<DateTimeContainer> {
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();

        if (widget.dateOrTime == DateOrTime.time) {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((value) {
            if (value != null) {
              setState(() {
                time = DateTime.now().copyWith(
                  hour: value.hour,
                  minute: value.minute,
                );
                widget.onTap(time);
              });
            }
          });
        } else {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2050, 12, 31),
          ).then(
            (value) => setState(() {
              time = value ?? time;
              widget.onTap(time);
            }),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.dateOrTime.name.toUpperCase()),
            // we can use Spacer() here instead of [MainAxisAlignment.spaceBetween]
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade100),
              child: Text(
                widget.dateOrTime == DateOrTime.time
                    ? DateFormat('hh:mm a').format(time)
                    : DateFormat.yMMMEd().format(time),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
