import 'package:flutter/material.dart';
import 'package:gotowork/screens/login_screens/login_menu.dart';
import 'package:gotowork/screens/signup_screens/signup_choose.dart';
import 'package:gotowork/screens/signup_screens/signup_menu.dart';
import 'package:gotowork/shared/menu_main.dart';
import 'package:gotowork/widgets/animatedIndexedStack.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/signup': (BuildContext context) => Register()
      },
      home: LogIn(),
    );
  }
}
