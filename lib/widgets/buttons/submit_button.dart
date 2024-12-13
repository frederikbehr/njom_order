import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';

class SubmitButton extends StatelessWidget {
  final ThemeSetting themeSetting;
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  final EdgeInsets? padding;
  const SubmitButton({
    super.key,
    required this.themeSetting,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
        ),
        backgroundColor: themeSetting.accent,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Text(
            text,
            style: TextStyle(
              color: themeSetting.titleOnColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 24,
              height: 1.5
            ),
          ),
        ),
      ),
    );
  }
}
