import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';
import 'package:nom_order/widgets/buttons/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/text_fields/custom_text_field.dart';

class AddCategoryPage extends StatelessWidget {
  final ThemeSetting themeSetting;

  const AddCategoryPage({
    super.key,
    required this.themeSetting,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: width*.2),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            color: themeSetting.dialog,
            borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  AppLocalizations.of(context)!.add_category,
                  style: TextStyle(
                    fontSize: 22,
                    color: themeSetting.titleOnBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.add_category_description,
                  style: TextStyle(
                    fontSize: 16,
                    color: themeSetting.bodyOnBackground,
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  onChanged: (val) {},
                  hintText: AppLocalizations.of(context)!.add_category_hint,
                  autoFocus: true,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                  textInputType: TextInputType.text,
                  borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                  themeSetting: themeSetting,
                ),
                const SizedBox(height: 72),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onPressed: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: TextStyle(
                            fontSize: 18,
                            color: themeSetting.bodyOnBackground,
                          ),
                        ),
                      ),
                    ),
                    SubmitButton(
                      themeSetting: themeSetting,
                      onPressed: () {},
                      fontSize: 18,
                      text: AppLocalizations.of(context)!.add,
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
