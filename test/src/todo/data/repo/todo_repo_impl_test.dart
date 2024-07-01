import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';
import 'package:pridera_assesment_task/src/todo/data/repo/todo_repo_impl.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';

class MockTodoRemoteDataSrc extends Mock implements TodoRemoteDataSrc {}

void main() {
  late TodoRemoteDataSrc remoteDataSrc;
  late TodoRepoImpl repoImpl;

  const tTodo = TodoModel.empty();

  setUp(() {
    remoteDataSrc = MockTodoRemoteDataSrc();
    repoImpl = TodoRepoImpl(remoteDataSrc);
    registerFallbackValue(tTodo);
  });

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  group('create todo', () {
    test(
        'should complete successfully when call to remote datasource is '
        'successful', () async {
      when(() => remoteDataSrc.createTodo(any())).thenAnswer(
        (_) async => Future.value,
      );
      final result = await repoImpl.createTodo(todoItem: tTodo);
      expect(result, const Right<dynamic, void>(null));
      verify(() => remoteDataSrc.createTodo(tTodo)).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });

    test(
      'should return [ServerFailure] when call to remote datasource is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.createTodo(any())).thenThrow(tException);
        final result = await repoImpl.createTodo(todoItem: tTodo);
        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSrc.createTodo(tTodo)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('update todo', () {
    test(
        'should complete successfully when call to remote datasource is '
        'successful', () async {
      when(
        () => remoteDataSrc.updateTodo(
          todoId: any(named: 'todoId'),
          todo: any(
            named: 'todo',
          ),
          isCompleted: any(named: 'isCompleted'),
        ),
      ).thenAnswer(
        (_) async => Future.value,
      );
      final result = await repoImpl.updateTodo(
        todoId: tTodo.id,
        todoItem: tTodo,
        isCompleted: tTodo.isCompleted,
      );
      expect(result, const Right<dynamic, void>(null));
      verify(() => remoteDataSrc.updateTodo(
            todoId: tTodo.id,
            todo: tTodo,
            isCompleted: tTodo.isCompleted,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });

    test(
      'should return [ServerFailure] when call to remote datasource is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSrc.updateTodo(
            todoId: any(named: 'todoId'),
            todo: any(
              named: 'todo',
            ),
            isCompleted: any(named: 'isCompleted'),
          ),
        ).thenThrow(tException);
        final result = await repoImpl.updateTodo(
          todoId: tTodo.id,
          todoItem: tTodo,
          isCompleted: tTodo.isCompleted,
        );
        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );
        verify(
          () => remoteDataSrc.updateTodo(
            todoId: tTodo.id,
            todo: tTodo,
            isCompleted: tTodo.isCompleted,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('delete todo', () {
    test(
        'should complete successfully when call to remote datasource is '
        'successful', () async {
      when(() => remoteDataSrc.deleteTodo(
          listId: any(named: 'listId'),
          itemId: any(named: 'itemId'))).thenAnswer(
        (_) async => Future.value,
      );
      final result = await repoImpl.deleteTodo(
        listId: tTodo.listId,
        itemId: tTodo.id,
      );
      expect(result, const Right<dynamic, void>(null));
      verify(
        () => remoteDataSrc.deleteTodo(listId: tTodo.listId, itemId: tTodo.id),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });

    test(
      'should return [ServerFailure] when call to remote datasource is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSrc.deleteTodo(
            listId: any(named: 'listId'),
            itemId: any(named: 'itemId'),
          ),
        ).thenThrow(tException);
        final result = await repoImpl.deleteTodo(
          listId: tTodo.listId,
          itemId: tTodo.id,
        );
        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );
        verify(
          () => remoteDataSrc.deleteTodo(
            listId: tTodo.listId,
            itemId: tTodo.id,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('get all todos', () {
    test(
        'should return [List<TodoList>] when call to remote data src is '
        'successful', () async {
      when(() => remoteDataSrc.getTodos()).thenAnswer(
        (_) async => [tTodo],
      );
      final result = await repoImpl.getTodos();
      expect(result, isA<Right<dynamic, List<TodoItem>>>());
      verify(() => remoteDataSrc.getTodos()).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });

    test(
      'should return [ServerFailure] when call to remote data source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.getTodos()).thenThrow(tException);
        final result = await repoImpl.getTodos();
        expect(
          result,
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSrc.getTodos()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });
}
