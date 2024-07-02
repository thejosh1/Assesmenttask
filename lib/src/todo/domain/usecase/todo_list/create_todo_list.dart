import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_list_repo.dart';

class CreateTodoListUsecase
    extends UseCaseWithParams<void, CreateTodoListParams> {
  const CreateTodoListUsecase(this._repo);

  final TodoListRepo _repo;

  @override
  ResultFuture<void> call(CreateTodoListParams params) =>
      _repo.createTodoList(todoList: params.todoList);
}

class CreateTodoListParams extends Equatable {
  const CreateTodoListParams({required this.todoList});

  const CreateTodoListParams.empty() : this(todoList: const TodoList.empty());

  final TodoList todoList;

  @override
  List<Object?> get props => [todoList];
}
