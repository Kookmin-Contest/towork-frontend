import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '회원가입 예제',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          fontFamily: 'SUITE',
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _error = false;

  // 일반적인 이메일 로그인 방식
  register(accountName, password, formKey) async {
    try {
      var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

      var param =
          jsonEncode({'email': '$accountName', 'password': '$password'});
      Response response = await dio.post('http://10.0.2.2:8080/auth/signup',
          data: param, options: Options(contentType: Headers.jsonContentType));

      if (response.statusCode == 200) {
        final accesstoken = response.data['accessToken'];
        final refreshtoken = response.data['refreshToken'];

        final msg = "로그인에 성공하였습니다.";
        Fluttertoast.showToast(msg: msg);

        return true;
      }
      final msg = "로그인에 실패하였습니다.";
      Fluttertoast.showToast(msg: msg);
      return false;
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        final msg = "서버에 문제가 생겨 로그인에 실패했습니다";
        Fluttertoast.showToast(msg: msg);
      }
      if (e.response?.statusCode == 400) {
        _error = true;
        formKey.currentState!.validate();
        _error = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: GestureDetector(
        onTap: () {
          //반드시 이거 쓸것
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 200, 30, 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: '이메일',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해주세요.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: '비밀번호',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요.';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //TODO : 회원가입 구현
                    }
                  },
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
