import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/device/device_info.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/pages/home/mode_selection_page/mode_selection_button.dart';
import 'package:nom_order/pages/home/mode_selection_page/table_id_text_field.dart';
import 'package:nom_order/widgets/buttons/icon_text_button.dart';
import 'package:nom_order/widgets/buttons/submit_button.dart';
import 'package:nom_order/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../models/device/device_mode.dart';


class ModeSelectionPage extends StatefulWidget {
  final ThemeSetting themeSetting;
  final Function(DeviceInfo deviceInfo) onDeviceInfoChanged;
  const ModeSelectionPage({
    super.key,
    required this.themeSetting,
    required this.onDeviceInfoChanged,
  });

  @override
  State<ModeSelectionPage> createState() => _ModeSelectionPageState();
}

class _ModeSelectionPageState extends State<ModeSelectionPage> {
  DeviceMode? selectedDeviceMode;
  String selectedTableId = "";

  bool validate() {
    if (selectedDeviceMode == DeviceMode.admin) {
      return true;
    } else if (selectedTableId.isNotEmpty) {
      return true;
    }
    return false;
  }

  void submit() {
    if (validate()) {
      widget.onDeviceInfoChanged(
        DeviceInfo(
          deviceMode: selectedDeviceMode!,
          tableId: selectedTableId,
          type: DeviceInfo.getDeviceType(context),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeSetting.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.mode_selection_title,
        bottomBorder: false,
        themeSetting: widget.themeSetting,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: width,
            height: height - 60,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 72),
                  Text(
                    AppLocalizations.of(context)!.select_a_mode,
                    style: TextStyle(
                      color: widget.themeSetting.titleOnBackground,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.mode_selection_description,
                    style: TextStyle(
                      color: widget.themeSetting.bodyOnBackground,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ModeSelectionButton(
                        deviceMode: DeviceMode.ordering,
                        onPressed: (val) => setState(() => selectedDeviceMode = val),
                        themeSetting: widget.themeSetting,
                        selectedDeviceMode: selectedDeviceMode,
                      ),
                      ModeSelectionButton(
                        deviceMode: DeviceMode.admin,
                        onPressed: (val) => setState(() => selectedDeviceMode = val),
                        themeSetting: widget.themeSetting,
                        selectedDeviceMode: selectedDeviceMode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  AnimatedOpacity(
                    opacity: selectedDeviceMode == DeviceMode.ordering? 1 : 0,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 500),
                    child: selectedDeviceMode != DeviceMode.ordering? const SizedBox() : Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.table_id,
                          style: TextStyle(
                            color: widget.themeSetting.bodyOnBackground,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        TableIdTextField(
                          onChanged: (val) => setState(() => selectedTableId = val),
                          themeSetting: widget.themeSetting,
                          initialValue: selectedTableId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * .12,
            child: SizedBox(
              width: width,
              child: Center(
                child: AnimatedOpacity(
                  opacity: validate()? 1 : 0,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconTextButton(
                        themeSetting: widget.themeSetting,
                        onPressed: () => submit(),
                        reverse: true,
                        text: AppLocalizations.of(context)!.finish,
                        icon: Icons.check,
                        addPadding: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
