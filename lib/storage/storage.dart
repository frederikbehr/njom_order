import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future uploadImage(localPath, String uid) async {
    final File file = File(localPath);
    final String fileName = localPath.split("/").last;
    final String storageLocation = "$uid/$fileName";
    final Reference ref = storage.ref().child(storageLocation);
    final TaskSnapshot snapshot = await ref.putFile(file).whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  Future deleteImage(String url) async {
    try {
      await storage.refFromURL(url).delete();
    } catch(e) {
      debugPrint("Not able to delete a file with following URL: $url\nError: $e");
    }
  }

}