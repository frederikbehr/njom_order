import 'package:flutter/cupertino.dart';
import 'package:nom_order/models/device/device_type.dart';

class DeviceInfo {
  static Device getDeviceType(BuildContext context) {
    if (MediaQuery.of(context).size.shortestSide < 600) return Device.phone;
    return Device.tablet;
  }
}