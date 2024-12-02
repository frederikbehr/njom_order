import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../authentication/auth_service.dart';
import '../models/user/user_data.dart';

class RuntimeManager {
  late UserData userData;
  Locale? locale;
  final AuthService authService;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  RuntimeManager({
    required this.authService,
    required this.locale,
  });

  Future setUserData(UserData userData) async => this.userData = userData;

}