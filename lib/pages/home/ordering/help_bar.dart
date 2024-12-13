import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/buttons/submit_button.dart';
import 'package:nom_order/widgets/buttons/subtle_button.dart';

class HelpBar extends StatefulWidget {
  final ThemeSetting themeSetting;
  const HelpBar({super.key, required this.themeSetting});

  @override
  State<HelpBar> createState() => _HelpBarState();
}

class _HelpBarState extends State<HelpBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: widget.themeSetting.primaryColor,
      padding: EdgeInsets.fromLTRB(32, 16 + MediaQuery.paddingOf(context).top, 32, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.need_help,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.themeSetting.titleOnColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.call_a_waiter,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.themeSetting.bodyOnColor,
                ),
              ),
            ],
          ),
          SubtleButton(
            themeSetting: widget.themeSetting,
            onPressed: () {},
            text: AppLocalizations.of(context)!.call,
          ),
        ],
      ),
    );
  }
}
