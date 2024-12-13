import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nom_order/models/device/device_info.dart';
import 'package:nom_order/models/device/device_info_factory.dart';
import 'package:nom_order/models/device/device_mode.dart';
import 'package:nom_order/models/device/device_type.dart';

void main() async {

  test('DeviceInfo to string and then from string to DeviceInfo', () async {
    int fails = 0;
    List<DeviceInfo> testScenarios = [
      const DeviceInfo(deviceMode: DeviceMode.ordering, tableId: "1", type: DeviceType.tablet),
      const DeviceInfo(deviceMode: DeviceMode.ordering, tableId: "100", type: DeviceType.tablet),
      const DeviceInfo(deviceMode: DeviceMode.admin, tableId: "10F", type: null),
      const DeviceInfo(deviceMode: DeviceMode.admin, tableId: "null", type: DeviceType.phone),
      const DeviceInfo(deviceMode: DeviceMode.admin, tableId: "bord 1", type: DeviceType.phone),
    ];
    for (DeviceInfo deviceInfo in testScenarios) {
      final String deviceInfoString = deviceInfo.toString();
      try {
        DeviceInfo recreatedObject = DeviceInfoFactory.stringToDeviceInfo(deviceInfoString);
        expect(recreatedObject.toString(), deviceInfo.toString());
      } catch(e) {
        debugPrint(e.toString());
        fails++;
      }
    }
    expect(fails, 0);
  });

}