import 'package:flutter/cupertino.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel>? _todos;

  List<TodoModel>? get todos => _todos;

  void initTodo(List<TodoModel>? todos) {
    if(_todos != todos) _todos = todos;
  }

  set todos(List<TodoModel>? todos) {
    if(_todos != todos) {
      _todos = todos;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
