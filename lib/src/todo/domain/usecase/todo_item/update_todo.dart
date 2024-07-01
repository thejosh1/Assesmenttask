import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_items.dart';

class UpdateTodoUsecase
    extends UseCaseWithParams<void, UpdateTodoUsecaseParams> {
  const UpdateTodoUsecase(this._repo);

  final TodoItemRepo _repo;

  @override
  ResultFuture<void> call(UpdateTodoUsecaseParams params) => _repo.updateTodo(
        todoId: params.todoId,
        todoItem: params.todoItem,
        isCompleted: params.isCompleted,
      );
}

class UpdateTodoUsecaseParams extends Equatable {
  const UpdateTodoUsecaseParams({
    required this.todoId,
    required this.todoItem,
    required this.isCompleted,
  });

  const UpdateTodoUsecaseParams.empty()
      : this(
          todoId: '_empty.TodoId',
          todoItem: const TodoItem.empty(),
          isCompleted: false,
        );

  final String todoId;
  final TodoItem todoItem;
  final bool isCompleted;

  @override
  List<Object?> get props => [todoId, todoItem, isCompleted];
}
