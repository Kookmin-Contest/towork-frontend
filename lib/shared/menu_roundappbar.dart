import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/providers/member_provider.dart';
import 'package:gotowork/screens/login_screens/login_menu.dart';
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _asyncMethod();
    });
  }

  _logout() async {
    await _storage.delete(key: 'login');
    await _storage.delete(key: 'token');

    final msg = "연결이 불안정하여 로그아웃 됩니다";
    Fluttertoast.showToast(msg: msg);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
      (route) => false,
    );
  }

  _reissue() async {
    try {
      //TODO : refresh토큰을 이용한 재발급 모시깽이 로직
      return true;
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return false;
      } else if (e.response?.statusCode == 401) {
        //TODO : token 재발급 실패 로직
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  _asyncMethod() async {
    dynamic userinfo = await _storage.read(key: 'token');

    if (userinfo != null) {
      dynamic data = jsonDecode(userinfo);
      try {
        var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));
        Response response = await dio.get('http://10.0.2.2:8080/members/info',
            options: Options(contentType: Headers.jsonContentType, headers: {
              'Authorization': 'Bearer ' + data['accesstoken'].toString()
            }));

        if (response.statusCode == 200) {
          context.read<MemberProvider>().username = response.data['name'];
          context.read<MemberProvider>().email = response.data['email'];
        }
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          _logout();
        } else if (e.response?.statusCode == 401) {
          if (_reissue() == true) {
            //TODO : refresh토큰을 이용한 재발급 모시깽이 로직
          } else {
            _logout();
          }
        }
      } catch (e) {
        print(e);
        print(data['accesstoken'].toString());
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
              Text(
                '안녕하세요,' + context.watch<MemberProvider>().username + '님!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
