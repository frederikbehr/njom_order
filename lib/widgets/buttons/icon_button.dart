import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';

class CustomIconButton extends StatelessWidget {
  final ThemeSetting themeSetting;
  final VoidCallback onPressed;
  final double? iconSize;
  final EdgeInsets? padding;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  const CustomIconButton({
    super.key,
    required this.themeSetting,
    required this.onPressed,
    this.iconSize,
    this.padding,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(100),
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: backgroundColor ?? themeSetting.accent,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: iconSize ?? 24,
            color: iconColor ?? themeSetting.bodyOnColor,
          ),
        ),
      ),
    );
  }
}
