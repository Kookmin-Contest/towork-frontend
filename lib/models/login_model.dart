class Login {
  final String _email;
  final String _password;

  Login(this._email, this._password);

  Login.fromJson(Map<String, dynamic> json)
      : _email = json['email'],
        _password = json['password'];

  Map<String, dynamic> toJson() => {'email': _email, 'password': _password};
}
