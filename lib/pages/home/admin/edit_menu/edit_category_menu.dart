import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/pages/home/admin/edit_menu/category_card.dart';
import 'package:nom_order/pages/loading/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';

import '../../../../db/menu/menu_db.dart';
import '../../../../models/theme/theme_setting.dart';

class EditCategoryMenu extends StatefulWidget {
  final String title;
  final ThemeSetting themeSetting;
  final MenuDB menuDB;
  final DialogTemplates dialogTemplates;
  const EditCategoryMenu({
    super.key,
    required this.title,
    required this.themeSetting,
    required this.menuDB,
    required this.dialogTemplates,
  });

  @override
  State<EditCategoryMenu> createState() => _EditCategoryMenuState();
}

class _EditCategoryMenuState extends State<EditCategoryMenu> {

  Future deleteCategory(String category) async {
    await widget.menuDB.removeCategory(category);
    showMessage(category);
    setState(() {});
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
          FutureBuilder(
            future: widget.menuDB.getCategories(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data!.length);
                if (snapshot.data!.isEmpty) {
                  return Text(
                    AppLocalizations.of(context)!.no_categories,
                    style: TextStyle(
                      color: widget.themeSetting.bodyOnBackground,
                      fontSize: 14,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryCard(
                      title: snapshot.data![index],
                      onDelete: () => deleteCategory(snapshot.data![index]),
                      onEdit: () {},
                      themeSetting: widget.themeSetting,
                    );
                  },
                );
              } else {
                return Loading(themeSetting: widget.themeSetting);
              }
            },
          ),
          const SizedBox(height: 72),
        ],
      ),
    );
  }
}
