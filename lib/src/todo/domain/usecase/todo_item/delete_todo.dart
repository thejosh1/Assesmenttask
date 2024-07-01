import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/core/usecases/usecase.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_items.dart';

class DeleteTodoUseCase
    extends UseCaseWithParams<void, DeleteTodoUseCaseParams> {
  const DeleteTodoUseCase(this._repo);

  final TodoItemRepo _repo;

  @override
  ResultFuture<void> call(DeleteTodoUseCaseParams params) =>
      _repo.deleteTodo(listId: params.listId, itemId: params.itemId);
}

class DeleteTodoUseCaseParams extends Equatable {
  const DeleteTodoUseCaseParams({required this.listId, required this.itemId});

  const DeleteTodoUseCaseParams.empty() : this(listId: '', itemId: '');

  final String listId;
  final String itemId;

  @override
  List<Object?> get props => [listId, itemId];
}
