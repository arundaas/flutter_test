import 'package:flutter/material.dart';
import 'package:sample/lesson3/db_helper/db_helper.dart';
import 'package:sample/lesson3/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoProvider extends ChangeNotifier {
  List todoItem = [];

  Future deleteTable() async {
    DBHelper.deleteTable(DBHelper.todo);
    todoItem.clear();
    notifyListeners();
  }

  Future insertData(
    String title,
    String description,
    String date,
  ) async {
    final newTodo = TodoModel(
      id: const Uuid().v1(),
      title: title,
      description: description,
      date: date,
    );
    todoItem.add(newTodo);
    DBHelper.insert(DBHelper.todo, {
      "id": newTodo.id,
      "title": newTodo.title,
      "description": newTodo.description,
      "date": newTodo.date,
    });
    notifyListeners();
  }
}
