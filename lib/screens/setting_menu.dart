import 'package:flutter/material.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu({super.key});

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('환경설정 넣을 메뉴입니다'),
        ),
      ),
    );
  }
}
