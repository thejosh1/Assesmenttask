import 'package:dartz/dartz.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_items.dart';

class TodoRepoImpl implements TodoItemRepo {
  const TodoRepoImpl(this._remoteDataSource);

  final TodoRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<void> createTodo({
    required TodoItem todoItem,
  }) async {
    try {
      await _remoteDataSource.createTodo(todoItem);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteTodo({
    required String listId,
    required String itemId,
  }) async {
    try {
      await _remoteDataSource.deleteTodo(
        listId: listId,
        itemId: itemId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<TodoItem>> getTodos() async {
    try {
      final todos = await _remoteDataSource.getTodos();
      return Right(todos);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateTodo({
    required String todoId,
    required TodoItem todoItem,
    required bool isCompleted,
  }) async {
    try {
      await _remoteDataSource.updateTodo(
        todoId: todoId,
        todo: todoItem,
        isCompleted: isCompleted,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
