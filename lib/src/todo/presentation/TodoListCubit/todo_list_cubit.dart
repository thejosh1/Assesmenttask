import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/create_todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/get_all_todo_lists.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit({required CreateTodoListUsecase createTodoList, required GetAllTodoListsUsecase getAllTodoList})
      : _createTodoList = createTodoList, _getAllTodoList = getAllTodoList,
        super(const TodoListInitial());

  final CreateTodoListUsecase _createTodoList;
  final GetAllTodoListsUsecase _getAllTodoList;

  Future<void> createTodoList(CreateTodoListParams createTodoListParams) async {
    emit(const CreatingTodoList());
    final result = await _createTodoList(createTodoListParams);
    result.fold(
          (failure) => emit(TodoListError(failure.errorMessage)),
          (_) => emit(const TodoListCreated()),
    );
  }

  Future<void> getTodoLists() async {
    emit(const LoadingTodoList());
    final result = await _getAllTodoList();
    result.fold(
          (failure) => emit(TodoListError(failure.errorMessage)),
          (todoLists) => emit(TodoListLoaded(todoLists)),
    );
  }
}
