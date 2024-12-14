import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nom_order/models/item/item.dart';

class ItemFactory {
  static Item? getItemFromSnapshot(DocumentSnapshot snapshot) {
    try {
      return Item(
        id: snapshot.id,
        title: snapshot.get("title"),
        description: snapshot.get("description"),
        price: snapshot.get("price").toDouble(),
        imageURL: snapshot.get("imageURL"),
        category: snapshot.get("category"),
      );
    } catch(e) {
      debugPrint("$e. Item factory could not make an item");
      return null;
    }
  }
}