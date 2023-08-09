import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class adminChoose extends StatefulWidget {
  const adminChoose({super.key});

  @override
  State<adminChoose> createState() => _adminChooseState();
}

class _adminChooseState extends State<adminChoose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관리자 메뉴'),
        backgroundColor: Color(0xff60adda),
        elevation: 3.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0.r)),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0.r),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Container(
                  width: 120.0.w,
                  height: 120.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0.r),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '직장에 합류하기',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0.sp),
                        ),
                        SizedBox(
                          height: 15.0.h,
                        ),
                        Icon(
                          Icons.input,
                          size: 30.sp,
                        )
                      ],
                    ),
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
