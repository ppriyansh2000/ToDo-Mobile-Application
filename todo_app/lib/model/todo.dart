import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
  static List<ToDo> todoList() {
    // populate list via API
    return [
      ToDo(
        id: '06',
        todoText: 'Dinner',
      ),
      ToDo(
        id: '05',
        todoText: 'Work Out',
      ),
      ToDo(
        id: '04',
        todoText: 'Team Meeting',
      ),
      ToDo(id: '03', todoText: 'Check Emails', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
    ];
  }
}
