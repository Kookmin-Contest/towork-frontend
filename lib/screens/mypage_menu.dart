import 'package:flutter/material.dart';

class MypageMenu extends StatefulWidget {
  const MypageMenu({super.key});

  @override
  State<MypageMenu> createState() => _MypageMenuState();
}

class _MypageMenuState extends State<MypageMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('마이페이지 넣을 메뉴입니다'),
        ),
      ),
    );
  }
}
