import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu({super.key});

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 390.0.w,
                  height: 150.0.h,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0.w, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      )),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0.w, 8.0.h, 10.0.w, 8.0.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/logo.png"),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 390.0.w,
                  height: 150.0.h,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0.w, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      )),
                  child: Text('test'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
