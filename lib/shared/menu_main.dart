import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/screens/alert_menu.dart';
import 'package:gotowork/screens/community_menu.dart';
import 'package:gotowork/screens/home_menu.dart';
import 'package:gotowork/screens/mypage_menu.dart';
import 'package:gotowork/screens/setting_menu.dart';
import 'dart:async';

import 'package:gotowork/shared/menu_appbar.dart';

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
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MainMenu(),
    );
  }
}

class NavigationRoute {
  final String name;
  final Icon icon;
  final Widget page;
  final dynamic appbar;

  NavigationRoute(
      {required this.name,
      required this.icon,
      required this.page,
      required this.appbar});
}

final test = AppBar(
    title: Text('테스트 앱바'),
    backgroundColor: Colors.blueAccent,
    centerTitle: true);

// 하단 메뉴바 Items들
// 표시할 라벨, 아이콘, 이동할 페이지, 앱바 순으로 넣어주시면 됩니다
final List<NavigationRoute> _routes = [
  new NavigationRoute(
      name: "커뮤니티",
      icon: Icon(Icons.chat_bubble),
      page: CommunityMenu(),
      appbar: test),
  new NavigationRoute(
      name: "마이페이지",
      icon: Icon(Icons.perm_identity_rounded),
      page: MypageMenu(),
      appbar: test),
  new NavigationRoute(
      name: "홈",
      icon: Icon(Icons.home),
      page: HomeMenu(),
      appbar: RoundAppBar()),
  new NavigationRoute(
      name: "요청",
      icon: Icon(Icons.document_scanner_outlined),
      page: AlertMenu(),
      appbar: test),
  new NavigationRoute(
      name: "환경설정",
      icon: Icon(Icons.settings),
      page: SettingMenu(),
      appbar: test)
];

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final PageController _pageController = PageController();
  int _currentIndex = 2;
  late DateTime _lastPressed;
  dynamic indexedAppBar = RoundAppBar();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();
          if (now.difference(_lastPressed) > Duration(seconds: 2)) {
            _lastPressed = now;
            final msg = "뒤로가기 버튼을 한 번 더 누르면 종료됩니다";

            Fluttertoast.showToast(msg: msg);
            return false;
          }
          return true;
        },
        child: Scaffold(
            key: _scaffoldKey,
            appBar: indexedAppBar,
            body: IndexedStack(
              index: _currentIndex,
              children: _routes.map((route) => route.page).toList(),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountEmail: Text("mclub4@kookmin.ac.kr"),
                    accountName: Text("조현진님 반갑습니다!"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.png"),
                      backgroundColor: Colors.white,
                    ),
                    onDetailsPressed: () {},
                    decoration: BoxDecoration(
                      color: const Color(0xff9dcff7),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                    child: Text(
                      'WorkSpace',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                  ListTile(
                    title: Text('워크스페이스 1'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('워크스페이스 2'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor: Colors.blueAccent,
                onTap: _onTap,
                items: _routes.map((route) {
                  return BottomNavigationBarItem(
                      icon: route.icon, label: route.name);
                }).toList())));
  }

  void _onTap(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
      indexedAppBar = _routes[index].appbar;
    });
  }
}
