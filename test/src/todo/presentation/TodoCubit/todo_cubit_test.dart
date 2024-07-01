import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/create_todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/delete_todo.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/get_all_todos.dart';
import 'package:pridera_assesment_task/src/todo/domain/usecase/todo_item/update_todo.dart';
import 'package:pridera_assesment_task/src/todo/presentation/TodoCubit/todo_cubit.dart';

class MockCreateTodo extends Mock implements CreateTodoUsecase {}

class MockDeleteTodo extends Mock implements DeleteTodoUseCase {}

class MockGetTodos extends Mock implements GetAllTodosUsecase {}

class MockUpdateTodo extends Mock implements UpdateTodoUsecase {}

void main() {
  late CreateTodoUsecase createTodo;
  late DeleteTodoUseCase deleteTodo;
  late GetAllTodosUsecase getTodos;
  late UpdateTodoUsecase updateTodo;
  late TodoCubit todoCubit;

  const tTodo = TodoModel.empty();
  const tCreateTodoParams = CreateTodoUsecaseParams(todoItem: tTodo);
  final tDeleteTodoParams = DeleteTodoUseCaseParams(
    listId: tTodo.listId,
    itemId: tTodo.id,
  );
  final tUpdateTodoParams = UpdateTodoUsecaseParams(
    todoId: tTodo.id,
    todoItem: tTodo,
    isCompleted: tTodo.isCompleted,
  );

  setUp(() {
    createTodo = MockCreateTodo();
    deleteTodo = MockDeleteTodo();
    getTodos = MockGetTodos();
    updateTodo = MockUpdateTodo();
    todoCubit = TodoCubit(
      createTodo: createTodo,
      deleteTodo: deleteTodo,
      getTodos: getTodos,
      updateTodo: updateTodo,
    );

    registerFallbackValue(tTodo);
    registerFallbackValue(tCreateTodoParams);
    registerFallbackValue(tDeleteTodoParams);
    registerFallbackValue(tUpdateTodoParams);
  });

  tearDown(() {
    todoCubit.close();
  });

  test('InitialState should be [TodoListInitial]', () {
    expect(todoCubit.state, const TodoInitial());
  });

  group('create Todo', () {
    blocTest(
      'emits [CreatingTodo, Todo Created] when create todo is called',
      build: () {
        when(() => createTodo(any()))
            .thenAnswer((_) async => const Right(null));
        return todoCubit;
      },
      act: (cubit) => cubit.createTodo(tCreateTodoParams),
      expect: () => const <TodoState>[
        CreatingTodo(),
        TodoCreated(),
      ],
      verify: (_) {
        verify(() => createTodo(tCreateTodoParams)).called(1);
        verifyNoMoreInteractions(createTodo);
      },
    );

    blocTest(
      'emits [CreatingTodo, TodoError] when create todo is called',
      build: () {
        when(() => createTodo(any())).thenAnswer((_) async => Left(
            ServerFailure(message: 'Something went wrong', statusCode: '500')));
        return todoCubit;
      },
      act: (cubit) => cubit.createTodo(tCreateTodoParams),
      expect: () => const <TodoState>[
        CreatingTodo(),
        TodoError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => createTodo(tCreateTodoParams)).called(1);
        verifyNoMoreInteractions(createTodo);
      },
    );
  });

  group('update Todo', () {
    blocTest(
      'emits [UpdatingTodo, Todo Updated] when update todo is called',
      build: () {
        when(() => updateTodo(any()))
            .thenAnswer((_) async => const Right(null));
        return todoCubit;
      },
      act: (cubit) => cubit.updateTodo(tUpdateTodoParams),
      expect: () => const <TodoState>[
        UpdatingTodo(),
        TodoUpdated(),
      ],
      verify: (_) {
        verify(() => updateTodo(tUpdateTodoParams)).called(1);
        verifyNoMoreInteractions(updateTodo);
      },
    );

    blocTest(
      'emits [UpdatingTodo, TodoError] when update todo is called',
      build: () {
        when(() => updateTodo(any())).thenAnswer((_) async => Left(
            ServerFailure(message: 'Something went wrong', statusCode: '500')));
        return todoCubit;
      },
      act: (cubit) => cubit.updateTodo(tUpdateTodoParams),
      expect: () => const <TodoState>[
        UpdatingTodo(),
        TodoError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => updateTodo(tUpdateTodoParams)).called(1);
        verifyNoMoreInteractions(updateTodo);
      },
    );
  });

  group('delete Todo', () {
    blocTest(
      'emits [DeletingTodo, TodoDeleted] when delete todo is called',
      build: () {
        when(() => deleteTodo(any()))
            .thenAnswer((_) async => const Right(null));
        return todoCubit;
      },
      act: (cubit) => cubit.deleteTodos(tDeleteTodoParams),
      expect: () => const <TodoState>[
        DeletingTodo(),
        TodoDeleted(),
      ],
      verify: (_) {
        verify(() => deleteTodo(tDeleteTodoParams)).called(1);
        verifyNoMoreInteractions(deleteTodo);
      },
    );

    blocTest(
      'emits [DeletingTodo, TodoError] when create todo is called',
      build: () {
        when(() => deleteTodo(any())).thenAnswer(
          (_) async => Left(
            ServerFailure(message: 'Something went wrong', statusCode: '500'),
          ),
        );
        return todoCubit;
      },
      act: (cubit) => cubit.deleteTodos(tDeleteTodoParams),
      expect: () => const <TodoState>[
        DeletingTodo(),
        TodoError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => deleteTodo(tDeleteTodoParams)).called(1);
        verifyNoMoreInteractions(deleteTodo);
      },
    );
  });

  group('get all Todo', () {
    blocTest(
      'emits [TodoListLoading, TodoListLoaded] when getTodoList is called',
      build: () {
        when(() => getTodos()).thenAnswer((_) async => const Right([tTodo]));
        return todoCubit;
      },
      act: (cubit) => cubit.getTodos(),
      expect: () => <TodoState>[
        const LoadingTodos(),
        const TodoLoaded([tTodo]),
      ],
      verify: (_) {
        verify(() => getTodos()).called(1);
        verifyNoMoreInteractions(getTodos);
      },
    );

    blocTest(
      'emits [TodoListLoading, TodoListError] when getTodoList is called',
      build: () {
        when(() => getTodos()).thenAnswer(
          (_) async => Left(
            ServerFailure(message: 'Something went wrong', statusCode: '500'),
          ),
        );
        return todoCubit;
      },
      act: (cubit) => cubit.getTodos(),
      expect: () => <TodoState>[
        const LoadingTodos(),
        const TodoError('500 Error: Something went wrong'),
      ],
      verify: (_) {
        verify(() => getTodos()).called(1);
        verifyNoMoreInteractions(getTodos);
      },
    );
  });
}
