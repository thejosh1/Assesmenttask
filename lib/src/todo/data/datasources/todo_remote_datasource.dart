import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pridera_assesment_task/core/errors/exceptions.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';
import 'package:pridera_assesment_task/src/todo/domain/entities/todo_item.dart';

abstract class TodoRemoteDataSrc {
  const TodoRemoteDataSrc();

  Future<void> createTodo(TodoItem todo);
  Future<List<TodoItem>> getTodos();
  Future<void> updateTodo({
    required String todoId,
    required TodoItem todo,
    required bool isCompleted,
  });
  Future<void> deleteTodo({
    required String listId,
    required String itemId,
  });
}

class TodoRemoteDataSrcImpl implements TodoRemoteDataSrc {
  const TodoRemoteDataSrcImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<void> createTodo(TodoItem todo) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final todoRef = _firestore.collection('Todos-Items').doc();

      final todosModel = (todo as TodoModel).copyWith(
        id: todoRef.id,
      );

      return todoRef.set(todosModel.toMap());
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
  Future<void> deleteTodo({
    required String listId,
    required String itemId,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final todoRef = _firestore.collection('Todos-Items').doc(itemId);

      return todoRef.delete();
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
  Future<List<TodoItem>> getTodos() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      return _firestore.collection('Todos-Items').get().then(
            (value) =>
                value.docs.map((doc) => TodoModel.fromMap(doc.data())).toList(),
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

  @override
  Future<void> updateTodo({
    required String todoId,
    required TodoItem todo,
    required bool isCompleted,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final todoRef = _firestore.collection('Todos-Items').doc(todoId);

      final todosModel = (todo as TodoModel).copyWith(
        isCompleted: isCompleted,
      );

      return todoRef.update(todosModel.toMap());
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
