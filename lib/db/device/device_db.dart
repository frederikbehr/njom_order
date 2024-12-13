
import 'package:nom_order/models/device/device_info.dart';
import 'package:nom_order/models/device/device_info_factory.dart';

import '../local_db.dart';

class DeviceDB {
  final LocalDB _localDB = LocalDB();
  final String _localDBDeviceLocation = "device";

  Future<DeviceInfo?> getDeviceInfo() async {
    final String? data = await _localDB.get(_localDBDeviceLocation) as String?;
    if (data == null) return null;
    return DeviceInfoFactory.stringToDeviceInfo(data);
  }

  Future removeDeviceInfo() async => _localDB.removeKey(_localDBDeviceLocation);

  Future saveDeviceInfo(DeviceInfo deviceInfo) async {
    await _localDB.setString(_localDBDeviceLocation, deviceInfo.toString());
  }

}