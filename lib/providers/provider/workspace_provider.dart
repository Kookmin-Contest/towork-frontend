import 'package:flutter/foundation.dart';

class WorkspaceProvider extends ChangeNotifier {
  String _companyName = "";
  String _jobCategory1 = "";
  String _jobCategory2 = "";
  String _representImage = "";
  String _introduction = "";

  String get companyName => _companyName;
  String get jobCategory1 => _jobCategory1;
  String get jobCategory2 => _jobCategory2;
  String get representImage => _representImage;
  String get introduction => _introduction;

  void set companyName(String input_companyName) {
    _companyName = input_companyName;
    notifyListeners();
  }

  void set jobCategory1(String input_jobCategory1) {
    _jobCategory1 = input_jobCategory1;
    notifyListeners();
  }

  void set jobCategory2(String input_jobCategory2) {
    _jobCategory2 = input_jobCategory2;
    notifyListeners();
  }

  void set representImage(String input_representImage) {
    _representImage = input_representImage;
    notifyListeners();
  }

  void set introduction(String input_introduction) {
    _introduction = input_introduction;
    notifyListeners();
  }
}
