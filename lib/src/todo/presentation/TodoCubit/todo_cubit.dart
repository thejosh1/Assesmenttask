import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/create_todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/delete_todo.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/get_all_todos.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/update_todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({
    required CreateTodoUsecase createTodo,
    required GetAllTodosUsecase getTodos,
    required DeleteTodoUseCase deleteTodo,
    required UpdateTodoUsecase updateTodo,
  })  : _createTodo = createTodo,
        _getTodos = getTodos,
        _deleteTodo = deleteTodo,
        _updateTodo = updateTodo,
        super(const TodoInitial());

  final CreateTodoUsecase _createTodo;
  final GetAllTodosUsecase _getTodos;
  final DeleteTodoUseCase _deleteTodo;
  final UpdateTodoUsecase _updateTodo;

  Future<void> createTodo(
      CreateTodoUsecaseParams createTodoUsecaseParams,) async {
    emit(const CreatingTodo());
    final result = await _createTodo(createTodoUsecaseParams);
    result.fold(
      (failure) => emit(TodoError(failure.errorMessage)),
      (_) => emit(const TodoCreated()),
    );
  }

  Future<void> updateTodo(
      UpdateTodoUsecaseParams updateTodoUsecaseParams,) async {
    emit(const UpdatingTodo());
    final result = await _updateTodo(updateTodoUsecaseParams);
    result.fold(
          (failure) => emit(TodoError(failure.errorMessage)),
          (_) {
            emit(const TodoUpdated());
            getTodos();
          },
    );
  }

  Future<void> deleteTodos(
      DeleteTodoUseCaseParams deleteTodoUseCaseParams,) async {
    emit(const DeletingTodo());
    final result = await _deleteTodo(deleteTodoUseCaseParams);
    result.fold(
      (failure) => emit(TodoError(failure.errorMessage)),
      (_) {
        emit(const TodoDeleted());
        getTodos();
      }
    );
  }

  Future<void> getTodos() async {
    emit(const LoadingTodos());
    final result = await _getTodos();
    result.fold(
          (failure) => emit(TodoError(failure.errorMessage)),
          (todos) => emit(TodoLoaded(todos)),
    );
  }
}
