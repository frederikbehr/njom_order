import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';

class CustomIconTextButton extends StatelessWidget {
  final ThemeSetting themeSetting;
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  final EdgeInsets? padding;
  final IconData icon;
  final bool? reverse;
  final bool? addPadding;
  const CustomIconTextButton({
    super.key,
    required this.themeSetting,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.padding,
    required this.icon,
    this.reverse,
    this.addPadding,
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
        backgroundColor: themeSetting.accent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
          child: Row(
            textDirection: reverse == null || reverse == false? TextDirection.ltr : TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 36,
                color: themeSetting.bodyOnColor,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: themeSetting.titleOnColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize ?? 18,
                  height: 1.5
                ),
              ),
              Icon(
                icon,
                size: addPadding != null || addPadding == true? 36 : 1,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
