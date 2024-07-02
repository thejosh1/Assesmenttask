import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pridera_assesment_task/core/services/injection_container/injector_container.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';
import 'package:pridera_assesment_task/src/todo/data/models/todo_model.dart';

import 'package:pridera_assesment_task/src/todo/data/models/todolist_model.dart';

class MainPageUtils {
  const MainPageUtils._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));

  static Stream<TodoListModel> get todoListData => sl<FirebaseFirestore>()
      .collection('Todos')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => TodoListModel.fromMap(event.data()!));

  static Future<List<TodoModel>> get todoData => sl<FirebaseFirestore>()
      .collection('Todos-Items')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => TodoModel.fromMap(event.data()!)).toList();
}
