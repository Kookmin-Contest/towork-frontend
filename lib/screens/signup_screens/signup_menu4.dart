import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
import 'package:gotowork/screens/signup_screens/signup_menu2.dart';
import 'package:gotowork/screens/signup_screens/signup_menu5.dart';
import 'package:provider/provider.dart';

import '../../shared/helper/animatedRouter.dart';

class SignupMenuFourth extends StatefulWidget {
  const SignupMenuFourth({super.key});

  @override
  State<SignupMenuFourth> createState() => _SignupMenuFourthState();
}

class _SignupMenuFourthState extends State<SignupMenuFourth> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();

  bool _checkPhoneNumber(String text) {
    //이메일 형식 검사
    String pattern = r'^[0-9]{3}-[0-9]{4}-[0-9]{4}$';
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
                  '거의 다 왔어요!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '당신의 ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '핸드폰 번호',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF60ADDA)),
                    ),
                    Text(
                      '를 알려주세요!',
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
                  '핸드폰 번호',
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "핸드폰 번호를 입력해주세요.";
                      } else if (!_checkPhoneNumber(value)) {
                        return "올바른 형식의 핸드폰 번호를 입력해주세요";
                      }
                      return null;
                    },
                    controller: _name,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(12),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      focusColor: Color(0xFFFFFFFF),
                      hintText: '핸드폰 번호를 입력하세요.',
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
                            '4/5',
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
                          value: 0.8,
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
                                Navigator.of(context)
                                    .push(fadeRoute(SignupMenuFifth()));
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
