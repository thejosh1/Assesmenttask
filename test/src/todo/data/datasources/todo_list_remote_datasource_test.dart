import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:pridera_assesment_task/src/todo/data/datasources/todo_list_remote_datasource.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todolist_model.dart';

void main() {
  late TodoListRemoteDataSrc remoteDataSrc;
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

    remoteDataSrc = TodoListRemoteDataSrcImpl(firestore: firestore, auth: auth);
  });

  group('create todo', () {
    test(
      'should add a given todo to the firebase collection',
      () async {
        //Arrange
        final todoList = TodoListModel.empty();

        //act
        await remoteDataSrc.createTodoList(todoList);

        //assert
        final firestoreData = await firestore.collection('Todos').get();
        expect(firestoreData.docs.length, 1);

        final todoListRef = firestoreData.docs.first;
        expect(todoListRef.data()['id'], todoListRef.id);
      },
    );
  });

  group('get todos', () {
    test(
      'should return a List<TodoList> when the call is successful',
      () async {
        final expectedTodos = [
          TodoListModel.empty().copyWith(
            id: '2',
            title: 'Title 1',
          ),
          TodoListModel.empty().copyWith(
            title: 'Title 2',
            id:  '1',
          ),
        ];

        for (final todolist in expectedTodos) {
          await firestore.collection('Todos').add(todolist.toMap());
        }

        final result = await remoteDataSrc.getAllTodos();

        expect(result, expectedTodos);
      },
    );
  });
}
