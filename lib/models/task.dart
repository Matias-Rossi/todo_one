import 'package:flutter/foundation.dart';

class Subtask {
  bool isCompleted;
  String name;

  Subtask(this.name, this.isCompleted);
}

class Task {
  String id;
  String name;
  DateTime dateCreated;
  String details;
  List<String> tags;
  DateTime dateDue;
  List<Subtask> subtasks;
  int priority;
  String status;

  Task(
      {@required this.id,
      @required this.name,
      @required this.dateCreated,
      this.details,
      this.tags,
      this.dateDue,
      this.subtasks,
      this.priority});
}
