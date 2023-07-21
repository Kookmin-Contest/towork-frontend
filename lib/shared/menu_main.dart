import 'package:flutter/material.dart';
import 'package:gotowork/screens/home_menu.dart';
import 'package:gotowork/screens/login_menu.dart';
import 'package:gotowork/screens/register_menu.dart';
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

final List<NavigationRoute> _routes = [
  new NavigationRoute(name: "홈", icon: Icon(Icons.abc), page: HomeMenu()),
  new NavigationRoute(name: "커뮤니티", icon: Icon(Icons.abc_outlined), page: Register())
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메인'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _routes.map((route) => route.page).toList(),
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
