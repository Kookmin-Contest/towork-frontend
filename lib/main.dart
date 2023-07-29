import 'package:flutter/material.dart';
import 'package:gotowork/screens/login_menu.dart';
import 'package:gotowork/shared/menu_main.dart';

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
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: LogIn(),
    );
  }
}
