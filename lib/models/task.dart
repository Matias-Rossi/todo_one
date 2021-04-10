import 'package:flutter/foundation.dart';

class Subtask {
  bool isCompleted;
  String name;
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
