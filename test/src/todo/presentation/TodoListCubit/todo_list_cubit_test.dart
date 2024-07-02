import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todolist_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/create_todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_list/get_all_todo_lists.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoListCubit/todo_list_cubit.dart';

class MockCreateTodoList extends Mock implements CreateTodoListUsecase {}

class MockGetAllTodoList extends Mock implements GetAllTodoListsUsecase {}

void main() {
  late CreateTodoListUsecase createTodoList;
  late GetAllTodoListsUsecase getAllTodoList;
  late TodoListCubit todoListCubit;

  const tTodoList = TodoListModel.empty();
  final tCreateTodoListParams = CreateTodoListParams(todoList: tTodoList);

  setUp(() {
    createTodoList = MockCreateTodoList();
    getAllTodoList = MockGetAllTodoList();
    todoListCubit = TodoListCubit(
      createTodoList: createTodoList,
      getAllTodoList: getAllTodoList,
    );

    registerFallbackValue(tTodoList);
    registerFallbackValue(tCreateTodoListParams);
  });

  tearDown(() {
    todoListCubit.close();
  });

  test('InitialState should be [TodoListInitial]', () {
    expect(todoListCubit.state, const TodoListInitial());
  });

  group('create TodoList', () {
    blocTest(
      'emits [CreatingTodoList, TodoListCreated] when create todo is called',
      build: () {
        when(() => createTodoList(any()))
            .thenAnswer((_) async => const Right(null));
        return todoListCubit;
      },
      act: (cubit) => cubit.createTodoList(tCreateTodoListParams),
      expect: () => const <TodoListState>[
        CreatingTodoList(),
        TodoListCreated(),
      ],
      verify: (_) {
        verify(() => createTodoList(tCreateTodoListParams)).called(1);
        verifyNoMoreInteractions(createTodoList);
      },
    );

    blocTest(
      'emits [CreatingTodoList, TodoListError] when create todo is called',
      build: () {
        when(() => createTodoList(any())).thenAnswer((_) async => Left(
            ServerFailure(message: 'Something went wrong', statusCode: '500'),),);
        return todoListCubit;
      },
      act: (cubit) => cubit.createTodoList(tCreateTodoListParams),
      expect: () => const <TodoListState>[
        CreatingTodoList(),
        TodoListError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => createTodoList(tCreateTodoListParams)).called(1);
        verifyNoMoreInteractions(createTodoList);
      },
    );
  });

  group('get all TodoList', () {
    blocTest(
      'emits [TodoListLoading, TodoListLoaded] when getTodoList is called',
      build: () {
        when(() => getAllTodoList())
            .thenAnswer((_) async => Right([tTodoList]));
        return todoListCubit;
      },
      act: (cubit) => cubit.getTodoLists(),
      expect: () => <TodoListState>[
        const LoadingTodoList(),
        TodoListLoaded([tTodoList]),
      ],
      verify: (_) {
        verify(() => getAllTodoList()).called(1);
        verifyNoMoreInteractions(getAllTodoList);
      },
    );

    blocTest(
      'emits [TodoListLoading, TodoListError] when getTodoList is called',
      build: () {
        when(() => getAllTodoList()).thenAnswer(
          (_) async => Left(
            ServerFailure(message: 'Something went wrong', statusCode: '500'),
          ),
        );
        return todoListCubit;
      },
      act: (cubit) => cubit.getTodoLists(),
      expect: () => <TodoListState>[
        const LoadingTodoList(),
        const TodoListError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => getAllTodoList()).called(1);
        verifyNoMoreInteractions(getAllTodoList);
      },
    );
  });
}
