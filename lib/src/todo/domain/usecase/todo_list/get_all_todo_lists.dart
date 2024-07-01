import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_list_repo.dart';


class GetAllTodoListsUsecase extends UseCaseWithoutParams<List<TodoList>> {
  const GetAllTodoListsUsecase(this._repo);

  final TodoListRepo _repo;

  @override
  ResultFuture<List<TodoList>> call() {
    return _repo.getAllTodoLists();
  }
}
