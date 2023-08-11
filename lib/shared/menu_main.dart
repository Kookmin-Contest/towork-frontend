import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotowork/models/memberWorkspace_model.dart';
import 'package:gotowork/models/workspaceInfo_model.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:gotowork/screens/main_screens/alert_menu.dart';
import 'package:gotowork/screens/main_screens/community_menu.dart';
import 'package:gotowork/screens/main_screens/home_menu.dart';
import 'package:gotowork/screens/main_screens/mypage_menu.dart';
import 'package:gotowork/screens/main_screens/setting_menu.dart';
import 'package:gotowork/screens/workspace_screens/gen_workspace_screen1.dart';
import 'package:gotowork/shared/helper/animatedRouter.dart';
import 'package:gotowork/shared/helper/dio_handler.dart';
import 'package:gotowork/shared/menu_appbar.dart';
import 'package:gotowork/shared/menu_roundappbar.dart';
import 'package:gotowork/shared/helper/animatedIndexedStack.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Main extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.42857142857144, 867.4285714285714),
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, ThemeMode currentMode, child) {
            return MaterialApp(
              title: '메인 메뉴',
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
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
      appbar: PlainAppbar(title: '커뮤니티')),
  new NavigationRoute(
      name: "마이페이지",
      icon: Icon(Icons.perm_identity_rounded),
      page: MypageMenu(),
      appbar: PlainAppbar(title: '마이페이지')),
  new NavigationRoute(
      name: "홈",
      icon: Icon(Icons.home),
      page: HomeMenu(),
      appbar: RoundAppBar()),
  new NavigationRoute(
      name: "요청",
      icon: Icon(Icons.document_scanner_outlined),
      page: AlertMenu(),
      appbar: PlainAppbar(title: '요청')),
  new NavigationRoute(
      name: "환경설정",
      icon: Icon(Icons.settings),
      page: SettingMenu(),
      appbar: PlainAppbar(
        title: '환경설정',
      ))
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
    _subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
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
      },
    );

    _getMemberWorkspace();
    // 사용자 정보 받아오기
    Future.delayed(Duration.zero, () {
      _getMemberInformation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  // 사용자 정보 받아오기
  static final _storage = FlutterSecureStorage();
  dynamic userInfo = '';

  static final _base =
      'http://ec2-15-164-222-85.ap-northeast-2.compute.amazonaws.com:8080';

  _getMemberInformation() async {
    dynamic userinfo = await _storage.read(key: 'token');

    if (userinfo != null) {
      String url = _base + '/members/info';
      var dio = await dioHandler(context, url);
      dynamic response = null;
      try {
        response = await dio.get(url);
        context.read<MemberProvider>().username = response.data['name'];
        context.read<MemberProvider>().email = response.data['email'];
        context.read<MemberProvider>().phoneNumber =
            response.data['phoneNumber'];
        context.read<MemberProvider>().createDateTime =
            response.data['createDateTime'];
        context.read<MemberProvider>().memberId = response.data['memberId'];
        context.read<MemberProvider>().birthDate = response.data['birthDate'];
      } on DioError catch (e) {
        print(e);
      }
    }
  }

  // 워크스페이스 목록 받아오기
  static int workspaceCount = 5;
  static var items = ['새엠소옹', '네엑쓰으은', 'CoponEat', 'Kor'];
  static late List<WorkspaceInfo> _workspaceInfo;

  _getMemberWorkspace() async {
    String memberUrl = _base + '/members/workspaces';
    String workspaceUrl = _base + '/workspaces';
    var dio = await dioHandler(context, memberUrl);
    late Response response;
    String param = "";
    try {
      response = await dio.get(memberUrl);

      List<MemberWorkspace> workspaces =
          response.data.map<MemberWorkspace>((parsedJson) {
        return MemberWorkspace.fromJson(parsedJson);
      }).toList();

      workspaceCount = 2 + workspaces.length;

      for (MemberWorkspace memberWorkspace in workspaces) {
        param += memberWorkspace.id.toString();
        param += ",";
      }

      if (workspaces.length != 0) {
        param = param.substring(0, param.length - 1);
      }
    } on DioError catch (e) {
      print(e);
    }

    workspaceUrl += param;
    late Response response2;
    try {
      var dio2 = Dio(BaseOptions(receiveTimeout: 5000, connectTimeout: 5000));
      response2 = await dio2.get(workspaceUrl);

      _workspaceInfo = response2.data.map<WorkspaceInfo>((parsedJson) {
        return WorkspaceInfo.fromJson(parsedJson);
      }).toList();
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _indexedAppBar,
      body: AnimatedIndexedStack(
        index: _currentIndex,
        children: _routes.map((route) => route.page).toList(),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 220.h,
              child: UserAccountsDrawerHeader(
                accountEmail: Text(context.watch<MemberProvider>().email,
                    style: TextStyle(fontSize: 14.sp),
                    overflow: TextOverflow.ellipsis),
                accountName: Text(
                  context.watch<MemberProvider>().username + "님 반갑습니다!",
                  style: TextStyle(fontSize: 14.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/logo.png"),
                  backgroundColor: Colors.white,
                ),
                onDetailsPressed: () {},
                decoration: BoxDecoration(
                  color: const Color(0xff9dcff7),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: workspaceCount,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(15.w, 10.h, 0, 30.h),
                      child: Text(
                        'WorkSpace',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0.sp),
                      ),
                    );
                  } else if (index == 1) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10.0.h),
                      child: ListTile(
                        title: Row(children: [
                          Text(
                            '새 워크스페이스 만들기',
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: 5.0.w,
                          ),
                          Icon(Icons.add_circle)
                        ]),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                              horizontalSlidingRoute(GenWorkSpaceScreen1()));
                        },
                        dense: true,
                        visualDensity: VisualDensity(vertical: 4.0.h),
                      ),
                    );
                  } else {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/logo.png'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(
                        _workspaceInfo[index - 2].name,
                        style: TextStyle(fontSize: 16.0.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      dense: true,
                      visualDensity: VisualDensity(vertical: 4.0.h),
                    );
                  }
                },
              ),
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
