import 'package:flutter/material.dart';
import 'package:gotowork/shared/menu_appbar.dart';
import 'package:gotowork/shared/menu_bottom.dart';

//TODO : 메인 메뉴 만들기

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '메인 메뉴',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          fontFamily: 'SUITE',
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RoundAppBar(),
      //TODO : 밑에 각종 기능들 추가
      //TODO : 하단바 메뉴랑 연결
    );
  }
}
