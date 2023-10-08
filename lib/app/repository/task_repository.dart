import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list/app/model/task.dart';

class TaskRepository {
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList("tasks") ?? [];
    jsonTasks.add(jsonEncode(task.toJson()));
    return prefs.setStringList(
        "tasks", jsonTasks
    );
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList("tasks") ?? [];
    return jsonTasks
        .map((singleJsonTask) => Task.fromJson(jsonDecode(singleJsonTask)))
        .toList();
  }

  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((task) => jsonEncode(task.toJson())).toList();
    return prefs.setStringList(
        "tasks", jsonTasks
    );
  }
}