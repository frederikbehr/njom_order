import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/theme/theme_setting.dart';


enum SignInOption {
  google, apple, email
}

class SignInOptionButton extends StatelessWidget {
  final SignInOption signInOption;
  final VoidCallback onPressed;
  final bool? buttonIsLoading;
  final ThemeSetting themeSetting;
  final double? horizontalPadding;
  const SignInOptionButton({
    super.key,
    required this.signInOption,
    required this.onPressed,
    this.buttonIsLoading,
    required this.themeSetting,
    this.horizontalPadding,
  });

  Color getAccentColor() {
    switch(signInOption) {
      case SignInOption.email: return themeSetting.accent;
      case SignInOption.apple: return Colors.black;
      case SignInOption.google: return const Color(0xffe34033);
    }
  }

  String getButtonText(BuildContext context) {
    switch(signInOption) {
      case SignInOption.email: return AppLocalizations.of(context)!.email;
      case SignInOption.apple: return "Apple";
      case SignInOption.google: return "Google";
    }
  }

  bool isFilled() {
    if (signInOption == SignInOption.email) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(100);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding?? 24),
      child: Material(
        color: isFilled()? themeSetting.dialog : themeSetting.background,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: getAccentColor(), width: 2),
        ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
            HapticFeedback.lightImpact();
            onPressed();
          },
          child: SizedBox(
            height: 56,
            child: buttonIsLoading != null && buttonIsLoading == true? SpinKitRing(
              color: themeSetting.titleOnBackground,
              size: 30,
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFilled()? const SizedBox() : Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12.0),
                  child: FaIcon(
                    signInOption == SignInOption.google? FontAwesomeIcons.google : FontAwesomeIcons.apple,
                    color: getAccentColor(),
                    size: 22,
                  ),
                ),
                Text(
                  !isFilled()? AppLocalizations.of(context)!.sign_in_with_x(getButtonText(context)) : AppLocalizations.of(context)!.continue_with_email,
                  style: TextStyle(
                    color: themeSetting.titleOnBackground,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
