import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:gotowork/screens/signup_screens/signup_menu2.dart';
import 'package:gotowork/shared/helper/animatedRouter.dart';
import 'package:provider/provider.dart';

class SignupMenuFirst extends StatefulWidget {
  const SignupMenuFirst({super.key});

  @override
  State<SignupMenuFirst> createState() => _SignupMenuFirstState();
}

class _SignupMenuFirstState extends State<SignupMenuFirst> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  bool _checkEmailForm(String text) {
    //이메일 형식 검사
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(text)) {
      return false;
    }
    return true;
  }

  Future<bool> _checkEmailDuplicate(String text) async {
    //TODO : 이메일 중복 검사 추가
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
                  '오늘의 출근에 오신것을 환영합니다!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '우선 ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '이메일',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF60ADDA)),
                    ),
                    Text(
                      '부터 입력해볼까요?',
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
                Text(
                  '이메일',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _email,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "이메일을 입력해주세요.";
                      } else if (!_checkEmailForm(value)) {
                        return "이메일 형식이 올바르지 않습니다.";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(12),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      focusColor: Color(0xFFFFFFFF),
                      hintText: '이메일을 입력하세요.',
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
                    ),
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
                            '1/5',
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
                          value: 0.2,
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
                          child: Consumer<SignupProvider>(
                            builder: (context, value, child) {
                              return IconButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (await _checkEmailDuplicate(
                                            _email.text) !=
                                        false) {
                                      value.email = _email.text;
                                      Navigator.of(context)
                                          .push(fadeRoute(SignupMenuSecond()));
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color(0xFFFFFFFF),
                                  size: 32,
                                ),
                              );
                            },
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
