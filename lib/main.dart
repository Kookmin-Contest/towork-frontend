import 'package:flutter/material.dart';
import 'package:gotowork/screens/login_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      debugShowCheckedModeBanner: false,
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
