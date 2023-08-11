import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class checkPassword extends StatefulWidget {
  final dynamic screen;

  const checkPassword({super.key, this.screen});

  @override
  State<checkPassword> createState() => _checkPasswordState();
}

class _checkPasswordState extends State<checkPassword> {
  final _storage = FlutterSecureStorage();
  bool checked = false;

  @override
  void initState() {
    super.initState();
  }

  _asyncMethod() async {
    dynamic userinfo = await _storage.read(key: 'login');

    if (userinfo != null) {
      dynamic data = jsonDecode(userinfo);
      checked = data['localauth'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            '비밀번호 인증',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF393939),
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFFF9F9F9),
        elevation: 0,
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            icon: Icon(
              Icons.close,
              color: Color(0xFF60ADDA),
              size: 20.sp,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 30.h, 0.0, 0.0),
        child: Column(
          children: [
            Text(
              '본인 확인을 위해 비밀번호를 한번 더 입력해주세요',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
