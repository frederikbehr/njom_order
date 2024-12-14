import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';
import 'package:nom_order/widgets/buttons/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/form_section.dart';
import 'package:nom_order/widgets/text_fields/custom_text_field.dart';

class AddItemPage extends StatelessWidget {
  final ThemeSetting themeSetting;
  final VoidCallback onAdded;
  const AddItemPage({
    super.key,
    required this.themeSetting,
    required this.onAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 72),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: themeSetting.dialog,
        borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
      ),
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              FormSection(
                title: AppLocalizations.of(context)!.add_item_description,
                themeSetting: themeSetting,
                child: CustomTextField(
                  onChanged: (val) {},
                  hintText: AppLocalizations.of(context)!.title_description,
                  autoFocus: true,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                  textInputType: TextInputType.text,
                  borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                  themeSetting: themeSetting,
                ),
              ),
              FormSection(
                title: AppLocalizations.of(context)!.item_description,
                themeSetting: themeSetting,
                child: CustomTextField(
                  onChanged: (val) {},
                  hintText: AppLocalizations.of(context)!.item_description_example,
                  autoFocus: true,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                  textInputType: TextInputType.text,
                  borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                  themeSetting: themeSetting,
                ),
              ),
              FormSection(
                title: AppLocalizations.of(context)!.price,
                description: AppLocalizations.of(context)!.price_description,
                themeSetting: themeSetting,
                child: CustomTextField(
                  onChanged: (val) {},
                  hintText: AppLocalizations.of(context)!.price_example,
                  autoFocus: true,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                  textInputType: TextInputType.number,
                  borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                  themeSetting: themeSetting,
                ),
              ),
              FormSection(
                title: AppLocalizations.of(context)!.category,
                themeSetting: themeSetting,
                description: AppLocalizations.of(context)!.category_description,
                child: CustomTextField(
                  onChanged: (val) {},
                  hintText: AppLocalizations.of(context)!.price_example,
                  autoFocus: true,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                  textInputType: TextInputType.number,
                  borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                  themeSetting: themeSetting,
                ),
              ),
              FormSection(
                title: AppLocalizations.of(context)!.image,
                description: AppLocalizations.of(context)!.image_description,
                themeSetting: themeSetting,
                child: CustomTextField(
                  onChanged: (val) {},
                  hintText: AppLocalizations.of(context)!.price_example,
                  autoFocus: true,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                  textInputType: TextInputType.number,
                  borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                  themeSetting: themeSetting,
                ),
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
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(
                          fontSize: 18,
                          color: themeSetting.bodyOnBackground,
                        ),
                      ),
                    ),
                  ),
                  SubmitButton(
                    themeSetting: themeSetting,
                    onPressed: () {
                      onAdded();
                    },
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
    );
  }
}
