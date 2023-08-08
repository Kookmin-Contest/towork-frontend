import 'package:flutter/foundation.dart';

class MemberProvider with ChangeNotifier {
  String _username = "";
  String _companyname = "한국 타이어 공장";
  String _email = "";
  String _phoneNumber = "";
  String _birthDate = "";
  String _createDateTime = "";
  int _memberId = 0;

  String get username => _username;
  String get companyname => _companyname;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get birthDate => _birthDate;
  String get createDateTime => _createDateTime;
  int get memberId => _memberId;

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

  void set phoneNumber(String phoneNumber) {
    this._phoneNumber = phoneNumber;
    notifyListeners();
  }

  void set createDateTime(String createDateTime) {
    this._createDateTime = createDateTime;
    notifyListeners();
  }

  void set birthDate(String birthDate) {
    this._birthDate = birthDate;
    notifyListeners();
  }

  void set memberId(int memberId) {
    this._memberId = memberId;
    notifyListeners();
  }
}
