import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_list_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todolist_model.dart';
import 'package:pridera_assesment_task/src/todo/data/repo/todo_list_repo_impl.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';


class MockTodoListRemoteDataSrc extends Mock implements TodoListRemoteDataSrc {}

void main() {
  late TodoListRemoteDataSrc remoteDataSrc;
  late TodoListRepoImpl repoImpl;

  const tTodoList = TodoListModel.empty();
  const tId = 'test id';

  setUp(() {
    remoteDataSrc = MockTodoListRemoteDataSrc();
    repoImpl = TodoListRepoImpl(remoteDataSrc);
    registerFallbackValue(tTodoList);
  });

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  group('create todoList', () {
    test(
        'should complete successfully when call to remote datasource is '
        'successful', () async {
      when(() => remoteDataSrc.createTodoList(any())).thenAnswer(
        (_) async => Future.value,
      );
      final result = await repoImpl.createTodoList(todoList: tTodoList);
      expect(result, const Right<dynamic, void>(null));
      verify(() => remoteDataSrc.createTodoList(tTodoList)).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });

    test(
      'should return [ServerFailure] when call to remote datasource is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.createTodoList(any())).thenThrow(tException);
        final result = await repoImpl.createTodoList(todoList: tTodoList);
        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSrc.createTodoList(tTodoList)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('get all todos', () {
    test(
        'should return [List<TodoList>] when call to remote data src is '
        'successful', () async {
      when(() => remoteDataSrc.getAllTodos()).thenAnswer(
        (_) async => [tTodoList],
      );
      final result = await repoImpl.getAllTodoLists();
      expect(result, isA<Right<dynamic, List<TodoList>>>());
      verify(() => remoteDataSrc.getAllTodos()).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });

    test(
      'should return [ServerFailure] when call to remote data source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.getAllTodos()).thenThrow(tException);
        final result = await repoImpl.getAllTodoLists();
        expect(
          result,
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSrc.getAllTodos()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });
}
