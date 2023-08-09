import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gotowork/main.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:gotowork/screens/admin_screens/adminChoose_menu.dart';
import 'package:gotowork/screens/setting_screens/changePassword_menu.dart';
import 'package:gotowork/screens/setting_screens/changeProfile_menu.dart';
import 'package:gotowork/shared/menu_main.dart';
import 'package:gotowork/widgets/emailSender.dart';
import 'package:provider/provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu({super.key});

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  void _sendEmail(BuildContext context) async {
    EmailSender emailSender = new EmailSender();
    String body = await emailSender.getEmailBody(context);

    final Email email = Email(
      body: body,
      subject: '[오늘의 출근 문의]',
      recipients: ['mclub901@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext cxt) {
            return AlertDialog(
              content: Text(
                  "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면 친절하게 답변해드릴겠습니다.\n\nmclub901@gmail.com"),
              actions: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(cxt).pop();
                      },
                      child: Text('확인')),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.0.h),
                  child: Container(
                    width: 390.0.w,
                    height: 150.0.h,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0.w, color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.r),
                        )),
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(10.0.w, 8.0.h, 10.0.w, 8.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/logo.png"),
                                  backgroundColor: Colors.white60,
                                  radius: 50.0.r,
                                ),
                                SizedBox(
                                  width: 10.0.w,
                                ),
                                Container(
                                  width: 150.0,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context
                                              .watch<MemberProvider>()
                                              .username,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0.sp),
                                        ),
                                        SizedBox(
                                          height: 5.0.h,
                                        ),
                                        Text(
                                          context.watch<MemberProvider>().email,
                                          style: TextStyle(fontSize: 14.0.sp),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          context
                                              .watch<MemberProvider>()
                                              .companyname,
                                          style: TextStyle(fontSize: 14.0.sp),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '관리자',
                                          style: TextStyle(fontSize: 14.0.sp),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0.r)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8.0.r),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => adminChoose(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(20.0.sp),
                                  child: Container(
                                    width: 30.0.w,
                                    height: 30.0.h,
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
                                          Icon(
                                            Icons.security,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0.h,
                ),
                Container(
                  width: 390.0.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0.w, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: Text(
                                '계정',
                                style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: null,
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Text(
                                '회원정보 변경',
                                style: TextStyle(fontSize: 14.0.sp),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => changeProfile(),
                                  ),
                                );
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Text(
                                '비밀번호 변경',
                                style: TextStyle(fontSize: 14.0.sp),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => changePassword(),
                                  ),
                                );
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Text(
                                '로그아웃',
                                style: TextStyle(fontSize: 14.0.sp),
                              ),
                              onTap: () async {
                                final _storage = FlutterSecureStorage();
                                await _storage.delete(key: 'login');
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                  (route) => false,
                                );
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Text(
                                '회원 탈퇴',
                                style: TextStyle(fontSize: 14.0.sp),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext cxt) {
                                      return AlertDialog(
                                        content: Text(
                                            "죄송 회원탈퇴 기능 없어서 님 영원히 저희 앱에 존속됨 ㅅㄱ"),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(cxt).pop();
                                                },
                                                child: Text('확인')),
                                          )
                                        ],
                                      );
                                    });
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0.h,
                ),
                Container(
                  width: 390.0.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0.w, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: Text(
                                '앱 정보',
                                style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: null,
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '앱 버전',
                                      style: TextStyle(fontSize: 14.0.sp),
                                    ),
                                    Text('1.0'),
                                  ]),
                              onTap: null,
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Text('고객센터'),
                              onTap: () {
                                _sendEmail(context);
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Text('도움말'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                            ListTile(
                              title: Text('다크 모드'),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext cxt) {
                                      return AlertDialog(
                                        content: Text(
                                            Main.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? '다크 모드로 변경됩니다'
                                                : '라이트 모드로 변경됩니다'),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(cxt).pop();
                                                  Main.themeNotifier.value =
                                                      Main.themeNotifier
                                                                  .value ==
                                                              ThemeMode.light
                                                          ? ThemeMode.dark
                                                          : ThemeMode.light;
                                                },
                                                child: Text('변경')),
                                          )
                                        ],
                                      );
                                    });
                              },
                              dense: true,
                              visualDensity: VisualDensity(vertical: 1.0.h),
                            ),
                          ],
                        ),
                      ],
                    ),
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
