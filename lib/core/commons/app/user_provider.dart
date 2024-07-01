import 'package:flutter/cupertino.dart';
import 'package:pridera_assesment_task/src/auth/data/model/local_user_model.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

  void initUser(LocalUserModel? user) {
    if(_user != user) _user = user;
  }

  set user(LocalUserModel? user) {
    if(_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
