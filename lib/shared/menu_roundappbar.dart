import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/providers/member_provider.dart';
import 'package:gotowork/screens/login_screens/login_menu.dart';
import 'package:gotowork/widgets/dio_handler.dart';
import 'package:provider/provider.dart';

// 끝이 둥근 Appbar 만들어둔겁니다. 필요없으면 지울 예정
class RoundAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double barHeight = 90;
  const RoundAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
  @override
  State<RoundAppBar> createState() => _RoundAppBarState();
}

class _RoundAppBarState extends State<RoundAppBar> {
  static final _storage = FlutterSecureStorage();
  static final _base =
      'http://ec2-15-164-222-85.ap-northeast-2.compute.amazonaws.com:8080';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    dynamic userinfo = await _storage.read(key: 'token');

    if (userinfo != null) {
      String url = _base + '/members/info';
      var dio = await dioHandler(context, url);
      dynamic response = null;
      try {
        response = await dio.get(url);
        context.read<MemberProvider>().username = response.data['name'];
        context.read<MemberProvider>().email = response.data['email'];
      } on DioError catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('메인 화면'),
      centerTitle: true,
      backgroundColor: const Color(0xff60adda),
      elevation: 3.0,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add_alert), onPressed: () {})
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.watch<MemberProvider>().companyname,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Row(children: [
                Text(
                  '안녕하세요,' + context.watch<MemberProvider>().username + '님!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _asyncMethod();
                  },
                  child: Text('임시 토큰 재요청 버튼'),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
