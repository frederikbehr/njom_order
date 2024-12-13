import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/pages/home/admin/settings/settings_item.dart';

import '../../../../models/theme/theme_setting.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final ThemeSetting themeSetting;
  const MenuSection({super.key, required this.title, required this.items, required this.themeSetting});

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
          ListView.builder(
            itemCount: items.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  index != 0? Divider(
                    height: 32,
                    color: themeSetting.shadow,
                    thickness: 2,
                  ) : const SizedBox(),
                  items[index],
                ],
              );
            },
          ),
          const SizedBox(height: 72),
        ],
      ),
    );
  }
}
