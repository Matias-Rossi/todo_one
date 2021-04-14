import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

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
        ? Text("\u{1F4C5} ${DateFormat.yMd().format(dateDue)}")
        : TaskList._empty;
  }

  Widget _showDetails(String details) {
    if (details != null) {
      return details.isNotEmpty
          ? Text(details, style: TextStyle(color: Colors.black12))
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
                return Dismissible(
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
                                    Text(
                                      widget.tasks[ind].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        /*color: Theme.of(context).primaryColorDark*/
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child:
                                          _showStatus(widget.tasks[ind].status),
                                    ),
                                    //todo armar mejor la presentación de los estados
                                  ],
                                ),
                                Row(
                                  children: [
                                    _showDate(widget.tasks[ind].dateDue),
                                    widget.tasks[ind].priority == 1
                                        ? Text("Urgente")
                                        : TaskList._empty,
                                    widget.tasks[ind].priority == 2
                                        ? Text("Normal")
                                        : TaskList._empty,
                                    widget.tasks[ind].priority == 3
                                        ? Text("No urgente")
                                        : TaskList._empty,
                                    //todo estilizar con colores
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                                _showDetails(widget.tasks[ind].details),
                                ..._showSubtasks(widget.tasks[ind]
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
                  ),
                  background: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.delete_forever, size: 24.0),
                          //Icon(Icons.delete_forever, size: 24.0),
                          Text(""),
                        ],
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      widget.tasks.removeAt(ind);
                    });
                    /*
                    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                        content: Text("${widget.tasks[ind].name} eliminado")));*/
                  },
                );
              }),
    );
  }
}
