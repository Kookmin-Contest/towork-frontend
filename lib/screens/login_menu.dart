import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/shared/menu_main.dart';
import 'package:gotowork/screens/register_menu.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
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
  dynamic userinfo = "";
  static final storage = FlutterSecureStorage();

  @override
  void initState(){
      super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _asyncMethod();
      });
  }

  _asyncMethod() async{
      userinfo = await storage.read(key: 'login');

      if(userinfo != null){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainMenu()),
              (route) => false,
        );
      }
  }

   login(accountName, password) async{
      try{
          var dio = Dio();
          var param = jsonEncode({'username': '$accountName', 'password': '$password'});
          Response response = await dio.post(
            'http://10.0.2.2:8080/auth/login',
            data: param,
            options: Options(contentType: Headers.jsonContentType)
          );
          print(response.statusCode);
          if(response.statusCode == 200){
            print(response.statusMessage);
            return true;
          }
          else if(response.statusCode == 403 || response.statusCode == 400){
            final msg = "아이디 또는 비밀번호가 잘못되었습니다.";
            Fluttertoast.showToast(msg: msg);
            return false;
          }
          final msg = "로그인에 실패하였습니다.";
          Fluttertoast.showToast(msg: msg);
          return false;
      }
      on DioError catch(e){

      }
      catch(e){
          print(e);
          final msg = "로그인에 실패하였습니다.";
          Fluttertoast.showToast(msg: msg);
          return false;
      }
  }


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
          title: Text('로그인'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true
      ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child:SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: (EdgeInsets.only(top: 30)),
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
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0
                    )
                ),
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
                      Buttons.Google,
                      onPressed: () async {
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
                          child: Text("아이디/비밀번호 찾기",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: (){
                            //TODO : 아이디/비밀번호 찾기 연결하기
                          },
                        )
                    ),
                    SizedBox(
                        width: 80.0,
                        height: 40.0,
                        child: TextButton(
                          child: Text("회원 가입",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register())
                            );
                          },
                        )
                    ),
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ),
      )
    );
  }

  Widget _EmailField(){
    return TextFormField(
      controller: email,
      decoration: InputDecoration(
          hintText: '이메일을 입력해주세요',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                  color: Colors.grey
              )
          )
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '이메일을 입력해주세요.';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _PasswordField(){
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
          hintText: '비밀번호를 입력해주세요',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                  color: Colors.grey
              )
          )
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
      obscureText: true,
    );
  }

  Widget _EmailLoginButton(_formKey){
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
            onPressed: () async{
              if (_formKey.currentState!.validate()) {
                // TODO : 토큰 확인 후 로그인 하기
                if(await login(email.text, password.text) == true){
                  // 로그인 -> 홈 화면 이동할땐 반드시 removeuntil로
                  // 로그인화면 스택에서 제거하고 이동해야됩니다!!
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainMenu()),
                        (route) => false,
                  );
                }
              }
            })
    );
  }

  void showSnackBar(BuildContext context, Text text) {
    final snackBar = SnackBar(
      content: text,
      backgroundColor: Color.fromARGB(255, 112, 48, 48),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}