import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gotowork/screens/workspace_screens/new_workspace_screen.dart';
import 'package:gotowork/shared/helper/animatedRouter.dart';
import 'package:gotowork/shared/menu_main.dart';

class JoinWorkspace extends StatefulWidget {
  const JoinWorkspace({super.key});

  @override
  State<JoinWorkspace> createState() => _JoinWorkspaceState();
}

class _JoinWorkspaceState extends State<JoinWorkspace> {
  bool text_visible = false;
  bool button_visible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeAnimation();
    });
  }

  _fadeAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      text_visible = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      button_visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.42857142857144, 867.4285714285714),
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                '회사 선택',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF393939),
                ),
              ),
            ),
            centerTitle: true,
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
                      padding: EdgeInsets.fromLTRB(20.0.w, 10.0.h, 20.0.w, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.h,
                          ),
                          AnimatedOpacity(
                            opacity: text_visible ? 1 : 0,
                            duration: Duration(seconds: 1),
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    '효율적인 직장 관리의 최고의 선택',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  Text(
                                    '오늘의 출근',
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF60ADDA)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              opacity: button_visible ? 1 : 0,
                              duration: Duration(seconds: 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0.r)),
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(8.0.r),
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Main(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0.sp),
                                        child: Container(
                                          width: 120.0.w,
                                          height: 120.0.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0.r),
                                            color: Colors.transparent,
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '직장에 합류하기',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17.0.sp),
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
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0.r)),
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.circular(8.0.r),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            horizontalSlidingRoute(
                                                NewWorkSpaceScreen()));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0.sp),
                                        child: Container(
                                          width: 120.0.w,
                                          height: 120.0.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0.r),
                                            color: Colors.transparent,
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '회사 만들기',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17.0.sp),
                                                ),
                                                SizedBox(
                                                  height: 15.0.h,
                                                ),
                                                Icon(
                                                  Icons.add_business_rounded,
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
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
