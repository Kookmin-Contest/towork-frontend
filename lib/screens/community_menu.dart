import 'package:flutter/material.dart';

class CommunityMenu extends StatefulWidget {
  const CommunityMenu({super.key});

  @override
  State<CommunityMenu> createState() => _CommunityMenuState();
}

class _CommunityMenuState extends State<CommunityMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          //TODO : 커뮤니티 화면 만들기
          child: Text('커뮤니티 넣을 메뉴입니다'),
        ),
      ),
    );
  }
}