import 'package:flutter/material.dart';
import '../models/task.dart';
import './task_elements.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;

  TaskList(this.tasks);

  static Widget _empty = Container(width: 0, height: 0);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
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
            //height: 200,
            width: 400, //todo Implementar MediaQuery
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
                      Flexible(
                        child: Text(
                          task.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TaskStatus(status: task.status),
                    ],
                  ),
                  TaskPriority(priority: task.priority),
                  TaskDueDate(dateDue: task.dateDue),
                  TaskDetails(details: task.details),
                  TaskSubtasks(task.subtasks),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
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
                                    TaskStatus(
                                        status: widget.tasks[ind].status),
                                    //todo armar mejor la presentación de los estados
                                  ],
                                ),
                                TaskDueDate(dateDue: widget.tasks[ind].dateDue),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: TaskPriority(
                                      priority: widget.tasks[ind].priority),
                                ),
                                TaskSubtasksCounter(
                                    subtasks: widget.tasks[ind].subtasks),
                                TaskDetails(details: widget.tasks[ind].details),
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
