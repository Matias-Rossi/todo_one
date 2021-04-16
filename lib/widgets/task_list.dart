import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;

  TaskList(this.tasks);

  static Widget _empty = Container(width: 0, height: 0);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Widget> _showSubtasks(List<Subtask> subtasks) {
    if (subtasks == null || subtasks[0].name == "") return [TaskList._empty];
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
        ? Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text("\u{1F4C5} ${DateFormat.yMd().format(dateDue)}"),
          )
        : TaskList._empty;
  }

  Widget _showDetails(String details) {
    if (details != null) {
      return details.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(details, style: TextStyle(color: Colors.black45)),
            )
          : TaskList._empty;
    } else
      return TaskList._empty;
  }

  Widget _showStatus(String status) {
    if (status == null) return TaskList._empty;
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
        return Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            status,
          ),
        );
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

  Widget _showPriority(int priority) {
    String priorityStr = "";
    switch (priority) {
      case 1:
        priorityStr = "Urgente";
        break;
      case 2:
        priorityStr = "Prioritario";
        break;
      case 3:
        priorityStr = "Sin urgencia";
        break;
      default:
        return TaskList._empty;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(priorityStr),
    );

    //todo estilizar con colores
  }

  IconSlideAction _nextStatus(String status, int ind) {
    switch (status) {
      case "Pendiente":
        return IconSlideAction(
          caption: 'Hoy',
          icon: Icons.calendar_today_sharp,
          color: Colors.amber,
          onTap: () {
            setState(() {
              widget.tasks[ind].status = "Hoy";
            });
          },
        );
      case "Hoy":
        return IconSlideAction(
          caption: 'Realizado',
          icon: Icons.check,
          color: Colors.green,
          onTap: () {
            setState(() {
              widget.tasks[ind].status = "Realizado";
            });
          },
        );
      default:
        return IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              setState(() {
                widget.tasks.removeAt(ind);
              });
            });
    }
  }

  void _openTask(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 200,
            width: 400, //Implementar MediaQuery
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        task.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      _showStatus(task.status),
                    ],
                  ),
                  _showPriority(task.priority),
                  _showDate(task.dateDue),
                  _showDetails(task.details),
                  ..._showSubtasks(task.subtasks),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cerrar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.tasks.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(children: <Widget>[
                Text('Sin tareas!',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ]);
            })
          : ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (ctx, ind) {
                return Slidable(
                  actionPane: SlidableScrollActionPane(),
                  key: Key(widget.tasks[ind].id),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
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
                                    Expanded(
                                      child: Text(
                                        widget.tasks[ind].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          /*color: Theme.of(context).primaryColorDark*/
                                        ),
                                      ),
                                    ),
                                    _showStatus(widget.tasks[ind].status),
                                    //todo armar mejor la presentación de los estados
                                  ],
                                ),

                                _showDate(widget.tasks[ind].dateDue),

                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child:
                                      _showPriority(widget.tasks[ind].priority),
                                ),

                                _showDetails(widget.tasks[ind].details),

                                //todo implementar contador de subtasks
                              ],
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.list_sharp),
                              onPressed: () {
                                _openTask(widget.tasks[ind]);
                              })
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[_nextStatus(widget.tasks[ind].status, ind)],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            widget.tasks.removeAt(ind);
                          });
                        })
                  ],
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                    onDismissed: (actionType) {
                      setState(() {
                        widget.tasks.removeAt(ind);
                      });
                    },
                  ),
                );
              }),
    );
  }
}
