import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/item/item_factory.dart';
import 'package:nom_order/pages/home/admin/edit_menu/category/category_card.dart';
import 'package:nom_order/pages/home/admin/edit_menu/item/item_card.dart';
import 'package:nom_order/pages/loading/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';

import '../../../../../db/menu/menu_db.dart';
import '../../../../../models/item/item.dart';
import '../../../../../models/theme/theme_setting.dart';

class EditItemMenu extends StatefulWidget {
  final String title;
  final ThemeSetting themeSetting;
  final MenuDB menuDB;
  final DialogTemplates dialogTemplates;
  const EditItemMenu({
    super.key,
    required this.title,
    required this.themeSetting,
    required this.menuDB,
    required this.dialogTemplates,
  });

  @override
  State<EditItemMenu> createState() => _EditItemMenuState();
}

class _EditItemMenuState extends State<EditItemMenu> {
  late final DialogTemplates dialogTemplates = DialogTemplates(themeSetting: widget.themeSetting);

  Future deleteItem(Item item) async {
    dialogTemplates.confirmDialog(context, AppLocalizations.of(context)!.delete_x(item.title), () async {
      await widget.menuDB.deleteItem(item);
      showMessage(item.title);
      setState(() {});
      Navigator.pop(context);
    });
  }

  void showMessage(String category) => widget.dialogTemplates.showScaffoldMessage(
    context,
    AppLocalizations.of(context)!.x_was_deleted('"$category"'),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width/10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                color: widget.themeSetting.bodyOnBackground,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 24),
          StreamBuilder(
            stream: widget.menuDB.getItemStreamReference(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading(themeSetting: widget.themeSetting);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return const Text("No data");
              } else {
                final List<Item?> items = snapshot.data!.docs.map((e) => ItemFactory.getItemFromSnapshot(e)).toList();
                items.removeWhere((e) => e == null);
                items.sort((a,b) => a!.category.compareTo(b!.category));
                return ListView.builder(
                  itemCount: items.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    if (items[index] == null) {
                      debugPrint("Item in StreamBuilder has a null value.");
                      return const SizedBox();
                    }
                    return ItemCard(
                      item: items[index]!,
                      onDelete: () => deleteItem(items[index]!),
                      onEdit: () {},
                      themeSetting: widget.themeSetting,
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(height: 72),
        ],
      ),
    );
  }
}
