import 'package:flutter/material.dart';

import '../models/usermoded.dart';


class UserProvider extends ChangeNotifier {
  UserModel _user =
      UserModel(name: '', email: '', uid: '', password: '', profilePic: '', phone: '');

  UserModel get getUser => _user;
  setUserData(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
