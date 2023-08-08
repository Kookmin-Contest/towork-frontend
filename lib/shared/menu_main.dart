import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:gotowork/screens/main_screens/alert_menu.dart';
import 'package:gotowork/screens/main_screens/community_menu.dart';
import 'package:gotowork/screens/main_screens/home_menu.dart';
import 'package:gotowork/screens/main_screens/mypage_menu.dart';
import 'package:gotowork/screens/main_screens/setting_menu.dart';
import 'package:gotowork/screens/workspace_screens/gen_workspace_screen1.dart';
import 'package:gotowork/shared/helper/animatedRouter.dart';
import 'package:gotowork/shared/menu_appbar.dart';
import 'package:gotowork/shared/menu_roundappbar.dart';
import 'package:gotowork/shared/helper/animatedIndexedStack.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.42857142857144, 867.4285714285714),
      builder: (context, child) {
        return MaterialApp(
          title: '메인 메뉴',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
              fontFamily: 'NotoSansKr',
              visualDensity: VisualDensity.adaptivePlatformDensity),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },
          home: MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => MemberProvider()),
          ], child: MainMenu()),
        );
      },
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

// 하단 메뉴바 Items들
// 표시할 라벨, 아이콘, 이동할 페이지, 앱바 순으로 넣어주시면 됩니다
final List<NavigationRoute> _routes = [
  new NavigationRoute(
      name: "커뮤니티",
      icon: Icon(Icons.chat_bubble),
      page: CommunityMenu(),
      appbar: PlainAppbar()),
  new NavigationRoute(
      name: "마이페이지",
      icon: Icon(Icons.perm_identity_rounded),
      page: MypageMenu(),
      appbar: PlainAppbar()),
  new NavigationRoute(
      name: "홈",
      icon: Icon(Icons.home),
      page: HomeMenu(),
      appbar: RoundAppBar()),
  new NavigationRoute(
      name: "요청",
      icon: Icon(Icons.document_scanner_outlined),
      page: AlertMenu(),
      appbar: PlainAppbar()),
  new NavigationRoute(
      name: "환경설정",
      icon: Icon(Icons.settings),
      page: SettingMenu(),
      appbar: PlainAppbar())
];

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  // 뒤로가기 버튼 관련 변수
  late DateTime _lastPressed;

  // IndexedStack 현재 상태 관련 변수
  int _currentIndex = 2;
  dynamic _indexedAppBar = RoundAppBar();

  // 인터넷 연결 확인 관련 변수들
  var _subscription;
  bool _hasConnection = false;
  bool _onetime = false;
  final snackbar = SnackBar(
    content: const Text('인터넷 연결이 불안정합니다'),
    action: SnackBarAction(label: '확인', onPressed: () {}),
  );

  @override
  void initState() {
    super.initState();

    // 인터넷 연결 확인
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        _hasConnection = false;
        await Future.delayed(Duration(seconds: 1));
        if (_hasConnection == false && _onetime == false) {
          _onetime = true;
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        _hasConnection = true;
        _onetime = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width.toString() +
        ', ' +
        MediaQuery.of(context).size.height.toString());
    return Scaffold(
      key: _scaffoldKey,
      appBar: _indexedAppBar,
      body: AnimatedIndexedStack(
        index: _currentIndex,
        children: _routes.map((route) => route.page).toList(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(context.watch<MemberProvider>().email),
              accountName:
                  Text(context.watch<MemberProvider>().username + "님 반갑습니다!"),
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
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 0, 10.h),
              child: Text(
                'WorkSpace',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0.sp),
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
            ),
            ListTile(
              title: Text(
                '새 워크스페이스 만들기',
                style: TextStyle(),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(horizontalSlidingRoute(GenWorkSpaceScreen1()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70.0.h,
        child: BottomNavigationBar(
          iconSize: 25.0.sp,
          selectedFontSize: 12.0.sp,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: _onTap,
          items: _routes.map((route) {
            return BottomNavigationBarItem(icon: route.icon, label: route.name);
          }).toList(),
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
      _indexedAppBar = _routes[index].appbar;
    });
  }
}
