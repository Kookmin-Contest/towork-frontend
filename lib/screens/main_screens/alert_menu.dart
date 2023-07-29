import 'package:flutter/material.dart';

class AlertMenu extends StatefulWidget {
  const AlertMenu({super.key});

  @override
  State<AlertMenu> createState() => _AlertMenuState();
}

class _AlertMenuState extends State<AlertMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // TODO : 쪽지함 화면 만들기
          child: Text('쪽지함 넣을 메뉴입니다'),
        ),
      ),
    );
  }
}
