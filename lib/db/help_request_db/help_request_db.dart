import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nom_order/models/help_request/help_request.dart';

class HelpRequestDB {
  final FirebaseFirestore _firebase;
  final String uid;
  late final CollectionReference _requests;
  late final DocumentReference _user;

  HelpRequestDB(this._firebase, this.uid) {
    _user = _firebase.collection("users").doc(uid);
    _requests = _user.collection("requests");
  }

  Stream<QuerySnapshot> getHelpRequestStreamReference() => _requests.snapshots();

  Stream<QuerySnapshot> getTableHelpRequestStreamReference(String tableId) => _requests.where("tableId", isEqualTo: tableId).snapshots();

  Future createRequest(String tableId) async {
    await _requests.doc().set({
      'tableId' : tableId,
    });
  }

  Future deleteRequest(HelpRequest request) async => await _requests.doc(request.id).delete();

}