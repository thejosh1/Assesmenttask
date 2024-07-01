import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';

void main() {
  late TodoRemoteDataSrc remoteDataSrc;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;

  setUp(() async {
    firestore = FakeFirebaseFirestore();
    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);

    remoteDataSrc = TodoRemoteDataSrcImpl(firestore: firestore, auth: auth);
  });

  group('create todo', () {
    test(
      'should add a given todo to the firebase collection',
      () async {
        //Arrange
        const todo = TodoModel.empty();

        //act
        await remoteDataSrc.createTodo(todo);

        //assert
        final firestoreData = await firestore.collection('Todos-Items').get();
        expect(firestoreData.docs.length, 1);

        final todoRef = firestoreData.docs.first;
        expect(todoRef.data()['id'], todoRef.id);
      },
    );
  });

  group('update todo', () {
    test('should update the given todo on the firestore server', () async {
      // Arrange
      const todo = TodoModel.empty();

      // Add a document to delete
      await firestore.collection('Todos-Items').doc(todo.id).set({
        'id': todo.id,
        'title': 'Test Todo',
        'isComplete': false,
        // Add other fields as necessary
      });

      // Verify the document was added
      final initialData = await firestore.collection('Todos-Items').get();
      expect(initialData.docs.length, 1);

      // Act
      await remoteDataSrc.updateTodo(
        todoId: todo.id,
        todo: todo,
        isCompleted: todo.isCompleted,
      );

      // Assert
      await firestore
          .collection('Todos-Items')
          .doc(todo.id)
          .update(todo.copyWith(isCompleted: true).toMap());
      // Assert that the document no longer exists
      final updatedDoc =
          await firestore.collection('Todos-Items').doc(todo.id).get();

      expect(updatedDoc.exists, true);

      // Optionally, check if the collection is empty
      final remainingDocs = await firestore.collection('Todos-Items').get();

      expect(remainingDocs.docs.length, 1);
    });
  });

  group('delete todo', () {
    test('should delete the given todo on the firestore server', () async {
      // Arrange
      const todo = TodoModel.empty();

      // Add a document to delete
      await firestore.collection('Todos-Items').doc(todo.id).set({
        'id': todo.id,
        'title': 'Test Todo',
        // Add other fields as necessary
      });

      // Verify the document was added
      final initialData = await firestore.collection('Todos-Items').get();
      expect(initialData.docs.length, 1);

      // Act
      await remoteDataSrc.deleteTodo(listId: todo.listId, itemId: todo.id);

      // Assert
      await firestore.collection('Todos-Items').doc(todo.id).delete();
      // Assert that the document no longer exists
      final deletedDoc =
          await firestore.collection('Todos-Items').doc(todo.id).get();

      expect(deletedDoc.exists, false);

      // Optionally, check if the collection is empty
      final remainingDocs = await firestore.collection('Todos-Items').get();

      expect(remainingDocs.docs.length, 0);
    });
  });

  group('get todos', () {
    test(
      'should return a List<Todo> when the call is successful',
      () async {
        final expectedTodos = [
          const TodoModel.empty().copyWith(
            id: '2',
            title: 'Title 1',
          ),
          const TodoModel.empty().copyWith(
            title: 'Title 2',
            id: '1',
          ),
        ];

        for (final todos in expectedTodos) {
          await firestore.collection('Todos-Items').add(todos.toMap());
        }

        final result = await remoteDataSrc.getTodos();

        expect(result, expectedTodos);
      },
    );
  });
}
