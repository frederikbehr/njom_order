import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/db/menu/menu_db.dart';
import 'package:nom_order/pages/home/admin/edit_menu/add_category_page.dart';
import 'package:nom_order/pages/home/admin/edit_menu/edit_category_menu.dart';
import 'package:nom_order/widgets/buttons/icon_text_button.dart';
import 'package:nom_order/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';
import 'package:nom_order/widgets/menu/menu_section.dart';

import '../../../../controller/controller.dart';

class EditMenuPage extends StatefulWidget {
  final Controller controller;
  const EditMenuPage({super.key, required this.controller});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  late final DialogTemplates dialogTemplates = DialogTemplates(themeSetting: widget.controller.themeSetting);
  late final MenuDB menuDB = MenuDB(widget.controller.firebase, widget.controller.getUID()!);

  void openAddItemMenu() {}

  void openAddCategoryMenu() {
    dialogTemplates.openDialog(
      context,
      AddCategoryPage(
        themeSetting: widget.controller.themeSetting,
        onAdded: () => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.controller.themeSetting.background,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.menu,
        bottomBorder: false,
        themeSetting: widget.controller.themeSetting,
        leadingButton: true,
      ),
      body: SizedBox(
        height: height - 60,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 72),
                  EditCategoryMenu(
                    title: AppLocalizations.of(context)!.categories,
                    themeSetting: widget.controller.themeSetting,
                    menuDB: menuDB,
                  ),
                  MenuSection(
                    title: AppLocalizations.of(context)!.items,
                    items: [],
                    themeSetting: widget.controller.themeSetting,
                  ),
                  const SizedBox(height: 72),
                ],
              ),
            ),
            Positioned(
              bottom: 72,
              right: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomIconTextButton(
                    themeSetting: widget.controller.themeSetting,
                    onPressed: () => openAddItemMenu(),
                    text: AppLocalizations.of(context)!.add_item,
                    icon: Icons.fastfood_outlined,
                  ),
                  const SizedBox(height: 16),
                  CustomIconTextButton(
                    themeSetting: widget.controller.themeSetting,
                    onPressed: () => openAddCategoryMenu(),
                    text: AppLocalizations.of(context)!.add_category,
                    icon: Icons.menu_open_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
