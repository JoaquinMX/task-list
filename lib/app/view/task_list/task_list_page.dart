import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/app/model/task.dart';
import 'package:task_list/app/view/components/shape.dart';
import 'package:task_list/app/view/components/title.dart';
import 'package:task_list/app/view/home/inherited_widgets.dart';
import 'package:task_list/app/view/task_list/task_provider.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..fetchTasks(),
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
                onPressed: () => _showNewTaskModal(context),
                child: const Icon(
                  Icons.add,
                  size: 50,
                )
            );
          }
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            Expanded(
                child: _taskList()
            ),
          ],
        ),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
          value: context.read<TaskProvider>(),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: _NewTaskModal(),
          )
        )
    );
  }

}

class _NewTaskModal extends StatelessWidget {
  _NewTaskModal({Key? key}) : super(key: key);
  final _controllerTask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
          color: Colors.white
      ),
      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const H1("Nueva Tarea"),
          const SizedBox(height: 26),
          TextField(
            controller: _controllerTask,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: "Título de la tarea"
            ),
          ),
          const SizedBox(height: 26),
          ElevatedButton(
              onPressed: () {
                if (_controllerTask.text.isNotEmpty) {
                  final task = Task(_controllerTask.text);
                  context.read<TaskProvider>().addNewTask(task);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Guardar")
          )
        ],
      ),
    );
  }
}

class _taskList extends StatelessWidget {
  const _taskList({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1("Tareas"),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (_, taskProvider, __) {
                if (taskProvider.taskList.isEmpty) {
                  return const Center(
                    child: Text("No hay tareas"),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (_, index) => _TaskItem(
                          taskProvider.taskList[index],
                          onTap: () => taskProvider.onTaskDoneChange(taskProvider.taskList[index])
                      ),
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: taskProvider.taskList.length
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Row(children: [
            Shape()
          ]),
          Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                "assets/images/tasks-list-image.png",
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 16),
              const H1("Completa tus tareas", color: Colors.white),
              const SizedBox(height: 24)
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task, {Key? key, this.onTap}) : super(key: key);

  final Task task;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
            child: Row(
              children: [
                Icon(
                  task.done
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    task.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}