import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_items.dart';

class CreateTodoUsecase
    extends UseCaseWithParams<void, CreateTodoUsecaseParams> {
  const CreateTodoUsecase(this._repo);

  final TodoItemRepo _repo;

  @override
  ResultFuture<void> call(CreateTodoUsecaseParams params) =>
      _repo.createTodo(todoItem: params.todoItem);
}

class CreateTodoUsecaseParams extends Equatable {
  const CreateTodoUsecaseParams({
    required this.todoItem,
  });

  const CreateTodoUsecaseParams.empty()
      : this(
          todoItem: const TodoItem.empty(),
        );

  final TodoItem todoItem;

  @override
  List<Object?> get props => [todoItem];
}
