import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  SharedPreferences? _instance;

  Future initialize() async => _instance = await SharedPreferences.getInstance();

  Future setString(String key, String value) async {
    try {
      _instance ?? await initialize();
      await _instance!.setString(key, value);
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  Future<Object?> get(String key) async {
    try {
      return (_instance ?? await initialize()).get(key);
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> exists(String key) async => (_instance ?? await initialize()).get(key) != null;

  Future deleteEverything() async {
    _instance ?? await initialize();
    final Set<String> allKeys = _instance!.getKeys();
    for (String key in allKeys) {
      await _instance!.remove(key);
    }
  }

  Future removeKey(String key) async => await _instance!.remove(key);

}