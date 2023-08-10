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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        elevation: 3.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h),
          child: Center(
            child: Column(
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
                        width: 240.0.w,
                        height: 80.0.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0.r),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '애널리틱스',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0.sp),
                              ),
                              SizedBox(
                                width: 15.0.w,
                              ),
                              Image(
                                image: AssetImage('assets/graph.png'),
                                width: 100.0.w,
                                height: 100.0.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
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
                          width: 240.0.w,
                          height: 80.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0.r),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '애널리틱스',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0.sp),
                                ),
                                SizedBox(
                                  width: 15.0.w,
                                ),
                                Image(
                                  image: AssetImage('assets/graph.png'),
                                  width: 100.0.w,
                                  height: 100.0.h,
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
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
                          width: 240.0.w,
                          height: 80.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0.r),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '애널리틱스',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0.sp),
                                ),
                                SizedBox(
                                  width: 15.0.w,
                                ),
                                Image(
                                  image: AssetImage('assets/graph.png'),
                                  width: 100.0.w,
                                  height: 100.0.h,
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
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
                          width: 240.0.w,
                          height: 80.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0.r),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '애널리틱스',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0.sp),
                                ),
                                SizedBox(
                                  width: 15.0.w,
                                ),
                                Image(
                                  image: AssetImage('assets/graph.png'),
                                  width: 100.0.w,
                                  height: 100.0.h,
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
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
                          width: 240.0.w,
                          height: 80.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0.r),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '애널리틱스',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0.sp),
                                ),
                                SizedBox(
                                  width: 15.0.w,
                                ),
                                Image(
                                  image: AssetImage('assets/graph.png'),
                                  width: 100.0.w,
                                  height: 100.0.h,
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
