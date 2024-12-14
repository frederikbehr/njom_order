import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nom_order/data/images/images.dart';
import 'package:nom_order/models/item/item.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/storage/storage.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';
import 'package:nom_order/widgets/buttons/icon_button.dart';
import 'package:nom_order/widgets/buttons/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';
import 'package:nom_order/widgets/form/form_section.dart';
import 'package:nom_order/widgets/text_fields/custom_text_field.dart';

import '../../../../../db/menu/menu_db.dart';

class AddItemPage extends StatefulWidget {
  final ThemeSetting themeSetting;
  final VoidCallback onAdded;
  final List<String> categories;
  final String uid;
  final MenuDB menuDB;
  const AddItemPage({
    super.key,
    required this.themeSetting,
    required this.onAdded,
    required this.categories,
    required this.uid,
    required this.menuDB,
  });

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Storage storage = Storage();
  late final DialogTemplates dialogTemplates = DialogTemplates(themeSetting: widget.themeSetting);


  String titleSelected = "";
  String descriptionSelected = "";
  String priceSelected = "";
  late String categorySelected = widget.categories.first;
  String? imageSelected;
  Images images = Images();

  Future selectImage() async {
    String? imagePath = await images.getImage(false);
    if (imagePath != null) {
      imageSelected = imagePath;
      setState(() {});
    }
  }

  String? validatePrice(String? value) {
    try {
      double.parse(value!);
      return null;
    } catch(e) {
      return AppLocalizations.of(context)!.invalid_price;
    }
  }

  String? validateNotEmpty(String? value) {
    if (value != null && value.isEmpty) return AppLocalizations.of(context)!.invalid_text_field;
    return null;
  }

  Future submit() async {
    if (_formKey.currentState!.validate()) {
      dialogTemplates.openLoadingDialog(context);
      //uploading image before saving item
      String? imageUrl;
      if (imageSelected != null) imageUrl = await storage.uploadImage(imageSelected, widget.uid);
      final Item newItem = Item(
        id: "",
        title: titleSelected,
        description: descriptionSelected,
        price: double.parse(priceSelected),
        imageURL: imageUrl,
        category: categorySelected,
      );
      await widget.menuDB.addItem(newItem);
      pop();
      pop();
    }
    //todo: add to storage bucket
  }

  void pop() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 72),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: widget.themeSetting.dialog,
        borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
      ),
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                FormSection(
                  title: AppLocalizations.of(context)!.add_item_description,
                  themeSetting: widget.themeSetting,
                  child: CustomTextField(
                    onChanged: (val) => titleSelected = val,
                    validator: (val) => validateNotEmpty(val),
                    hintText: AppLocalizations.of(context)!.title_description,
                    autoFocus: true,
                    onSubmitted: () => FocusScope.of(context).unfocus(),
                    textInputType: TextInputType.text,
                    borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                    themeSetting: widget.themeSetting,
                  ),
                ),
                FormSection(
                  title: AppLocalizations.of(context)!.item_description,
                  themeSetting: widget.themeSetting,
                  child: CustomTextField(
                    onChanged: (val) => descriptionSelected = val,
                    validator: (val) => validateNotEmpty(val),
                    hintText: AppLocalizations.of(context)!.item_description_example,
                    autoFocus: true,
                    onSubmitted: () => FocusScope.of(context).unfocus(),
                    textInputType: TextInputType.text,
                    borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                    themeSetting: widget.themeSetting,
                  ),
                ),
                FormSection(
                  title: AppLocalizations.of(context)!.price,
                  description: AppLocalizations.of(context)!.price_description,
                  themeSetting: widget.themeSetting,
                  child: CustomTextField(
                    onChanged: (val) => priceSelected = val,
                    validator: (val) => validatePrice(val),
                    hintText: AppLocalizations.of(context)!.price_example,
                    autoFocus: true,
                    onSubmitted: () => FocusScope.of(context).unfocus(),
                    textInputType: TextInputType.number,
                    borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                    themeSetting: widget.themeSetting,
                  ),
                ),
                FormSection(
                  title: AppLocalizations.of(context)!.category,
                  themeSetting: widget.themeSetting,
                  description: AppLocalizations.of(context)!.category_description,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String> (
                      value: categorySelected,
                      style: TextStyle(
                        color: widget.themeSetting.accent,
                        fontSize: 18,
                      ),
                      iconEnabledColor: widget.themeSetting.accent,
                      iconSize: 36,
                      alignment: Alignment.centerRight,
                      dropdownColor: widget.themeSetting.primaryColor,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() => categorySelected = newValue);
                        }
                      },
                      items: widget.categories.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                FormSection(
                  title: AppLocalizations.of(context)!.image,
                  description: AppLocalizations.of(context)!.image_description,
                  themeSetting: widget.themeSetting,
                  child: Row(
                    children: [
                      imageSelected == null? const SizedBox() : Row(
                        children: [
                          CustomIconButton(
                            background: Colors.transparent,
                            iconColor: widget.themeSetting.shadow,
                            iconSize: 32,
                            themeSetting: widget.themeSetting,
                            onPressed: () => setState(() => imageSelected = null),
                            icon: Icons.close_outlined,
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      CustomButton(
                        borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                        onPressed: () => selectImage(),
                        backgroundColor: widget.themeSetting.accent,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Text(
                            AppLocalizations.of(context)!.select_image,
                            style: TextStyle(
                              color: widget.themeSetting.titleOnColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      imageSelected == null? const SizedBox() : Image.file(
                        File(imageSelected!),
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 72),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onPressed: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(widget.themeSetting.borderRadiusValue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            fontSize: 18,
                            color: widget.themeSetting.bodyOnBackground,
                          ),
                        ),
                      ),
                    ),
                    SubmitButton(
                      themeSetting: widget.themeSetting,
                      onPressed: () {
                        submit();
                        widget.onAdded();
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
      ),
    );
  }
}
