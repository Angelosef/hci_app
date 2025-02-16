import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: 0,
    username: 'guest',
    password: 'no_password',
  );

  User get() {
    return _user;
  }

  void set(User user) {
    _user = user;
    notifyListeners();
  }

  void clear() {
    set(User(id: 0, username: 'guest', password: 'no_password'));
  }

}
