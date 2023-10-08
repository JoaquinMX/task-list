import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_list/app/model/task.dart';
import 'package:task_list/app/repository/task_repository.dart';
import 'package:task_list/app/view/components/shape.dart';
import 'package:task_list/app/view/components/title.dart';
import 'package:task_list/app/view/home/inherited_widgets.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  int count = 0;

  final List<Task> taskList = <Task>[];
  final TaskRepository taskRepository = TaskRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showNewTaskModal(context),
          child: Icon(
              Icons.add,
              size: 50,
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(),
          Expanded(
              child: FutureBuilder<List<Task>>(
                future: taskRepository.getTasks(),
                builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                  if (snapshot == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No hay tareas",
                      )
                    );
                  }
                  return _taskList(
                    snapshot.data!,
                    onTaskDoneChange: (task) {
                      task.done = !task.done;
                      taskRepository.saveTasks(snapshot.data!);
                      setState(() {});
                    },
                  );
                }
              )
          ),
        ],
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: _NewTaskModal(
            onTaskCreated: (Task task) {
              taskRepository.addTask(task);
              setState((){});
            },
          ),
        )
    );
  }
  
}

class _NewTaskModal extends StatefulWidget {
  _NewTaskModal({Key? key, required this.onTaskCreated}) : super(key: key);

  final void Function(Task task) onTaskCreated;

  @override
  State<_NewTaskModal> createState() => _NewTaskModalState();
}

class _NewTaskModalState extends State<_NewTaskModal> {
  final _controllerTask = TextEditingController();
  final _controllerSubtitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        color: Colors.white
      ),
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          H1("Nueva Tarea"),
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
          TextField(
            controller: _controllerSubtitle,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: "Subtítulo de la tarea (opcional)"
            ),
          ),
          const SizedBox(height: 26),
          TextField(
            controller: _controllerDescription,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: "Descripción de la tarea (opcional)"
            ),
          ),
          const SizedBox(height: 26),
          ElevatedButton(
              onPressed: () {
                if (_controllerTask.text.isNotEmpty) {
                  final task = Task(_controllerTask.text, subtitle: _controllerSubtitle.text, description: _controllerDescription.text);
                  widget.onTaskCreated(task);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Guardar")
          )
        ],
      ),
    );
  }
}

class _taskList extends StatelessWidget {
  const _taskList(this.taskList, {
    super.key,
    required this.onTaskDoneChange
  });

  final List<Task> taskList;
  final void Function(Task task) onTaskDoneChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1("Tareas"),
          Expanded(
            child: ListView.separated(
                itemBuilder: (_, index) => _TaskItem(
                  taskList[index],
                  onTap: () => onTaskDoneChange(taskList[index])
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: taskList.length
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
              SizedBox(height: 24)
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      task.subtitle != null ? Text(
                        style: TextStyle(
                            color: SpecialColor.of(context).color
                        ),
                        task.subtitle!,
                      ) : const SizedBox(),
                      task.description != null ? Text(
                        style: TextStyle(
                          color: SpecialColor.of(context).color
                        ),
                        maxLines: 2,
                        task.description!,
                      ) : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}