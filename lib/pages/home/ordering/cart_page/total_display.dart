import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/models/theme/theme_setting.dart';

class TotalDisplay extends StatelessWidget {
  final double total;
  final ThemeSetting themeSetting;
  const TotalDisplay({super.key, required this.total, required this.themeSetting});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.total,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: themeSetting.titleOnBackground
            ),
          ),
          Text(
            "DKK $total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: themeSetting.titleOnBackground,
            ),
          ),
        ],
      ),
    );
  }
}
