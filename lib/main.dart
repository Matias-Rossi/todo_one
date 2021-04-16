import 'package:flutter/material.dart';

import './widgets/add_task.dart';
import './widgets/task_list.dart';
import './models/task.dart';
import './widgets/search_sort_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _userTasks = [
    Task(
      id: DateTime.now().toString(),
      name: "Hacer tarea AM2",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 1,
      status: "Hoy",
      details: "Ejercicios 4 a 12",
    ),
    Task(
      id: DateTime.now().add(Duration(days: 1)).toString(),
      name: "Ver la carrera",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 3,
      status: "Pendiente",
      dateDue: DateTime.utc(2021, 4, 18),
      subtasks: [
        Subtask("Ver clasificacion", false),
        Subtask("Ver carrera", false)
      ],
    ),
    Task(
      id: DateTime.now().add(Duration(hours: 1)).toString(),
      name: "Leer SSL",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 2,
      status: "Pendiente",
      details: "Unidad 3",
    ),
    Task(
      id: DateTime.now().add(Duration(hours: 2)).toString(),
      name: "Hacer tarea PdeP",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 2,
      status: "Pendiente",
      dateDue: DateTime.utc(2021, 4, 22),
    ),
    Task(
      id: DateTime.now().add(Duration(hours: 3)).toString(),
      name: "Arreglar horario grupo Física",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 2,
      status: "Pendiente",
    ),
    Task(
      id: DateTime.now().add(Duration(hours: 4)).toString(),
      name: "Relajar un rato",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 3,
      status: "Pendiente",
    ),
    Task(
      id: DateTime.now().add(Duration(hours: 5)).toString(),
      name: "Lavar el auto",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 3,
      status: "Hoy",
    ),
    Task(
      id: DateTime.now().add(Duration(hours: 6)).toString(),
      name: "Llamar a la tía",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 3,
      status: "Hoy",
    ),
  ];

  void _addNewTask(
    String name,
    DateTime dateDue,
    String details,
    String tagsString,
    String subtasksString,
    int priority,
  ) {
    final List<String> tags = tagsString.split(", ");
    final List<String> subtasksList = subtasksString.split(", ");

    List<Subtask> _subtasks = [];
    if (subtasksList.isNotEmpty && subtasksList != null)
      subtasksList.forEach((subtaskName) {
        Subtask newSubtask = Subtask(subtaskName, false);
        _subtasks.add(newSubtask);
      });

    final newTask = Task(
      id: DateTime.now().toString(),
      name: name,
      dateCreated: DateTime.now(),
      details: details,
      tags: tags,
      dateDue: dateDue,
      subtasks: _subtasks,
      priority: priority,
      status: "Pendiente",
    );

    setState(() {
      _userTasks.add(newTask);
    });
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddTask(_addNewTask),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text("To-Do List"), actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _startAddNewTask(context),
      ),
    ]);

    final _searchSortBar = SearchSortBar();
    final taskListWidget = Expanded(child: TaskList(_userTasks));

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          _searchSortBar,
          taskListWidget,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTask(context),
      ),
    );
  }
}
