import 'package:flutter/material.dart';
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
  final appBar = AppBar(title: Text("To-Do List"), actions: <Widget>[
    IconButton(
      icon: Icon(Icons.add),
      onPressed: () => addTask,
    ),
  ]);

  void _addNewTask(
    String name, {
    dateDue: DateTime,
    details: String,
    tags: String,
    subtasks: String,
    priority: int,
  }) {
    final newTask = Task(
      id: DateTime.now().toString(),
      name: name,
      dateCreated: DateTime.now(),
      details: details,
      tags: tags,
      dateDue: dateDue,
      subtasks: subtasks,
      priority: priority,
    );

    setState((){
      _userTaks.add(newTask);
    })
  }

  void _startNewTask(BuildContext ctx) {
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
    return Scaffold();
  }
}
