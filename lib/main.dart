import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:gotowork/screens/login_screens/login_menu.dart';
import 'package:gotowork/screens/signup_screens/signup_choose.dart';
import 'package:gotowork/screens/signup_screens/signup_menu.dart';
import 'package:gotowork/screens/signup_screens/signup_menu1.dart';
import 'package:gotowork/screens/signup_screens/signup_menu2.dart';
import 'package:gotowork/shared/menu_main.dart';
import 'package:gotowork/shared/helper/animatedIndexedStack.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupProvider>(
      create: (context) => SignupProvider(),
      child: MaterialApp(
        title: 'Main',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'NotoSansKr',
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/login': (BuildContext context) => LogIn(),
          '/signupchoose': (BuildContext context) => SignupChoose(),
          '/signupfirst': (BuildContext context) => SignupMenuFirst(),
          '/signupsecond': (BuildContext context) => SignupMenuSecond(),
        },
        home: LogIn(),
      ),
    );
  }
}
