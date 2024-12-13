import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/pages/home/admin/edit_menu/category_card.dart';
import 'package:nom_order/pages/loading/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../db/menu/menu_db.dart';
import '../../../../models/theme/theme_setting.dart';

class EditCategoryMenu extends StatelessWidget {
  final String title;
  final ThemeSetting themeSetting;
  final MenuDB menuDB;
  const EditCategoryMenu({super.key, required this.title, required this.themeSetting, required this.menuDB});

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
              title,
              style: TextStyle(
                fontSize: 18,
                color: themeSetting.bodyOnBackground,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 24),
          FutureBuilder(
            future: menuDB.getCategories(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data!.length);
                if (snapshot.data!.isEmpty) {
                  return Text(
                    AppLocalizations.of(context)!.no_categories,
                    style: TextStyle(
                      color: themeSetting.bodyOnBackground,
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
                      onDelete: () {},
                      onEdit: () {},
                      themeSetting: themeSetting,
                    );
                  },
                );
              } else {
                return Loading(themeSetting: themeSetting);
              }
            },
          ),
          const SizedBox(height: 72),
        ],
      ),
    );
  }
}
