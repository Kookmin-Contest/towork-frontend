import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:gotowork/screens/signup_screens/signup_menu3.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../../shared/helper/animatedRouter.dart';

class SignupMenuSecond extends StatefulWidget {
  const SignupMenuSecond({super.key});

  @override
  State<SignupMenuSecond> createState() => _SignupMenuSecondState();
}

class _SignupMenuSecondState extends State<SignupMenuSecond> {
  bool _locked = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordCheck = TextEditingController();

  bool _checkPassword(String text) {
    //이메일 형식 검사
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
    RegExp regExp = new RegExp(pattern);

    print(text);
    if (!regExp.hasMatch(text)) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: Color(0xFFF9F9F9),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          color: Color(0xFFF9F9F9),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  '다음은 비밀번호를 설정해볼까요?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '사용할 ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '비밀번호',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF60ADDA)),
                    ),
                    Text(
                      '를 입력해주세요!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '비밀번호',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            obscureText: _locked,
                            controller: _password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "비밀번호를 입력해주세요.";
                              } else if (value != _passwordCheck.text) {
                                return "비밀번호가 일치하지 않습니다. 다시 시도해보세요.";
                              } else if (!_checkPassword(value)) {
                                return "최소 8 자, 하나 이상의 문자, 숫자, 특수 문자를 포함해야합니다";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              focusColor: Color(0xFFFFFFFF),
                              hintText: '비밀번호를 입력하세요.',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFDADADA)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBABBBA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBABBBA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: _locked
                                    ? Icon(Icons.lock_outline,
                                        color: Colors.grey)
                                    : Icon(
                                        Icons.lock_open_outlined,
                                        color: Colors.grey,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    _locked = _locked ? false : true;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '비밀번호 확인',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            obscureText: _locked,
                            controller: _passwordCheck,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "비밀번호 확인을 입력해주세요.";
                              } else if (value != _password.text) {
                                return "비밀번호가 일치하지 않습니다. 다시 시도해보세요.";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              focusColor: Color(0xFFFFFFFF),
                              hintText: '비밀번호를 다시 입력하세요.',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFDADADA)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBABBBA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBABBBA),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: _locked
                                    ? Icon(Icons.lock_outline,
                                        color: Colors.grey)
                                    : Icon(
                                        Icons.lock_open_outlined,
                                        color: Colors.grey,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    _locked = _locked ? false : true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            '2/5',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF60ADDA),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearProgressIndicator(
                          value: 0.4,
                          backgroundColor: Color(0x80BABBBA),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF60ADDA),
                          ),
                          minHeight: 2.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xFF60ADDA),
                          radius: 26,
                          child: IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignupProvider>().password =
                                    _password.text;
                                Navigator.of(context)
                                    .push(fadeRoute(SignupMenuThird()));
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFFFFFFF),
                              size: 32,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
