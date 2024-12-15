import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/pages/loading/loading.dart';
import 'package:nom_order/widgets/app_bar/custom_appbar.dart';

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
                            child: Text(AppLocalizations.of(context)!.close, textAlign: TextAlign.center, style: TextStyle(
                              height: 1.2,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeSetting.titleOnColor,
                            )),
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

  void openDialog(BuildContext context, Widget child) {
    showDialog(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) => child,
    );
  }

  Future openModal(BuildContext context, Widget child) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: themeSetting.dialog,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
      ),
      barrierColor: Colors.black26,

      builder: (BuildContext context) => child,
    );
  }

  void confirmDialog(BuildContext context, String warningMessage, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: true,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
              color: themeSetting.dialog,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.are_you_sure,
                  style: TextStyle(
                    color: themeSetting.titleOnBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  warningMessage,
                  style: TextStyle(
                    color: themeSetting.bodyOnBackground,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            color: themeSetting.bodyOnBackground,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    CustomButton(
                      onPressed: () => onConfirm(),
                      borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                      ),
                      backgroundColor: themeSetting.accent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          AppLocalizations.of(context)!.confirm,
                          style: TextStyle(
                            color: themeSetting.titleOnColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black45,
      barrierDismissible: true,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Loading(themeSetting: themeSetting),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.uploading,
              style: TextStyle(
                color: themeSetting.bodyOnColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fullPageDialog(BuildContext context, Widget child, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: themeSetting.background,
        appBar: CustomAppBar(title: title, bottomBorder: false, themeSetting: themeSetting, leadingButton: true),
        body: child,
      );
    }));
  }

  void showScaffoldMessage(BuildContext context, String message, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: themeSetting.secondary,
        content: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 22, color: themeSetting.titleOnColor),
            textAlign: TextAlign.center,
          ),
        ),
        duration: duration,
      ),
    );
  }

}