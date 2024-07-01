part of 'todo_cubit.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {
  const TodoInitial();
}

class LoadingTodos extends TodoState {
  const LoadingTodos();
}

class TodoLoaded extends TodoState {
  const TodoLoaded(this.todos);

  final List<TodoItem> todos;

  @override
  List<Object> get props => [todos];
}

class CreatingTodo extends TodoState {
  const CreatingTodo();
}

class TodoCreated extends TodoState {
  const TodoCreated();
}

class UpdatingTodo extends TodoState {
  const UpdatingTodo();
}

class TodoUpdated extends TodoState {
  const TodoUpdated();
}

class DeletingTodo extends TodoState {
  const DeletingTodo();
}

class TodoDeleted extends TodoState {
  const TodoDeleted();
}

class TodoError extends TodoState {
   const TodoError(this.errorMessage);

   final String errorMessage;

   @override
   List<String> get props => [errorMessage];
}



