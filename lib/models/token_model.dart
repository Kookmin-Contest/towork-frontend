import 'package:flutter/cupertino.dart';

class Token {
  final String _accesstoken;
  final String _refreshtoken;

  Token(@required this._accesstoken, @required this._refreshtoken);

  Token.fromJson(Map<String, dynamic> json)
      : _accesstoken = json['accesToken'],
        _refreshtoken = json['refreshToken'];

  Map<String, dynamic> toJson() =>
      {'accessToken': _accesstoken, 'refreshToken': _refreshtoken};
}
