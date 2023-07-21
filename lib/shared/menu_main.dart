import 'package:flutter/material.dart';
import 'package:gotowork/screens/alert_menu.dart';
import 'package:gotowork/screens/community_menu.dart';
import 'package:gotowork/screens/home_menu.dart';
import 'package:gotowork/screens/login_menu.dart';
import 'package:gotowork/screens/mypage_menu.dart';
import 'package:gotowork/screens/register_menu.dart';
import 'package:gotowork/screens/setting_menu.dart';
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

class NavigationRoute {
  final String name;
  final Icon icon;
  final Widget page;
  NavigationRoute({
    required this.name,
    required this.icon,
    required this.page,
  });
}

// 하단 메뉴바 Items들
// 표시할 라벨, 아이콘, 이동할 페이지 순으로 넣어주시면 됩니다
final List<NavigationRoute> _routes = [
  new NavigationRoute(name: "홈", icon: Icon(Icons.home), page: HomeMenu()),
  new NavigationRoute(name: "커뮤니티", icon: Icon(Icons.chat_bubble), page: CommunityMenu()),
  new NavigationRoute(name: "마이페이지", icon: Icon(Icons.perm_identity_rounded), page: MypageMenu()),
  new NavigationRoute(name: "알림", icon: Icon(Icons.add_alert), page: AlertMenu()),
  new NavigationRoute(name: "환경설정", icon: Icon(Icons.settings), page: SettingMenu())
];


class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('메인'),
        backgroundColor: Colors.blueAccent
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _routes.map((route) => route.page).toList(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Row(
                  children: [
                    Icon(Icons.perm_identity_rounded),
                    SizedBox(width: 10.0,),
                    Text('조현진님 반갑습니다!')
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
            ),
            ListTile(
              title: Text('워크스페이스 1'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('워크스페이스 2'),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: _routes.map((route) {
          return BottomNavigationBarItem(icon: route.icon, label: route.name);
        }).toList()
      )
    );
  }

  void _onTap(int index){
    if(_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }


}
