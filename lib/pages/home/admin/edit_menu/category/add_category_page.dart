import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';
import 'package:nom_order/widgets/buttons/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/text_fields/custom_text_field.dart';

class AddCategoryPage extends StatefulWidget {
  final ThemeSetting themeSetting;
  final Function(String) onAdded;

  const AddCategoryPage({
    super.key,
    required this.themeSetting,
    required this.onAdded,
  });

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  String result = "";

  void submit() {
    if (result.isNotEmpty) {
      widget.onAdded(result);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height - 60,
      margin: const EdgeInsets.symmetric(horizontal: 72),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: widget.themeSetting.dialog,
        borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 72),
              Text(
                AppLocalizations.of(context)!.add_category_description,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.themeSetting.bodyOnBackground,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                onChanged: (val) => result = val,
                hintText: AppLocalizations.of(context)!.add_category_hint,
                autoFocus: true,
                onSubmitted: () => FocusScope.of(context).unfocus(),
                textInputType: TextInputType.text,
                borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                themeSetting: widget.themeSetting,
              ),
              const SizedBox(height: 72),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 72.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                    child: Text(
                      AppLocalizations.of(context)!.close,
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.themeSetting.bodyOnBackground,
                      ),
                    ),
                  ),
                ),
                SubmitButton(
                  themeSetting: widget.themeSetting,
                  onPressed: () => submit(),
                  fontSize: 18,
                  text: AppLocalizations.of(context)!.add,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
