import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:todoey/models/task_data.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // ListView.builder is used when you have a list with a lot of children
    // that are created dynamically
    return ListView.builder(itemBuilder: (context, index) {
      final task = Provider.of<TaskData>(context, listen: false).getTasksList[index];
      return TaskTile(
        task.name,
        task.isDone,
        (bool checkboxState) {
          Provider.of<TaskData>(context, listen: false).updateTask(task);
        },
          () {
            Provider.of<TaskData>(context, listen: false).deleteTask(task);
          },
      );
    },
    itemCount: Provider.of<TaskData>(context, listen: false).taskCount,
    );
  }
}
