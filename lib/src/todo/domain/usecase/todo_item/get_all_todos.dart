import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_items.dart';

class GetAllTodosUsecase extends UseCaseWithoutParams<List<TodoItem>> {
  const GetAllTodosUsecase(this._repo);

  final TodoItemRepo _repo;

  @override
  ResultFuture<List<TodoItem>> call() {
    return _repo.getTodos();
  }
}