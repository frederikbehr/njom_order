import 'package:flutter/cupertino.dart';
import 'package:nom_order/models/device/device_type.dart';

import 'device_mode.dart';

class DeviceInfo {
  final DeviceMode deviceMode;
  final String tableId;
  final DeviceType? type;
  const DeviceInfo({required this.deviceMode, required this.tableId, required this.type});

  static DeviceType getDeviceType(BuildContext context) {
    if (MediaQuery.of(context).size.shortestSide < 600) return DeviceType.phone;
    return DeviceType.tablet;
  }

  @override
  String toString() => "$deviceMode::$tableId::$type";


}