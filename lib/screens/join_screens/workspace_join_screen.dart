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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButtonTheme(
                                    data: ElevatedButtonThemeData(),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Main(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: Text('직장에 합류하기')),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  ElevatedButtonTheme(
                                    data: ElevatedButtonThemeData(),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              horizontalSlidingRoute(
                                                  NewWorkSpaceScreen()));
                                        },
                                        child: Text('직장 만들기~ ㅋㅋ')),
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
