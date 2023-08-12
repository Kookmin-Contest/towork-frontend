import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotowork/providers/provider/signup_provider.dart';
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
  TextEditingController _firstPhoneNumber = TextEditingController(text: '010');
  TextEditingController _middlePhoneNumber = TextEditingController();
  TextEditingController _lastPhoneNumber = TextEditingController();

  bool _checkPhoneNumber(String first, String middle, String last) {
    if (first != '010' || middle.length != 4 || last.length != 4) {
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
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _firstPhoneNumber,
                                enabled: false,
                              ),
                            ),
                            Text('-'),
                            Expanded(
                              child: TextFormField(
                                controller: _middlePhoneNumber,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                              ),
                            ),
                            Text('-'),
                            Expanded(
                              child: TextFormField(
                                controller: _lastPhoneNumber,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                validator: (value) {
                                  if (!_checkPhoneNumber(
                                      _firstPhoneNumber.text,
                                      _middlePhoneNumber.text,
                                      _lastPhoneNumber.text)) {
                                    return "올바른 형식의 핸드폰 번호를 입력해주세요";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
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
                                      String fullNumber =
                                          _firstPhoneNumber.text +
                                              '-' +
                                              _middlePhoneNumber.text +
                                              '-' +
                                              _lastPhoneNumber.text;
                                      context
                                          .read<SignupProvider>()
                                          .phoneNumber = fullNumber;
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
