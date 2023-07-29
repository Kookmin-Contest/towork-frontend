import 'package:flutter/cupertino.dart';

class Token {
  final String _accesstoken;
  final String _refreshtoken;

  Token(@required this._accesstoken, @required this._refreshtoken);

  Token.fromJson(Map<String, dynamic> json)
      : _accesstoken = json['accesstoken'],
        _refreshtoken = json['refreshtoken'];

  Map<String, dynamic> toJson() =>
      {'accesstoken': _accesstoken, 'refreshtoken': _refreshtoken};
}
