import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/models/theme/theme_setting.dart';

import '../buttons/custom_button.dart';

class DialogTemplates {
  final ThemeSetting themeSetting;

  DialogTemplates({
    required this.themeSetting,
  });

  static final BorderRadius _borderRadius = BorderRadius.circular(24);

  Widget _getTitle(String title) {
    return Text(title, textAlign: TextAlign.center, style: TextStyle(
      height: 1.2,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: themeSetting.titleOnBackground,
    ));
  }

  Widget _getDescription(String title) {
    return Text(title, textAlign: TextAlign.center, style: TextStyle(
      height: 1.2,
      fontSize: 14,
      color: themeSetting.bodyOnBackground,
    ));
  }

  void showErrorDialog(BuildContext context, Exception error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  borderRadius: _borderRadius,
                  color: themeSetting.dialog,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 24),
                        _getTitle(AppLocalizations.of(context)!.error),
                        const SizedBox(height: 24),
                        _getDescription(error.toString().replaceFirst("Exception: ", "")),
                        const SizedBox(height: 24),
                        CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: themeSetting.primaryColor,
                          borderRadius: _borderRadius,
                          shapeBorder: RoundedRectangleBorder(
                            borderRadius: _borderRadius,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                            child: _getTitle(AppLocalizations.of(context)!.close),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showScaffoldMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: themeSetting.dialog,
        content: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 18, color: themeSetting.titleOnBackground, height: 1),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

}