import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/models/login_model.dart';
import 'package:gotowork/models/token_model.dart';
import 'package:gotowork/providers/controller/loadingController.dart';
import 'package:gotowork/screens/join_screens/workspace_join_screen.dart';
import 'package:gotowork/screens/signup_screens/signup_choose.dart';
import 'package:gotowork/screens/webview.dart';
import 'package:gotowork/shared/helper/scaleHelper.dart';
import 'package:gotowork/shared/menu_main.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart' as gx;
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  static String _base =
      'http://ec2-15-164-222-85.ap-northeast-2.compute.amazonaws.com:8080';
  static final _isLoadingController = gx.Get.put(IsLoadingController());
  bool checked = false;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
    //   _base = 'http://10.0.2.2:8080';
    // } else if (Platform.isIOS) {
    //   _base = 'http://127.0.0.1:8080';
    // } else {
    //   _base = "http://localhost:8080";
    // }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  // 자동 로그인 매서드
  _asyncMethod() async {
    userinfo = await storage.read(key: 'login');
    _isLoadingController.isLoading = true;

    if (userinfo != null) {
      dynamic data = jsonDecode(userinfo);
      if (await login(data['email'], data['password'], _formKey) == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Main(),
          ),
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

    _isLoadingController.isLoading = false;
  }

  // 일반적인 이메일 로그인 방식
  Future<bool> login(accountName, password, dynamic formKey) async {
    try {
      var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

      var param =
          jsonEncode({'email': '$accountName', 'password': '$password'});
      String url = _base + '/auth/login';
      print(url);
      Response response = await dio.post(url,
          data: param, options: Options(contentType: Headers.jsonContentType));

      if (response.statusCode == 200) {
        final accesstoken = response.data['accessToken'];
        final refreshtoken = response.data['refreshToken'];

        if (checked == true) {
          var login = await jsonEncode(Login('$accountName', '$password'));
          await storage.write(key: 'login', value: login);
        }

        var token = await jsonEncode(Token(accesstoken, refreshtoken));
        await storage.write(key: 'token', value: token);

        final msg = "로그인에 성공하였습니다.";
        Fluttertoast.showToast(msg: msg);

        return true;
      }
      final msg = "로그인에 실패하였f습니다.";
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
        // final msg = "로그인에 실패하였습니다.";
        final msg = e.toString();
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
    try {
      String url = _base + '/oauth2/social-login/kakao';
      final result = await FlutterWebAuth.authenticate(
        url: url,
        callbackUrlScheme: "gotowork",
      );
      print(result);
      final body = Uri.parse(result).data;
      print(body);
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
    return ScreenUtilInit(
        designSize: Size(411.42857142857144, 867.4285714285714),
        builder: (context, child) {
          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 80.0.h),
                          child: Image(
                            image: AssetImage('assets/logo.png'),
                            width: 180.w,
                            height: 180.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.0.h),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Theme(
                                  data: ThemeData(
                                    primaryColor: Colors.grey,
                                    inputDecorationTheme: InputDecorationTheme(
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0.sp,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          20.0.w, 10.0.h, 20.0.w, 0.0.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          _EmailField(),
                                          SizedBox(
                                            height: 7.0.h,
                                          ),
                                          _PasswordField(),
                                          SizedBox(
                                            height: 20.0.h,
                                          ),
                                          _EmailLoginButton(_formKey),
                                          Container(
                                            width: 400.w,
                                            height: 50.h,
                                            child: Row(children: <Widget>[
                                              Checkbox(
                                                value: checked,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checked = value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                "자동 로그인",
                                                style: TextStyle(
                                                    fontSize: 14.0.sp),
                                              )
                                            ]),
                                          ),
                                          // Text(
                                          //   'or',
                                          //   style: TextStyle(fontSize: 12.0 * w),
                                          // ),
                                          // Container(
                                          //   width: 300.0 * w,
                                          //   height: 35.0 * h,
                                          //   child: SignInButton(
                                          //     Buttons.Facebook,
                                          //     onPressed: () async {
                                          //       goggleSocialLogin();
                                          //     },
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 5.0.h,
                                          ),
                                          Divider(
                                            height: 10.0.h,
                                            color: Colors.grey,
                                            thickness: 0.8.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0.h),
                          child: Container(
                            width: 300.w,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    child: Text(
                                      "아이디/비밀번호 찾기",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      //TODO : 아이디/비밀번호 찾기 연결하기
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebViewTest(),
                                          ));
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "회원 가입",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/signupchoose');
                                    },
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                gx.Obx(
                  () => Offstage(
                    offstage: !_isLoadingController.isLoading,
                    child: Stack(
                      children: const <Widget>[
                        Opacity(
                          opacity: 0.5,
                          child: ModalBarrier(
                            dismissible: false,
                            color: Colors.black,
                          ),
                        ),
                        Center(
                          child: SpinKitFadingCircle(
                            color: const Color(0xff60adda),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _EmailField() {
    return SizedBox(
      width: 400.w,
      height: 76.h,
      child: TextFormField(
        controller: email,
        decoration: InputDecoration(
          hintText: '이메일을 입력해주세요',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFBABBBA),
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFBABBBA),
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
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
      ),
    );
  }

  Widget _PasswordField() {
    return SizedBox(
      width: 400.w,
      height: 76.h,
      child: TextFormField(
        controller: password,
        decoration: InputDecoration(
          hintText: '비밀번호를 입력해주세요',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFBABBBA),
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFBABBBA),
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
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
      ),
    );
  }

  Widget _EmailLoginButton(_formKey) {
    return ButtonTheme(
      minWidth: 10,
      height: 50.0.h,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.email,
              color: Colors.white,
              size: 30.0.w,
            ),
            SizedBox(
              width: 10.0.w,
            ),
            Text(
              '이메일로 로그인 하기',
              style: TextStyle(fontSize: 15.0.sp),
            )
          ],
        ),
        onPressed: () async {
          _isLoadingController.isLoading = true;
          if (_formKey.currentState!.validate()) {
            if (await login(email.text, password.text, _formKey) == true) {
              // 로그인 -> 홈 화면 이동할땐 반드시 removeuntil로
              // 로그인화면 스택에서 제거하고 이동해야됩니다!!
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(),
                ),
                (route) => false,
              );
            } else if (error) {
              _formKey.currentState!.validate();
              error = false;
            }
          }
          _isLoadingController.isLoading = false;
        },
      ),
    );
  }
}
