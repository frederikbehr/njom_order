import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nom_order/models/item/item.dart';

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

  Stream<QuerySnapshot> getItemStreamReference() => _items.snapshots();

  Stream<QuerySnapshot> getItemsByCategoryStreamReference(String category) =>
      _items.where('category', isEqualTo: category).snapshots();

  Future addCategory(String category) async {
    await _user.update({
      _categoriesDocName : FieldValue.arrayUnion([category]),
    });
  }

  Future addItem(Item item) async {
    await _items.doc().set({
      'title' : item.title,
      'description' : item.description,
      'price' : item.price,
      'category' : item.category,
      'imageURL' : item.imageURL
    });
  }

  Future updateItem(Item item) async {
    await _items.doc().update({
      'title' : item.title,
      'description' : item.description,
      'price' : item.price,
      'category' : item.category,
      'imageURL' : item.imageURL
    });
  }

  Future deleteItem(Item item) async => await _items.doc(item.id).delete();

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