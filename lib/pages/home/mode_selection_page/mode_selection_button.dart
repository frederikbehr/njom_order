import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/device/device_mode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';

class ModeSelectionButton extends StatelessWidget {
  final DeviceMode deviceMode;
  final Function(DeviceMode) onPressed;
  final DeviceMode? selectedDeviceMode;
  final ThemeSetting themeSetting;
  const ModeSelectionButton({
    super.key,
    required this.deviceMode,
    required this.onPressed,
    required this.selectedDeviceMode,
    required this.themeSetting,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedDeviceMode == deviceMode;
    return CustomButton(
      maxHeight: 200,
      onPressed: () => onPressed(deviceMode),
      borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
      backgroundColor: isSelected? themeSetting.secondary : themeSetting.shadow,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
      ),
      child: SizedBox(
        width: width / 3,
        child: Column(
          children: [
            const SizedBox(height: 32),
            Icon(
              deviceMode == DeviceMode.ordering? Icons.people_outline_rounded : Icons.soup_kitchen_outlined,
              size: 80,
              color: isSelected? themeSetting.bodyOnBackground : themeSetting.shadow,
            ),
            const SizedBox(height: 12),
            Text(
              deviceMode == DeviceMode.admin? AppLocalizations.of(context)!.staff : AppLocalizations.of(context)!.customers,
              style: TextStyle(
                color: isSelected? themeSetting.bodyOnBackground : themeSetting.bodyOnBackground,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
