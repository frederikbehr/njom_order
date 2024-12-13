import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget child;
  final ThemeSetting themeSetting;
  const SettingsItem({super.key, required this.title, required this.child, required this.themeSetting});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            color: themeSetting.titleOnBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        child,
      ],
    );
  }
}
