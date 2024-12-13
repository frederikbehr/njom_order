import 'package:flutter/material.dart';

import '../../models/theme/theme_setting.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final bool autoFocus;
  final ThemeSetting themeSetting;
  final VoidCallback onSubmitted;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final BorderRadius borderRadius;
  final bool? obscureText;
  final String Function(String?)? validator;
  final FocusNode? focusNode;
  final int? maxLines;
  final double? horizontalPadding;
  final Widget? prefixWidget;
  final Color? prefixWidgetColor;
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.autoFocus,
    required this.onSubmitted,
    required this.textInputType,
    required this.borderRadius,
    required this.themeSetting,
    this.controller,
    this.obscureText,
    this.validator,
    this.focusNode,
    this.maxLines,
    this.horizontalPadding,
    this.prefixWidget,
    this.prefixWidgetColor,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        textInputAction: TextInputAction.go,
        onFieldSubmitted: (val) => onSubmitted(),
        obscureText: obscureText ?? false,
        validator: validator,
        cursorColor: themeSetting.secondary,
        onChanged: (val) => onChanged(val),
        autocorrect: false,
        enableSuggestions: true,
        maxLines: maxLines ?? 1,
        autofocus: autoFocus,
        keyboardType: textInputType,
        style: TextStyle(color: themeSetting.titleOnBackground, fontSize: 18, height: 1),
        textCapitalization: TextCapitalization.none,
        keyboardAppearance: Brightness.light,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeSetting.titleOnBackground.withOpacity(0.1), width: 1.5),
            borderRadius: borderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeSetting.primaryColor, width: 1.5),
            borderRadius: borderRadius,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.3), width: 1.5),
            borderRadius: borderRadius,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red..withOpacity(1), width: 1.5),
            borderRadius: borderRadius,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: themeSetting.titleOnBackground.withOpacity(0.38), fontSize: 16, height: 1),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 15, height: 1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          prefixIcon: prefixWidget,
          prefixIconColor: prefixWidgetColor,
        ),
      ),
    );
  }
}
