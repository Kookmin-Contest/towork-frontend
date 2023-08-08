import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotowork/main.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350.0,
                      height: 100.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey, width: 2.0),
                      ),
                      child: Stack(
                        children: [
                          // 텍스트
                          Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: '4/21일(금)의 근무시간은\n'),
                                  TextSpan(
                                      text: '21:00 ~ 06:00',
                                      style: TextStyle(fontSize: 20)),
                                  TextSpan(text: '입니다.'),
                                ],
                              ),
                            ),
                          ),
                          // 로그아웃 버튼
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: ElevatedButton(
                              onPressed: () async {
                                await storage.delete(key: 'login');
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                  (route) => false,
                                );
                              },
                              child: Text('임시 로그아웃 버튼'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 350.0,
                  height: 400.0,
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(color: Colors.grey, width: 2.0),
                  ),
                  child: Calendar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
