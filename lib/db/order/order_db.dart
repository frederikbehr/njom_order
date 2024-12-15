import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nom_order/models/item/item.dart';
import 'package:nom_order/models/order/order.dart';
import 'package:nom_order/models/order/order_stage.dart';

class OrderDB {
  final FirebaseFirestore _firebase;
  final String uid;
  late final CollectionReference _orders;
  late final DocumentReference _user;

  OrderDB(this._firebase, this.uid) {
    _user = _firebase.collection("users").doc(uid);
    _orders = _user.collection("orders");
  }

  Stream<QuerySnapshot> getOrderStreamReference() => _orders.snapshots();

  Stream<QuerySnapshot> getOrdersByStageStreamReference(OrderStage stage) =>
      _orders.where('stage', isEqualTo: stage.toString()).snapshots();

  Future addOrder(MenuOrder order) async {
    await _orders.doc().set({
      'items' : order.getItemsAsString(),
      'tableId' : order.tableId,
      'orderCreated' : DateTime.now(),
      'totalPrice' : order.totalPrice,
      'stage' : order.stage.toString(),
    });
  }

  Future updateStage(OrderStage stage) async {
    await _orders.doc().update({
      'stage' : stage.toString(),
    });
  }

  Future deleteItem(MenuOrder order) async => await _orders.doc(order.id).delete();

}