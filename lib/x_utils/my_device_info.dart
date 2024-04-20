import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class MyDeviceInfo {
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  String _platform = Platform.isAndroid ? "android" : "ios";

  Future<String> deviceName() async {
    String name = "unknown";
    if (_platform == "android") {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      name = androidInfo.model;
    } else {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      name = iosInfo.utsname.machine;
    }
    return name;
  }

  Future<String> deviceID() async {
    String id = "unknown";
    if (_platform == "android") {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      id = androidInfo.id;
    } else {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor ?? '';
    }
    return id;
  }
}
