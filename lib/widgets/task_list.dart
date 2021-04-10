import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList(this.tasks);

  List<Widget> _showSubtasks(List<Subtask> subtasks) {
    List<Widget> ret;
    subtasks.forEach((subtask) {
      final subtaskLine = CheckboxListTile(
        value: subtask.isCompleted,
        title: Text(subtask.name),
        onChanged: null,
      );
      //todo: agregar capacidad de tildar subtasks
      ret.add(subtaskLine);
    });
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tasks.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(children: <Widget>[
                Text('Sin tareas!',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ]);
            })
          : ListView.builder(itemBuilder: (ctx, ind) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: Column(
                  children: [
                    Text(
                      tasks[ind].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                    Row(
                      children: [
                        Text(
                            '\u{1F4C5} ${DateFormat.yMd().format(tasks[ind].dateDue)}'),
                        tasks[ind].priority == 1 ? Text("Urgente") : null,
                        tasks[ind].priority == 2 ? Text("Normal") : null,
                        tasks[ind].priority == 3 ? Text("No urgente") : null,
                        //todo estilizar con colores
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    tasks[ind].details != null
                        ? Text(tasks[ind].details,
                            style: TextStyle(color: Colors.black12))
                        : null,
                    ..._showSubtasks(tasks[ind].subtasks)
                  ],
                ),
              );
            }),
    );
  }
}
