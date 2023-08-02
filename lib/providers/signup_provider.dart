import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String _email = "";
  String _password = "";
  String _name = "";
  String _phoneNumber = "";
  String _birthDate = "";

  void set email(String email) {
    this._email = email;
    notifyListeners();
  }

  void set password(String password) {
    this._password = password;
    notifyListeners();
  }

  void set name(String name) {
    this._name = name;
    notifyListeners();
  }

  void set phoneNumber(String phoneNumber) {
    this._phoneNumber = phoneNumber;
    notifyListeners();
  }

  void set birthDate(String birthDate) {
    this._birthDate = birthDate;
    notifyListeners();
  }
}
