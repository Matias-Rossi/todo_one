import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

Widget _empty = Container(width: 0, height: 0);

class TaskSubtasks extends StatefulWidget {
  final List<Subtask> subtasks;
  TaskSubtasks(this.subtasks);
  @override
  _TaskSubtasksState createState() => _TaskSubtasksState();
}

class _TaskSubtasksState extends State<TaskSubtasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: widget.subtasks.isEmpty
          ? _empty
          : ListView.builder(
              itemCount: widget.subtasks.length,
              itemBuilder: (context, ind) {
                return CheckboxListTile(
                    title: Text(widget.subtasks[ind].name),
                    value: widget.subtasks[ind].isCompleted,
                    onChanged: (bool newValue) {
                      setState(() {
                        widget.subtasks[ind].isCompleted = newValue;
                      });
                    });
              },
            ),
    );
  }
}

class TaskDueDate extends StatelessWidget {
  const TaskDueDate({
    Key key,
    @required this.dateDue,
  }) : super(key: key);

  final DateTime dateDue;

  @override
  Widget build(BuildContext context) {
    return dateDue != null
        ? Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text("\u{1F4C5} ${DateFormat.yMd().format(dateDue)}"),
          )
        : _empty;
  }
}

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    Key key,
    @required this.details,
  }) : super(key: key);

  final String details;

  @override
  Widget build(BuildContext context) {
    if (details != null) {
      return details.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(details, style: TextStyle(color: Colors.black45)),
            )
          : _empty;
    } else
      return _empty;
  }
}

class TaskStatus extends StatelessWidget {
  const TaskStatus({
    Key key,
    @required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
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
}

class TaskPriority extends StatelessWidget {
  const TaskPriority({
    Key key,
    @required this.priority,
  }) : super(key: key);

  final int priority;

  @override
  Widget build(BuildContext context) {
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
        return _empty;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(priorityStr),
    );

    //todo estilizar con colores
  }
}

class TaskSubtasksCounter extends StatelessWidget {
  const TaskSubtasksCounter({
    Key key,
    @required this.subtasks,
  }) : super(key: key);

  final List<Subtask> subtasks;

  int _countCompleted(subtasks) {
    int count = 0;
    subtasks.forEach((Subtask subtask) {
      if (subtask.isCompleted) count++;
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    if (subtasks == null) return _empty;
    //if (subtasks.length != 0) return _empty;
    int completed = _countCompleted(subtasks);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text("\u{2714} $completed/${subtasks.length}"),
    );
  }
}
