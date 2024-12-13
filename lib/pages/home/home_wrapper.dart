import 'package:flutter/material.dart';
import 'package:nom_order/models/device/device_mode.dart';
import 'package:nom_order/pages/home/admin/admin_page.dart';
import 'package:nom_order/pages/home/mode_selection_page/mode_selection_page.dart';
import 'package:nom_order/pages/home/ordering/ordering_page.dart';
import '../../controller/controller.dart';

class HomeWrapper extends StatefulWidget {
  final Controller controller;
  const HomeWrapper({super.key, required this.controller});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {

  @override
  Widget build(BuildContext context) {
    if (widget.controller.deviceInfo == null) {
      // device mode needs to be chosen
      return ModeSelectionPage(
        themeSetting: widget.controller.themeSetting,
        onDeviceInfoChanged: (val) {
          setState(() => widget.controller.updateDeviceInfo(val));
        },
      );
    } else if (widget.controller.deviceInfo!.deviceMode == DeviceMode.admin) {
      // is for staff/admin
      return AdminPage();
    } else {
      // is for ordering
      return OrderingPage(controller: widget.controller);
    }
  }
}
