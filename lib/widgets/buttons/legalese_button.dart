import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/dimensions.dart';
import '../../models/theme/theme_setting.dart';
import '../../pages/legalese/legalese.dart';


class LegaleseButton extends StatelessWidget {
  final ThemeSetting themeSetting;
  const LegaleseButton({super.key, required this.themeSetting});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(
            builder: (BuildContext context) => Legalese(themeSetting: themeSetting),
          ));
        },
        child: SizedBox(
          width: width - 24*2,
          height: 70,
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 14, height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                    text: AppLocalizations.of(context)!.by_signing_up1,
                    style: TextStyle(color: themeSetting.textTitle),
                  ),
                  TextSpan(
                    text: " ${AppLocalizations.of(context)!.terms_of_service}",
                    style: TextStyle(
                      color: themeSetting.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " ${AppLocalizations.of(context)!.by_signing_up2} ",
                    style: TextStyle(color: themeSetting.textTitle),
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.privacy_policy,
                    style: TextStyle(
                      color: themeSetting.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
