import 'package:flutter/material.dart';

import './widgets/add_task.dart';
import './widgets/task_list.dart';
import './models/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  @override
  final List<Task> _userTasks = [
    Task(
      id: DateTime.now().toString(),
      name: "Hacer tarea AM2",
      dateCreated: DateTime.now() != null ? DateTime.now() : DateTime.utc(2001),
      priority: 3,
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

    List<Subtask> _subtasks;
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
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddTask(_addNewTask),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text("To-Do List"), actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _startAddNewTask(context),
      ),
    ]);

    final taskListWidget = Expanded(child: TaskList(_userTasks));

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[taskListWidget],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTask(context),
      ),
    );
  }
}
