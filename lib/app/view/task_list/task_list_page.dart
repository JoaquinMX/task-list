import 'package:flutter/material.dart';
import 'package:task_list/app/model/task.dart';
import 'package:task_list/app/view/components/shape.dart';
import 'package:task_list/app/view/components/title.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
              Icons.add,
              size: 50,
          )
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          Expanded(child: _taskList())
        ],
      ),
    );
  }
}

class _taskList extends StatefulWidget {
  const _taskList({
    super.key,
  });

  @override
  State<_taskList> createState() => _taskListState();
}

class _taskListState extends State<_taskList> {

  final taskList = <Task>[
    Task("Hacer la compra"),
    Task("Preparar la cena"),
    Task("Ir al partido de mi hijo"),
    Task("Mandar un mensaje a mi jefe"),
  ];

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
                    onTap: () {
                      taskList[index].done = !taskList[index].done;
                      setState(() {});
                  }),
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
                Text(task.title),
              ],
            ),
          )
      ),
    );
  }
}