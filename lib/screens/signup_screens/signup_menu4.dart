import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  TextEditingController _phoneNumber = TextEditingController();

  bool _checkPhoneNumber(String text) {
    //핸드폰 형식 검사
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                color: Color(0xFFF9F9F9),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 30.h,
                    horizontal: 30.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100.h,
                      ),
                      Text(
                        '거의 다 왔어요!',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '당신의 ',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '핸드폰 번호',
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF60ADDA)),
                          ),
                          Text(
                            '를 알려주세요!',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      Text(
                        '핸드폰 번호',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 14.sp,
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
                          controller: _phoneNumber,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            focusColor: Color(0xFFFFFFFF),
                            hintText: '핸드폰 번호를 입력하세요.',
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFDADADA)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFBABBBA),
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.r),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFBABBBA),
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: Text(
                                  '3/5',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF60ADDA),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              LinearProgressIndicator(
                                value: 0.8,
                                backgroundColor: Color(0x80BABBBA),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF60ADDA),
                                ),
                                minHeight: 2.0.h,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CircleAvatar(
                                backgroundColor: Color(0xFF60ADDA),
                                radius: 26.sp,
                                child: IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<SignupProvider>()
                                          .phoneNumber = _phoneNumber.text;
                                      Navigator.of(context)
                                          .push(fadeRoute(SignupMenuFifth()));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xFFFFFFFF),
                                    size: 32.sp,
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
          ),
        ],
      ),
    );
  }
}
