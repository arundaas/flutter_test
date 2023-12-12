import 'package:flutter/material.dart';
import 'package:sample/lesson3/db_helper/db_helper.dart';
import 'package:sample/lesson3/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoProvider extends ChangeNotifier {
  List todoItem = [];

  Future selectData() async {
    final dataList = await DBHelper.selectAll(DBHelper.todo);

    todoItem = dataList
        .map(
          (item) => TodoModel(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            date: item['date'],
          ),
        )
        .toList();
    notifyListeners();
  }

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

  Future deleteById(id) async {
    DBHelper.deleteById(
      DBHelper.todo,
      'id',
      id,
    );
    notifyListeners();
  }
}
