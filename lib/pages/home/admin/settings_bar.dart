import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/order/order_stage.dart';
import '../../../widgets/buttons/subtle_button.dart';

class SettingsBar extends StatefulWidget {
  final ThemeSetting themeSetting;
  final Function(OrderStage) onChanged;
  final VoidCallback onMenuEditButtonPressed;
  final VoidCallback onSettingsButtonPressed;
  const SettingsBar({
    super.key,
    required this.themeSetting,
    required this.onChanged,
    required this.onMenuEditButtonPressed,
    required this.onSettingsButtonPressed,
  });

  @override
  State<SettingsBar> createState() => _SettingsBarState();
}

class _SettingsBarState extends State<SettingsBar> {
  OrderStage? selectedStageFiltering;
  final List<OrderStage?> stages = [
    null,
    OrderStage.received,
    OrderStage.preparing,
    OrderStage.prepared,
    OrderStage.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: widget.themeSetting.primaryColor,
      padding: EdgeInsets.fromLTRB(32, 16 + MediaQuery.paddingOf(context).top, 32, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.filter_by_stage,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.themeSetting.titleOnColor,
                ),
              ),
              const SizedBox(width: 18),
              DropdownButtonHideUnderline(
                child: DropdownButton<OrderStage?> (
                  value: selectedStageFiltering,
                  style: TextStyle(
                    color: widget.themeSetting.accent,
                    fontSize: 18,
                  ),
                  iconEnabledColor: widget.themeSetting.accent,
                  iconSize: 36,
                  alignment: Alignment.centerRight,
                  dropdownColor: widget.themeSetting.primaryColor,
                  onChanged: (OrderStage? newValue) {
                    setState(() => selectedStageFiltering = newValue);
                  },
                  items: stages.map<DropdownMenuItem<OrderStage?>>((OrderStage? value) {
                    if (value == null) {
                      return DropdownMenuItem<OrderStage?>(
                        value: value,
                        child: Text(AppLocalizations.of(context)!.active),
                      );
                    } else {
                      return DropdownMenuItem<OrderStage?>(
                        value: value,
                        child: Text(value.name),
                      );
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SubtleButton(
                themeSetting: widget.themeSetting,
                onPressed: () => widget.onMenuEditButtonPressed(),
                text: AppLocalizations.of(context)!.edit_menu,
              ),
              const SizedBox(width: 12),
              SubtleButton(
                themeSetting: widget.themeSetting,
                onPressed: () => widget.onSettingsButtonPressed(),
                text: AppLocalizations.of(context)!.settings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
