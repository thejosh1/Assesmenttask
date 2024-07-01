import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';

abstract class TodoListRepo {
  const TodoListRepo();

  ResultFuture<List<TodoList>> getAllTodoLists();
  ResultFuture<void> createTodoList({
    required TodoList todoList,
  });
}
