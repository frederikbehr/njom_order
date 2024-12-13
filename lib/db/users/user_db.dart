
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../models/user/user_data.dart';
import '../../models/user/user_factory.dart';
import '../local_db.dart';

class UserDB {
  final FirebaseFirestore _firebase;
  final String uid;
  late final LocalDB _localDB;
  late final String _localDBUserLocation;

  late final CollectionReference _users;
  late final DocumentReference _user;

  UserDB(this._firebase, this.uid) {
    _users = _firebase.collection("users");
    _user = _users.doc(uid);
    _localDB = LocalDB();
    _localDBUserLocation = "user";
  }

  @override
  String toString() => "$_firebase::$uid::$_users::$_user";

  Future<bool> _userDocumentExists() async {
    try {
      DocumentSnapshot documentSnapshot = await _user.get();
      return documentSnapshot.exists;
    } catch(e) {
      return false;
    }
  }

  Future updateUserData(UserData userData) async {
    try {
      await _localDB.setString("user", userData.toString());
      return await _user.update({
        'name' : userData.name,
        'newUser' : false,
      });
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  Future addVariable(String variableName, Object value) async {
    await _user.update({ variableName : value });
  }

  Future<UserData?> getUserDataFromLocalDB() async {
    try {
      if (await _localDB.exists(_localDBUserLocation)) {
        return UserFactory.getUserFromString(await _localDB.get(_localDBUserLocation) as String);
      }
      return null;
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future setUserFromLocalDB(UserData user) async => await _localDB.setString(_localDBUserLocation, user.toString());

  Future<UserData?> fetchUserData() async {
    try {
      final UserData? userFromLocalDB = await getUserDataFromLocalDB();
      if (userFromLocalDB != null) return userFromLocalDB;
      final DocumentSnapshot doc = await _user.get();
      final UserData userData = UserData(
        uid: uid,
        name: doc.get("name"),
        email: doc.get("email"),
      );
      await setUserFromLocalDB(userData);
      return userData;
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UserData?> getUserData() async {
    UserData? userData = await fetchUserData();
    if (userData == null) {
      bool userDocExists = await _userDocumentExists();
      debugPrint("User Doc exists: $userDocExists");
      if (userDocExists) {
        //try retrieve it repeatedly
        final tries = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        await Future.forEach(tries, (attempt) async {
          debugPrint("trying to fetch UserData. $attempt/10");
          await Future.delayed(const Duration(seconds: 1), () async {
            userData = await fetchUserData();
            if (userData != null) {
              return userData;
            } else {
              if (attempt >= 10) {
                return null;
              }
            }
          });
        });
      } else {
        await setUserDataWithUid("Anonymous");
        return null;
      }
    } else {
      return userData;
    }
    return null;
  }

  Future deleteCollection(CollectionReference collectionReference) async {
    final QuerySnapshot snapshot = await collectionReference.get();
    if (snapshot.docs.isNotEmpty) {
      for (DocumentSnapshot doc in snapshot.docs) {
        debugPrint("deleting: ${doc.id}");
        await collectionReference.doc(doc.id).delete();
      }
    }
  }

  Future deleteUserData() async {
    try {
      await _localDB.deleteEverything();
      await _user.delete();
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  Future setUserDataWithUid(String name) async{
    return await _user.set({
      'uid' : uid,
      'name' : name,
      'lastLogin' : DateTime.now(),
      'email' : "email",
      'newUser' : true,
    });
  }

}