import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList(this.tasks);

  List<Widget> _showSubtasks(List<Subtask> subtasks) {
    if (subtasks == null || subtasks[0].name == "") return [_empty];
    print(subtasks[0].name);
    List<Widget> ret = [];
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

  Widget _showDate(DateTime dateDue) {
    return dateDue != null
        ? Text("\u{1F4C5} ${DateFormat.yMd().format(dateDue)}")
        : _empty;
  }

  Widget _showDetails(String details) {
    if (details != null) {
      return details.isNotEmpty
          ? Text(details, style: TextStyle(color: Colors.black12))
          : _empty;
    } else
      return _empty;
  }

  Widget _showStatus(String status) {
    if (status == null) return _empty;
    Color backColor;
    switch (status) {
      case "Pendiente":
        backColor = Color.fromRGBO(230, 179, 62, 127);
        break;
      case "Hoy":
        backColor = Color.fromRGBO(163, 11, 0, 127);
        break;
      case "Realizado":
        backColor = Color.fromRGBO(72, 181, 0, 127);
        break;
      default:
        return Text(status);
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Text(status),
      ),
    );
  }

  static Widget _empty = Container(width: 0, height: 0);

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
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (ctx, ind) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    tasks[ind].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      /*color: Theme.of(context).primaryColorDark*/
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: _showStatus(tasks[ind].status),
                                  ),
                                  //todo armar mejor la presentación de los estados
                                ],
                              ),
                              Row(
                                children: [
                                  _showDate(tasks[ind].dateDue),
                                  tasks[ind].priority == 1
                                      ? Text("Urgente")
                                      : _empty,
                                  tasks[ind].priority == 2
                                      ? Text("Normal")
                                      : _empty,
                                  tasks[ind].priority == 3
                                      ? Text("No urgente")
                                      : _empty,
                                  //todo estilizar con colores
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              _showDetails(tasks[ind].details),
                              ..._showSubtasks(tasks[ind]
                                  .subtasks) //TODO encontrar una forma de hacer bien el _empty
                            ],
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.list_sharp),
                            onPressed: () => {})
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
