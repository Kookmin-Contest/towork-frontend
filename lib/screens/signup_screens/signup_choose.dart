import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:gotowork/screens/signup_screens/signup_menu.dart';
import 'package:gotowork/screens/signup_screens/signup_menu1.dart';
import 'package:gotowork/shared/helper/animatedRouter.dart';
import 'package:provider/provider.dart';

class SignupChoose extends StatelessWidget {
  const SignupChoose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('회원 가입'),
          backgroundColor: const Color(0xff60adda),
          elevation: 3.0,
          centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/logo.png'),
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                '오늘의 근무에 오신 것을\n 환영합니다!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 300.0,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('이메일로 가입하기')
                    ],
                  ),
                  onPressed: () async {
                    Navigator.of(context)
                        .push(horizontalSlidingRoute(SignupMenuFirst()));
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                indent: 25.0,
                endIndent: 25.0,
                thickness: 1.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text('소셜 회원가입'),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Ink.image(
                    image: AssetImage('assets/kakaotalk_btn.png'),
                    width: 60,
                    height: 60,
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                  Ink.image(
                    image: AssetImage('assets/goggle_btm.png'),
                    width: 60,
                    height: 60,
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                  Ink.image(
                    image: AssetImage('assets/kakaotalk_btn.png'),
                    width: 60,
                    height: 60,
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
