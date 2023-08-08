import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as gx;
import 'package:gotowork/providers/controller/loadingController.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:gotowork/screens/signup_screens/signup_menu2.dart';
import 'package:gotowork/shared/helper/animatedRouter.dart';
import 'package:provider/provider.dart';

class SignupMenuFirst extends StatefulWidget {
  const SignupMenuFirst({super.key});

  @override
  State<SignupMenuFirst> createState() => _SignupMenuFirstState();
}

class _SignupMenuFirstState extends State<SignupMenuFirst> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  final _isLoadingController = gx.Get.put(IsLoadingController());
  bool duplicate = false;
  String _base =
      'http://ec2-15-164-222-85.ap-northeast-2.compute.amazonaws.com:8080';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoadingController.isLoading = false;
    });
  }

  bool _checkEmailForm(String text) {
    //이메일 형식 검사
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(text)) {
      return false;
    }
    return true;
  }

  Future<bool> _checkEmailDuplicate(String? text, GlobalKey _formkey) async {
    try {
      var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

      var param = jsonEncode({
        'email': text,
      });

      Response response = await dio.post(_base + '/auth/duplicate-email',
          data: param, options: Options(contentType: Headers.jsonContentType));

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        final msg = "서버에 문제가 생겨 중복 확인에 실패했습니다.";
        Fluttertoast.showToast(msg: msg);
      } else if (e.response?.statusCode != 200) {
        duplicate = true;
        _formKey.currentState!.validate();
        duplicate = false;
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
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Container(
                    color: Color(0xFFF9F9F9),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30.h,
                        horizontal: 30.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100.h,
                          ),
                          Text(
                            '오늘의 출근에 오신것을 환영합니다!',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '우선 ',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '이메일',
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF60ADDA)),
                              ),
                              Text(
                                '부터 입력해볼까요?',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          Text(
                            '이메일',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _email,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "이메일을 입력해주세요.";
                                } else if (!_checkEmailForm(value)) {
                                  return "이메일 형식이 올바르지 않습니다.";
                                } else if (duplicate) {
                                  return "이미 존재하는 아이디입니다.";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                focusColor: Color(0xFFFFFFFF),
                                hintText: '이메일을 입력하세요.',
                                hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFDADADA)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFBABBBA),
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.r),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFBABBBA),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.r),
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
                                      '1/5',
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
                                    value: 0.2,
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
                                    child: Consumer<SignupProvider>(
                                      builder: (context, value, child) {
                                        return IconButton(
                                          onPressed: () async {
                                            _isLoadingController.isLoading =
                                                true;
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (await _checkEmailDuplicate(
                                                      _email.text, _formKey) !=
                                                  false) {
                                                value.email = _email.text;
                                                Navigator.of(context).push(
                                                    fadeRoute(
                                                        SignupMenuSecond()));
                                                _isLoadingController.isLoading =
                                                    false;
                                              }
                                            }
                                            _isLoadingController.isLoading =
                                                false;
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Color(0xFFFFFFFF),
                                            size: 32.sp,
                                          ),
                                        );
                                      },
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
              ),
            ],
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
