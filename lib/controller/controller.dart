import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nom_order/db/device/device_db.dart';
import 'package:nom_order/db/users/user_db.dart';
import '../authentication/auth_service.dart';
import '../models/device/device_mode.dart';
import '../models/theme/theme_setting.dart';
import '../models/device/device_info.dart';
import '../models/device/device_type.dart';
import '../models/user/user_data.dart';

class Controller {
  DeviceInfo? deviceInfo;
  late UserData userData;
  UserDB? userDB;
  final DeviceDB deviceDB = DeviceDB();
  ThemeSetting themeSetting = ThemeSetting();
  Locale? locale;
  final AuthService authService;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  Controller({required this.authService, required this.locale});

  void updateDeviceInfo(DeviceInfo d) {
    deviceInfo = d;
    deviceDB.saveDeviceInfo(d);
  }

  Future<DeviceInfo?> setDeviceInfo() async {
    final DeviceInfo? savedDeviceInfo = await deviceDB.getDeviceInfo();
    if (savedDeviceInfo != null) deviceInfo = savedDeviceInfo;
    return deviceInfo;
  }

  String? getUID() {
    try {
      return authService.auth.currentUser!.uid;
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void setUserDB() {
    try {
      userDB = UserDB(firebase, getUID()!);
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  Future<UserData?> getUserData() async => await userDB!.getUserData();

  void setUserData(UserData userData) => this.userData = userData;

}