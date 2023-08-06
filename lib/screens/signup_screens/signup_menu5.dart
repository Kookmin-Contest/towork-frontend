import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as gx;
import 'package:gotowork/providers/controller/loadingController.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:provider/provider.dart';

class SignupMenuFifth extends StatefulWidget {
  const SignupMenuFifth({super.key});

  @override
  State<SignupMenuFifth> createState() => _SignupMenuFifthState();
}

class _SignupMenuFifthState extends State<SignupMenuFifth> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _birthDate = TextEditingController();
  final _isLoadingController = gx.Get.put(IsLoadingController());

  String _base =
      'http://ec2-15-164-222-85.ap-northeast-2.compute.amazonaws.com:8080';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoadingController.isLoading = false;
    });
  }

  _signup() async {
    try {
      var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

      var param = jsonEncode({
        'email': context.read<SignupProvider>().email,
        'password': context.read<SignupProvider>().password,
        'name': context.read<SignupProvider>().name,
        'phoneNumber': context.read<SignupProvider>().phoneNumber,
        'birthDate': context.read<SignupProvider>().birthDate
      });

      print(context.read<SignupProvider>().email);
      print(context.read<SignupProvider>().name);
      print(context.read<SignupProvider>().phoneNumber);
      print(context.read<SignupProvider>().birthDate);
      print('비밀번호 486 : ' + context.read<SignupProvider>().password);
      Response response = await dio.post(_base + '/auth/signup',
          data: param, options: Options(contentType: Headers.jsonContentType));

      print(response.statusCode);
      if (response.statusCode == 201) {
        final msg = "회원가입에 성공하였습니다.";
        Fluttertoast.showToast(msg: msg);
        return true;
      } else {
        final msg = "회원가입에 실패하였습니다.";
        Fluttertoast.showToast(msg: msg);
        return false;
      }
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        final msg = "서버에 문제가 생겨 회원가입에 실패했습니다.";
        Fluttertoast.showToast(msg: msg);
      }
      if (e.response?.statusCode == 400) {
        final msg = "이미 존재하는 아이디입니다.";
        Fluttertoast.showToast(msg: msg);
      } else {
        final msg = "회원가입에 실패하였습니다.";
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: Color(0xFFF9F9F9),
        elevation: 0,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              color: Color(0xFFF9F9F9),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      '테스트 해봐야되가지고 임시로 만들었어요! 달력으로 바꿀거에요! 생일은 올바른 정규식인지 보는거 안만들었어요 ㅠㅠ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '마지막으로 ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '생일',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF60ADDA)),
                        ),
                        Text(
                          '을 알려주세요!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      '생일',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "생일을 입력해주세요.";
                          }
                          return null;
                        },
                        controller: _birthDate,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          focusColor: Color(0xFFFFFFFF),
                          hintText: '생일을 입력하세요.',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFDADADA)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFBABBBA),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFBABBBA),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Text(
                                '5/5',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF60ADDA),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            LinearProgressIndicator(
                              value: 1.0,
                              backgroundColor: Color(0x80BABBBA),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF60ADDA),
                              ),
                              minHeight: 2.0.h,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CircleAvatar(
                              backgroundColor: Color(0xFF60ADDA),
                              radius: 26.sp,
                              child: IconButton(
                                onPressed: () async {
                                  _isLoadingController.isLoading = true;
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignupProvider>().birthDate =
                                        _birthDate.text;
                                    if (await _signup() == true) {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      _isLoadingController.isLoading = false;
                                    }
                                  }
                                  _isLoadingController.isLoading = false;
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Color(0xFFFFFFFF),
                                  size: 32,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
  }
}
