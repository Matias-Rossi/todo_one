import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();
  final _tagsController = TextEditingController();
  final _subtasksController = TextEditingController();
  DateTime _dateDue;
  DateTime _dateCreated;

  void _submitData() {
    if (_nameController.text.isEmpty) return;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateDue = pickedDate;
      });
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
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
    );
  }
}
