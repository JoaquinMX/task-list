import 'package:flutter/material.dart';
import 'package:task_list/app/model/task.dart';
import 'package:task_list/app/repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];

  final _TaskRepository = TaskRepository();

  List<Task> get taskList => _taskList;

  void fetchTasks() async{
    _taskList = await _TaskRepository.getTasks();
    notifyListeners();
  }

  onTaskDoneChange(Task task) {
    task.done = !task.done;
    _TaskRepository.saveTasks(_taskList);
    notifyListeners();
  }

  void addNewTask(Task task) {
    _TaskRepository.addTask(task);
    fetchTasks();
  }
}