import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotowork/screens/workspace_screens/gen_workspace_screen4.dart';
import 'package:gotowork/shared/helper/animatedRouter.dart';

class GenWorkSpaceScreen3 extends StatefulWidget {
  const GenWorkSpaceScreen3({super.key});

  @override
  State<GenWorkSpaceScreen3> createState() => _GenWorkSpaceScreen3State();
}

class _GenWorkSpaceScreen3State extends State<GenWorkSpaceScreen3> {
  String? dropdownValue1;
  String? dropdownValue2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            '새 Workspace',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF393939),
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFFF9F9F9),
        elevation: 0,
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            icon: Icon(
              Icons.close,
              color: Color(0xFF60ADDA),
              size: 20.sp,
            ), // 원하는 아이콘으로 변경 가능
            onPressed: () {
              Navigator.of(context).pop(); // 이전 화면으로 이동하는 동작
            },
          ),
        ],
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
                        '빠르고, 간편하게',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '나의 ',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '직장',
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF60ADDA)),
                          ),
                          Text(
                            '을 만들어보세요.',
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
                        '사진',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF60ADDA),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        width: 83.w,
                        height: 45.h,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
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
                                  '3/4',
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
                                value: 0.75,
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
                                    Navigator.of(context).push(
                                      horizontalSlidingRoute(
                                        GenWorkSpaceScreen4(),
                                      ),
                                    );
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
