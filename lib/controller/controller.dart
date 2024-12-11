import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../authentication/auth_service.dart';
import '../models/theme/theme_setting.dart';
import '../models/device/device_info.dart';
import '../models/device/device_type.dart';
import '../models/user/user_data.dart';

class Controller {
  Device? deviceType;
  late UserData userData;
  ThemeSetting themeSetting = ThemeSetting();
  Locale? locale;
  final AuthService authService;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  Controller({required this.authService, required this.locale});

  void setDeviceType(BuildContext c) => deviceType ??= DeviceInfo.getDeviceType(c);

  bool isTablet() {
    if (deviceType == null) throw Exception("Device type was not given.");
    return deviceType == Device.tablet;
  }

  void setUserData(UserData userData) => this.userData = userData;

}