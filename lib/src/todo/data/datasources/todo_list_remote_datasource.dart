import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todolist_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_list.dart';

abstract class TodoListRemoteDataSrc {
  const TodoListRemoteDataSrc();

  Future<List<TodoList>> getAllTodos();
  Future<void> createTodoList(TodoList todoList);
}

class TodoListRemoteDataSrcImpl implements TodoListRemoteDataSrc {
  const TodoListRemoteDataSrcImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<void> createTodoList(TodoList todoList) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final todoRef = _firestore.collection('Todos').doc();

      final todoListModel = (todoList as TodoListModel).copyWith(
        id: todoRef.id,
      );

      return todoRef.set(todoListModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<List<TodoList>> getAllTodos() {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      return _firestore.collection('Todos').get().then(
            (value) => value.docs
                .map((doc) => TodoListModel.fromMap(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '500');
    }
  }
}
