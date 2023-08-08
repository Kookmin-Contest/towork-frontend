import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gotowork/models/token_model.dart';
import 'package:gotowork/screens/login_screens/login_menu.dart';

Future<Dio> dioHandler(BuildContext context, String requestUrl) async {
  var dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));
  final _base =
      'http://ec2-15-164-222-85.ap-northeast-2.compute.amazonaws.com:8080';

  dio.interceptors.clear();

  final _storage = FlutterSecureStorage();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final dynamic accessToken = await _storage.read(key: "token");
        dynamic data = jsonDecode(accessToken);
        options.headers['Authorization'] =
            'Bearer ' + data['accessToken'].toString();
        return handler.next(options);
      },
      onError: (e, handler) async {
        print(e);
        print(handler);
        if (e.response?.statusCode == 401) {
          final dynamic refreshToken = await _storage.read(key: "token");
          dynamic data = jsonDecode(refreshToken);

          var refreshDio =
              Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

          refreshDio.interceptors.clear();

          refreshDio.interceptors.add(
            InterceptorsWrapper(
              onError: (e, handler) async {
                if (e.type == DioErrorType.connectTimeout ||
                    e.type == DioErrorType.receiveTimeout) {
                  await _storage.deleteAll();
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext cxt) {
                        return AlertDialog(
                          content: Text('세션이 만료되어 로그아웃 됩니다'),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(cxt).pop();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogIn()),
                                      (route) => false,
                                    );
                                  },
                                  child: Text('확인')),
                            )
                          ],
                        );
                      });
                } else if (e.response?.statusCode == 401) {
                  await _storage.deleteAll();
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext cxt) {
                        return AlertDialog(
                          content: Text('세션이 만료되어 로그아웃 됩니다'),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(cxt).pop();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogIn()),
                                      (route) => false,
                                    );
                                  },
                                  child: Text('확인')),
                            )
                          ],
                        );
                      });
                }

                return handler.next(e);
              },
            ),
          );

          var param = jsonEncode({'refreshToken': data['refreshToken']});

          Response response = await refreshDio.post(
            _base + '/auth/reissue',
            data: param,
            options: Options(contentType: Headers.jsonContentType),
          );

          final accesstoken = response.data['accessToken'].toString();
          final refreshtoken = response.data['refreshToken'].toString();

          print(accesstoken);
          print(refreshtoken);

          var token = await jsonEncode(Token(accesstoken, refreshtoken));
          await _storage.write(key: 'token', value: token);

          final newResponse = await dio.get(requestUrl,
              options: Options(contentType: Headers.jsonContentType, headers: {
                'Authorization': 'Bearer ' + data['accesstoken'].toString()
              }));

          return handler.resolve(newResponse);
        }

        return handler.next(e);
      },
    ),
  );

  return dio;
}
