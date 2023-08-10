import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:provider/provider.dart';

// 끝이 둥근 Appbar 만들어둔겁니다. 필요없으면 지울 예정
class RoundAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double barHeight = 90.h;
  RoundAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h + barHeight);
  @override
  State<RoundAppBar> createState() => _RoundAppBarState();
}

class _RoundAppBarState extends State<RoundAppBar> {
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
          bottom: Radius.circular(10.0.r),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.0.h),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(20.w, 0, 0, 20.h),
          child: Consumer<MemberProvider>(
            builder: (context, MemberProvider memberProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.watch<MemberProvider>().companyname,
                    style: TextStyle(color: Colors.white, fontSize: 16.0.sp),
                  ),
                  Row(children: [
                    Text(
                      '안녕하세요,' +
                          context.watch<MemberProvider>().username +
                          '님!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
