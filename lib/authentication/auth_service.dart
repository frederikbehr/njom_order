import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nom_order/authentication/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create user object based on FirebaseUser/User
  UserUid _userFromFirebaseUser(User user) => UserUid(user: user.uid);

  //auth change user stream for login
  Stream<UserUid> get user =>
      auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!));

  Future setUserData(String email, String name, String uid) async {
    return await _firestore.collection("userData").doc(uid).set({
      'restaurantName': "Not set",
    });
  }

  Future<bool> uidExist(String uid) async {
    try {
      final DocumentSnapshot documentSnapshot = await _firestore.collection("userData").doc(uid).get();
      return documentSnapshot.exists;
    } catch(e) {
      return false;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password, BuildContext context, String name) async{
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      await setUserData(email, name, user.uid);
      await user.sendEmailVerification();
      return _userFromFirebaseUser(user);
    } catch(e) {
      debugPrint(e.toString());
      throw Exception(AppLocalizations.of(context)!.password_not_match);
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password, BuildContext context) async{
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch(e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String? checkAuthentication(BuildContext context) => auth.currentUser?.uid;

  Future forgotPassword(String email) async => await auth.sendPasswordResetEmail(email: email);

}

