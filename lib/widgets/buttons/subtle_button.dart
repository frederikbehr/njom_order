import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';

class SubtleButton extends StatelessWidget {
  final ThemeSetting themeSetting;
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  final EdgeInsets? padding;
  final bool? onColor;
  const SubtleButton({
    super.key,
    required this.themeSetting,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.padding,
    this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(100),
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(width: 1, color: themeSetting.secondary),
        ),
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            text,
            style: TextStyle(
              color: onColor == null || onColor == true? themeSetting.titleOnColor : themeSetting.accent,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 16,
              height: 1.5
            ),
          ),
        ),
      ),
    );
  }
}
