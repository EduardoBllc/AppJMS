import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{

  late Map<String, String> _actualUser;

  Map<String, String> get actualUser => Map.unmodifiable(_actualUser);

  void setActualUser(String username, String email, String password) {
    _actualUser['username'] = username;
    _actualUser['email'] = email;
    _actualUser['password'] = password;
    notifyListeners();
  }
}