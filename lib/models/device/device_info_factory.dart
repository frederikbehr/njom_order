import 'package:nom_order/models/device/device_info.dart';
import 'package:nom_order/models/device/device_type.dart';

import 'device_mode.dart';

class DeviceInfoFactory {
  static DeviceInfo stringToDeviceInfo(String value) {
    final List<String> parts = value.split("::");
    return DeviceInfo(
      deviceMode: DeviceMode.values.firstWhere((e) => e.toString() == parts[0]),
      tableId: parts[1],
      type: parts[2] == "null"? null : DeviceType.values.firstWhere((e) => e.toString() == parts[2]),
    );
  }
}