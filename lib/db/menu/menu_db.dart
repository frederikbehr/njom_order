import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MenuDB {
  final FirebaseFirestore _firebase;
  final String uid;
  late final CollectionReference _items;
  late final DocumentReference _user;
  final String _categoriesDocName = "categories";

  MenuDB(this._firebase, this.uid) {
    _user = _firebase.collection("users").doc(uid);
    _items = _user.collection("items");
  }

  Future addCategory(String category) async {
    await _user.update({
      _categoriesDocName : FieldValue.arrayUnion([category]),
    });
  }

  Future removeCategory(String category) async {
    await _user.update({
      _categoriesDocName : FieldValue.arrayRemove([category])
    });
  }

  Future<List<String>> getCategories() async {
    try {
      final DocumentSnapshot doc = await _user.get();
      return doc.get(_categoriesDocName).cast<String>();
    } catch(e) {
      debugPrint(e.toString());
      return [];
    }
  }

}