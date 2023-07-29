import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotowork/screens/login_screens/login_menu.dart';
import 'package:gotowork/widgets/calendar.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
            children: [
              SizedBox(height: 40.0),
              ElevatedButton(
                  onPressed: () async {
                    await storage.delete(key: 'login');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                      (route) => false,
                    );
                  },
                  child: Text('임시 로그아웃 버튼')),
              Calendar(),
            ],
          )),
        ),
      ),
    );
  }
}
