import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';


class RegisterTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final bool autoFocus;
  final VoidCallback onSubmitted;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;
  final ThemeSetting themeSetting;
  final bool obscureText;
  final String? Function(String?) validator;
  final FocusNode? focusNode;
  final int? maxLines;
  final double? horizontalPadding;
  const RegisterTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.autoFocus,
    required this.onSubmitted,
    required this.textInputType,
    required this.themeSetting,
    this.textEditingController,
    required this.obscureText,
    required this.validator,
    required this.focusNode,
    this.maxLines,
    this.horizontalPadding,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 24),
      child: TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
        textInputAction: TextInputAction.go,
        onFieldSubmitted: (val) => onSubmitted(),
        obscureText: obscureText,
        validator: validator,
        cursorColor: themeSetting.primaryColor,
        onChanged: (val) => onChanged(val),
        autocorrect: false,
        enableSuggestions: true,
        maxLines: maxLines ?? 1,
        autofocus: autoFocus,
        keyboardType: textInputType,
        style: TextStyle(color: themeSetting.textTitle, fontSize: 18, height: 1),
        textCapitalization: TextCapitalization.none,
        keyboardAppearance: Brightness.light,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.5),
            borderRadius: BorderRadius.circular(100.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeSetting.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(100.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.3), width: 1.5),
            borderRadius: BorderRadius.circular(100.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(1), width: 1.5),
            borderRadius: BorderRadius.circular(100.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: themeSetting.textTitle.withOpacity(0.2), fontSize: 16, height: 1),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 15, height: 1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        ),
      ),
    );
  }
}
