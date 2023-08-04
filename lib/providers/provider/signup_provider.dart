import 'package:flutter/foundation.dart';

class SignupProvider extends ChangeNotifier {
  String _email = "";
  String _password = "";
  String _name = "";
  String _phoneNumber = "";
  String _birthDate = "";

  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get birthDate => _birthDate;

  void set email(String input_email) {
    _email = input_email;
    notifyListeners();
  }

  void set password(String input_password) {
    _password = input_password;
    notifyListeners();
  }

  void set name(String input_name) {
    _name = input_name;
    notifyListeners();
  }

  void set phoneNumber(String input_phoneNumber) {
    _phoneNumber = input_phoneNumber;
    notifyListeners();
  }

  void set birthDate(String input_birthDate) {
    _birthDate = input_birthDate;
    notifyListeners();
  }
}
