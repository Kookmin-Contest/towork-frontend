import 'package:flutter/foundation.dart';

class MemberProvider with ChangeNotifier {
  String _username = "";
  String _companyname = "한국 타이어 공장";
  String _email = "";
  String get username => _username;
  String get companyname => _companyname;
  String get email => _email;

  void set username(String username) {
    this._username = username;
    notifyListeners();
  }

  void set companyname(String companyname) {
    this._companyname = companyname;
    notifyListeners();
  }

  void set email(String email) {
    this._email = email;
    notifyListeners();
  }
}
