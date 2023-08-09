import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:gotowork/providers/provider/member_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class EmailSender {
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } catch (error) {
      deviceData = {"Error": "Failed to get platform version."};
    }

    return deviceData;
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo info) {
    var release = info.version.release;
    var sdkInt = info.version.sdkInt;
    var manufacturer = info.manufacturer;
    var model = info.model;

    return {
      "OS 버전": "Android $release (SDK $sdkInt)",
      "기기": "$manufacturer $model"
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    var systemName = info.systemName;
    var version = info.systemVersion;
    var machine = info.utsname.machine;

    return {"OS 버전": "$systemName $version", "기기": "$machine"};
  }

  Future<Map<String, dynamic>> _getAppInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return {"오늘의 출근 버전": info.version};
  }

  Map<String, dynamic> _getUserInfo(BuildContext context) {
    return {"사용자 이름": context.read<MemberProvider>().username};
  }

  Future<String> getEmailBody(BuildContext context) async {
    Map<String, dynamic> userInfo = _getUserInfo(context);
    Map<String, dynamic> appInfo = await _getAppInfo();
    Map<String, dynamic> deviceInfo = await _getDeviceInfo();

    String body = "";

    body += "==============\n";
    body += "아래 내용을 함께 보내주시면 큰 도움이 됩니다\n";

    userInfo.forEach((key, value) {
      body += "$key: $value\n";
    });

    appInfo.forEach((key, value) {
      body += "$key: $value\n";
    });

    deviceInfo.forEach((key, value) {
      body += "$key: $value\n";
    });

    body += "==============\n";

    return body;
  }
}
