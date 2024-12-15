import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/dimensions.dart';
import '../../../../widgets/buttons/icon_text_button.dart';

class OrderButton extends StatefulWidget {
  final ThemeSetting themeSetting;
  final VoidCallback onPressed;
  const OrderButton({
    super.key,
    required this.themeSetting,
    required this.onPressed,
  });

  @override
  State<OrderButton> createState() => OrderButtonState();
}

class OrderButtonState extends State<OrderButton> {
  int totalItems = 0;

  void update(int items) => setState(() {
    totalItems = items;
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconTextButton(
      themeSetting: widget.themeSetting,
      onPressed: () => widget.onPressed(),
      fontSize: 20,
      backgroundColor: widget.themeSetting.primaryColor,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: width*0.16),
      text: "${AppLocalizations.of(context)!.my_order} ($totalItems)",
      icon: Icons.check_rounded,
      reverse: true,
      addPadding: true,
    );
  }
}
