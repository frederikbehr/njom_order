import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nom_order/data/theme_setting.dart';

import 'buttons/custom_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final String title;
  final Widget? titleReplacement;
  final bool bottomBorder;
  final double? leadingWidth;
  final bool? leadingButton;
  final ThemeSetting themeSetting;

  const CustomAppBar({
    super.key,
    this.backgroundColor,
    this.actions,
    this.leading,
    this.titleReplacement,
    required this.title,
    required this.bottomBorder,
    this.leadingWidth,
    this.leadingButton,
    required this.themeSetting,

  }) : preferredSize = const Size.fromHeight(60); // default is 56.0

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? themeSetting.primaryColor,
      centerTitle: true,
      elevation: 0.0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: leadingWidth,
      actions: actions,
      leading: leadingButton == true? CustomButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: themeSetting.textBody,
            size: 26,
          ),
        ),
      ) : leading,
      title: titleReplacement ?? Text(
        title,
        style: TextStyle(
          color: themeSetting.textAppBar,
          fontWeight: FontWeight.bold,
          fontSize: 17,
          height: 1,
        ),
      ),
      bottom: !bottomBorder? null : PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: Colors.black26,
          height: 3.0,
        ),
      ),
    );
  }
}
