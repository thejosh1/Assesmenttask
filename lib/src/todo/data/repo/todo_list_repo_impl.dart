import 'package:dartz/dartz.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/core/errors/failures.dart';
import 'package:pridera_assesment_task/core/utility/typedef.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_list_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';
import 'package:pridera_assesment_task/src/todo/domain/repo/todo_list_repo.dart';

class TodoListRepoImpl implements TodoListRepo {
  const TodoListRepoImpl(this._remoteDataSrc);

  final TodoListRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> createTodoList({required TodoList todoList}) async {
    try {
      await _remoteDataSrc.createTodoList(todoList);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }



  @override
  ResultFuture<List<TodoList>> getAllTodoLists() async {
    try {
      final todoLists = await _remoteDataSrc.getAllTodos();
      return Right(todoLists);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
