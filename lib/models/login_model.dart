class Login {
  final String _username;
  final String _password;
  final String _accesstoken;
  final String _refreshtoken;

  Login(this._username, this._password, this._accesstoken, this._refreshtoken);

  Login.fromJson(Map<String, dynamic> json)
      : _username = json['username'],
        _password = json['password'],
        _accesstoken = json['accesstoken'],
        _refreshtoken = json['refreshtoken'];

  Map<String, dynamic> toJson() => {
    'username': _username,
    'password': _password,
    'accesstoken': _accesstoken,
    'refreshtoken' : _refreshtoken
  };
}