import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {

  List<Task> _tasks = [];

  // constructor
  TaskData() {
    _getTaskList();
  }

  // get saved data from shared preferences
  Future<List<String>> _getListFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("tasks");
  }

  // convert to Lits<string> to be able to save it in shared preferences
  List<String> _convertToListString() {
    List<String> newList = [];
    for(int i = 0; i < _tasks.length; i++) {
      String temp = _tasks[i].name.toString() + "^" + _tasks[i].isDone.toString();
      newList.add(temp);
    }
    return newList;
  }

  void _getTaskList() async {
    List<String> taskStrings = await _getListFromSharedPreferences();
    for(int i = 0; i < taskStrings.length; i++) {
      List<String> temp = taskStrings[i].split("^");
      bool isDone;
      if(temp[1] == "false") {
        isDone = false;
      } else {
        isDone = true;
      }
      Task task = new Task(temp[0], isDone);
      _tasks.add(task);
      notifyListeners();
    }
  }

  // add a new task
  void addTask(String newTaskTitle) async {
    final task = Task(newTaskTitle, false);
    _tasks.add(task);
    notifyListeners();
    // save new task in shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("tasks", _convertToListString());
  }

  // change task status
  void updateTask(Task task) async {
    task.toggleDone();
    notifyListeners();
    // save new updated data in shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("tasks", _convertToListString());
  }

  // delete a task
  void deleteTask(Task task) async {
    _tasks.remove(task);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("tasks", _convertToListString());
  }

  // get means getter method
  int get taskCount {
    return _tasks.length;
  }

  List<Task> get getTasksList {
    return _tasks;
  }
}
