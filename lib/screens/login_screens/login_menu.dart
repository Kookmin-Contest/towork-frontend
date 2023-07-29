import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/models/login_model.dart';
import 'package:gotowork/models/token_model.dart';
import 'package:gotowork/screens/signup_screens/signup_choose.dart';
import 'package:gotowork/shared/menu_main.dart';
import 'package:gotowork/screens/signup_screens/signup_menu.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  dynamic userinfo = null;
  bool error = false;
  static final storage = FlutterSecureStorage();
  static final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  // 자동 로그인 매서드
  _asyncMethod() async {
    userinfo = await storage.read(key: 'login');

    if (userinfo != null) {
      dynamic data = jsonDecode(userinfo);
      if (await login(data['email'], data['password'], _formKey) == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainMenu()),
          (route) => false,
        );
      } else {
        final msg = "자동 로그인에 실패했습니다. 다시 로그인해주세요";
        Fluttertoast.showToast(msg: msg);
      }
    } else {
      final msg = "로그인을 해주세요";
      Fluttertoast.showToast(msg: msg);
    }
  }

  // 일반적인 이메일 로그인 방식
  Future<bool> login(accountName, password, dynamic formKey) async {
    try {
      var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

      var param =
          jsonEncode({'email': '$accountName', 'password': '$password'});
      Response response = await dio.post('http://10.0.2.2:8080/auth/login',
          data: param, options: Options(contentType: Headers.jsonContentType));

      if (response.statusCode == 200) {
        final accesstoken = response.data['accessToken'];
        final refreshtoken = response.data['refreshToken'];

        var login = await jsonEncode(Login('$accountName', '$password'));
        await storage.write(key: 'login', value: login);

        var token = await jsonEncode(Token(accesstoken, refreshtoken));
        await storage.write(key: 'token', value: token);

        final msg = "로그인에 성공하였습니다.";
        Fluttertoast.showToast(msg: msg);

        return true;
      }
      final msg = "로그인에 실패하였습니다.";
      Fluttertoast.showToast(msg: msg);
      return false;
    } on DioError catch (e) {
      print(e);
      if (userinfo != null) {
        userinfo = null;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        final msg = "서버에 문제가 생겨 로그인에 실패했습니다";
        Fluttertoast.showToast(msg: msg);
      } else if (e.response?.statusCode == 400) {
        error = true;
        formKey.currentState!.validate();
        error = false;
        final msg = "아이디 또는 비밀번호가 일치하지 않습니다";
        Fluttertoast.showToast(msg: msg);
      } else {
        final msg = "로그인에 실패하였습니다.";
        Fluttertoast.showToast(msg: msg);
      }

      return false;
    } catch (e) {
      print(e);
      final msg = "로그인에 실패하였습니다.";
      Fluttertoast.showToast(msg: msg);
      return false;
    }
  }

  //api로 로그인했을때 접속 코드입니다. 현재 오류가 있어서 안쓰일 수도 있습니다.
  void goggleSocialLogin() async {
    final clientState = Uuid().v4();
    final url = Uri.http('10.0.2.2:8080', '/oauth2/authorization/goggle?', {
      'response_type': 'code',
      'client_id': '이곳은 구글에서 설정한 REST API KEY를 넣어준다.',
      'redirect_uri': 'http://10.0.2.2:8080/auth/social-login',
      'state': clientState,
    });

    try {
      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: "webauthcallback",
      );
      final body = Uri.parse(result).queryParameters;
    } catch (e) {
      print(e);
    }
  }

  //snackbar 표시
  void showSnackBar(BuildContext context, Text text) {
    final snackBar = SnackBar(
      content: text,
      backgroundColor: Color.fromARGB(255, 112, 48, 48),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('로그인 화면'),
            backgroundColor: const Color(0xff60adda),
            elevation: 3.0,
            centerTitle: true),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: (EdgeInsets.only(top: 30)),
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                    width: 140,
                    height: 140,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.grey,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 15.0)),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 120.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _EmailField(),
                          SizedBox(
                            height: 7.0,
                          ),
                          _PasswordField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _EmailLoginButton(_formKey),
                          Text('or'),
                          SignInButton(
                            Buttons.Facebook,
                            onPressed: () async {
                              goggleSocialLogin();
                            },
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            height: 10.0,
                            color: Colors.grey,
                            thickness: 0.8,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                              width: 200.0,
                              height: 40.0,
                              child: TextButton(
                                child: Text(
                                  "아이디/비밀번호 찾기",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                onPressed: () {
                                  //TODO : 아이디/비밀번호 찾기 연결하기
                                },
                              )),
                          SizedBox(
                              width: 80.0,
                              height: 40.0,
                              child: TextButton(
                                child: Text(
                                  "회원 가입",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignupChoose()));
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _EmailField() {
    return TextFormField(
      controller: email,
      decoration: InputDecoration(
        hintText: '이메일을 입력해주세요',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "이메일을 입력해주세요.";
        } else if (error) {
          return "아이디 또는 비밀번호가 잘못되었습니다.";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _PasswordField() {
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
        hintText: '비밀번호를 입력해주세요',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "비밀번호를 입력해주세요.";
        } else if (error) {
          return "아이디 또는 비밀번호가 잘못되었습니다.";
        }
        return null;
      },
      obscureText: true,
    );
  }

  Widget _EmailLoginButton(_formKey) {
    return ButtonTheme(
      minWidth: 10,
      height: 50.0,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.email,
              color: Colors.white,
              size: 30.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text('이메일로 로그인 하기')
          ],
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (await login(email.text, password.text, _formKey) == true) {
              // 로그인 -> 홈 화면 이동할땐 반드시 removeuntil로
              // 로그인화면 스택에서 제거하고 이동해야됩니다!!
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainMenu()),
                (route) => false,
              );
            } else if (error) {
              _formKey.currentState!.validate();
              error = false;
            }
          }
        },
      ),
    );
  }
}
