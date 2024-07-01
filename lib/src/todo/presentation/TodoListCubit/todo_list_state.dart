part of 'todo_list_cubit.dart';

sealed class TodoListState extends Equatable {
  const TodoListState();

  @override
  List<Object> get props => [];
}

class TodoListInitial extends TodoListState {
  const TodoListInitial();
}

class LoadingTodoList extends TodoListState {
  const LoadingTodoList();
}

class CreatingTodoList extends TodoListState {
  const CreatingTodoList();
}

class TodoListCreated extends TodoListState {
  const TodoListCreated();
}

class TodoListLoaded extends TodoListState {
  const TodoListLoaded(this.todoLists);

  final List<TodoList> todoLists;

  @override
  List<Object> get props => [todoLists];
}

class TodoListError extends TodoListState {
  const TodoListError(this.errorMessage);

  final String errorMessage;

  @override
  List<String> get props => [errorMessage];
}

