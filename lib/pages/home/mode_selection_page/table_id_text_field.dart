import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/text_fields/custom_text_field.dart';

class TableIdTextField extends StatelessWidget {
  final Function(String) onChanged;
  final ThemeSetting themeSetting;
  final String? initialValue;
  const TableIdTextField({super.key, required this.onChanged, required this.themeSetting, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width/3,
      child: CustomTextField(
        onChanged: (val) => onChanged(val),
        hintText: AppLocalizations.of(context)!.table_id_hint,
        autoFocus: false,
        onSubmitted: () => FocusScope.of(context).unfocus(),
        textInputType: TextInputType.text,
        borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
        themeSetting: themeSetting,
        initialValue: initialValue,
      ),
    );
  }
}
