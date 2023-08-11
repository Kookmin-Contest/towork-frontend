import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:provider/provider.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 바꾸기 메뉴'),
      ),
      body: Text('test'),
    );
  }
}
