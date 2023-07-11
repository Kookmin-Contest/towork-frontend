import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Login',
      home: LogIn(),
    );
  }
}

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
            Padding(padding: (EdgeInsets.only(top: 50)),
            ),
            Center(
              child: Image(
                image: AssetImage('assets/logo.png'),
                width: 170,
                height: 190,
              ),
            ),
            Form(child: Theme(
              data: ThemeData(
                primaryColor: Colors.teal,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                        color: Colors.teal,
                        fontSize: 15.0
                    )
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(40.0, 120.0, 40.0, 120.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: '이메일을 입력해주세요'
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: '비밀번호를 입력해주세요'
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 60.0,
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
                    )
                  ],
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}


