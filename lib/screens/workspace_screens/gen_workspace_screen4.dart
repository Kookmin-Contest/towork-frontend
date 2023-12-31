import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/providers/controller/loadingController.dart';
import 'package:gotowork/providers/provider/workspace_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart' as gx;

class GenWorkSpaceScreen4 extends StatefulWidget {
  const GenWorkSpaceScreen4({super.key});

  @override
  State<GenWorkSpaceScreen4> createState() => _GenWorkSpaceScreen4State();
}

class _GenWorkSpaceScreen4State extends State<GenWorkSpaceScreen4> {
  TextEditingController _introduction = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _isLoadingController = gx.Get.put(IsLoadingController());

  String _base =
      'http://ec2-15-164-222-85.ap-northeast-2.compute.amazonaws.com:8080';

  _createWorkspace() async {
    try {
      var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

      var param = jsonEncode({
        'companyName': context.read<WorkspaceProvider>().companyName,
        'jobCategory1': context.read<WorkspaceProvider>().jobCategory1,
        'jobCategory2': context.read<WorkspaceProvider>().jobCategory2,
        'representImage': context.read<WorkspaceProvider>().representImage,
        'introduction': context.read<WorkspaceProvider>().introduction
      });

      Response response = await dio.post(_base + '/workspace/generate',
          data: param, options: Options(contentType: Headers.jsonContentType));

      print(response.statusCode);
      if (response.statusCode == 201) {
        final msg = "성공적으로 생성되었습니다.";
        Fluttertoast.showToast(msg: msg);
        return true;
      } else {
        final msg = "생성에 실패하였습니다.";
        Fluttertoast.showToast(msg: msg);
        return false;
      }
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        final msg = "서버에 문제가 생겨 회원가입에 실패했습니다.";
        Fluttertoast.showToast(msg: msg);
      }
      return false;
    } catch (e) {
      print(e);
      final msg = "오류.";
      Fluttertoast.showToast(msg: msg);
      return false;
    }
  }

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
            child: Stack(
              children: [
                GestureDetector(
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
                            '마지막이에요!',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '당신의 직장을 ',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '소개',
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF60ADDA)),
                              ),
                              Text(
                                '해주세요.',
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
                            '소개',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: 400.w,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _introduction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '소개를 작성해주세요.';
                                  }
                                  return null;
                                },
                                minLines: 8,
                                maxLength: 250,
                                maxLines: null,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      12.w, 12.h, 12.w, 12.h),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  focusColor: Color(0xFFFFFFFF),
                                  hintText: '소개는 250자 내로 작성해주세요.',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFDADADA),
                                  ),
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
                                      '4/4',
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
                                    value: 1,
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
                                      onPressed: () async {
                                        _isLoadingController.isLoading = true;
                                        if (_formKey.currentState!.validate()) {
                                          context
                                                  .read<WorkspaceProvider>()
                                                  .introduction =
                                              _introduction.text;
                                        }

                                        if (await _createWorkspace() == true) {
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                          _isLoadingController.isLoading =
                                              false;
                                        }
                                        _isLoadingController.isLoading = false;
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
                gx.Obx(
                  () => Offstage(
                    offstage: !_isLoadingController.isLoading,
                    child: Stack(
                      children: const <Widget>[
                        Opacity(
                          opacity: 0.5,
                          child: ModalBarrier(
                            dismissible: false,
                            color: Colors.black,
                          ),
                        ),
                        Center(
                          child: SpinKitFadingCircle(
                            color: const Color(0xff60adda),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
