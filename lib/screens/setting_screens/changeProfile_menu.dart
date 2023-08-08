import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:provider/provider.dart';

class changeProfile extends StatefulWidget {
  const changeProfile({super.key});

  @override
  State<changeProfile> createState() => _changeProfileState();
}

class _changeProfileState extends State<changeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 정보 바꾸기 메뉴'),
      ),
      body: Text(context.watch<MemberProvider>().phoneNumber),
    );
  }
}
