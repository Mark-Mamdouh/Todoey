import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {

  String taskTitle;
  bool isChecked;
  Function checkboxCallback;
  Function longPressCallback;

  TaskTile(String taskTitle, bool isChecked, Function checkboxCallback, Function longPressCallback) {
    this.taskTitle = taskTitle;
    this.isChecked = isChecked;
    this.checkboxCallback = checkboxCallback;
    this.longPressCallback = longPressCallback;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
