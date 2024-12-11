import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../authentication/auth_service.dart';
import '../data/theme_setting.dart';
import '../models/user/user_data.dart';

class Controller {
  late UserData userData;
  ThemeSetting themeSetting = ThemeSetting();
  Locale? locale;
  final AuthService authService;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  Controller({
    required this.authService,
    required this.locale,
  });

  Future setUserData(UserData userData) async => this.userData = userData;

}