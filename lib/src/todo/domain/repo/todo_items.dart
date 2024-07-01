import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';

abstract class TodoItemRepo {
  const TodoItemRepo();

  ResultFuture<void> createTodo({
    required TodoItem todoItem,
  });

  ResultFuture<List<TodoItem>> getTodos();

  ResultFuture<void> updateTodo({
    required String todoId,
    required TodoItem todoItem,
    required bool isCompleted,
  });

  ResultFuture<void> deleteTodo({
    required String listId,
    required String itemId,
  });
}
