import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('로그인'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: (EdgeInsets.only(top: 30)),
            ),
            Center(
              child: Image(
                image: AssetImage('assets/logo.png'),
                width: 140,
                height: 140,
              ),
            ),
            Form(child: Theme(
              data: ThemeData(
                primaryColor: Colors.grey,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0
                    )
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 120.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: '이메일을 입력해주세요',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          )
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: '비밀번호를 입력해주세요',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  color: Colors.grey
                              )
                          )
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonTheme(
                        minWidth: 100.0 ,
                        height: 50.0,
                        child: ElevatedButton(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            onPressed: (){})
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                        width: 200.0,
                        height: 40.0,
                        child: TextButton(
                          child: Text("아이디/비밀번호 찾기",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: (){},
                        )
                    ),
                    SizedBox(
                        width: 80.0,
                        height: 40.0,
                        child: TextButton(
                          child: Text("회원 가입",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: (){},
                        )
                    ),
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}