import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTask extends StatefulWidget {
  //@override
  final Function addTask;
  AddTask(this.addTask);

  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();
  final _tagsController = TextEditingController();
  final _subtasksController = TextEditingController();
  final _priority = 1; //Todo: implement priority picker
  DateTime _dateDue;

  void _submitData() {
    if (_nameController.text.isEmpty) return;
    widget.addTask(
      _nameController.text,
      _dateDue,
      _detailsController.text,
      _tagsController.text,
      _subtasksController.text,
      _priority,
    );
    _nameController.dispose();
    _detailsController.dispose();
    _tagsController.dispose();
    _subtasksController.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateDue = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Título"),
                controller: _nameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Detalles"),
                controller: _detailsController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Tags"),
                controller: _tagsController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Subtareas"),
                controller: _subtasksController,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_dateDue == null
                          ? 'Sin fecha limite'
                          : 'Fecha limite: ${DateFormat.yMd().format(_dateDue)}'),
                    ),
                    TextButton(
                      child: Text('Establecer fecha límite'),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text('Añadir tarea'),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
