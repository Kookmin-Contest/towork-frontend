import 'package:flutter/material.dart';
import 'package:gotowork/screens/login_menu.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Login',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        fontFamily: 'SUITE',
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: LogIn(),
    );
  }
}
