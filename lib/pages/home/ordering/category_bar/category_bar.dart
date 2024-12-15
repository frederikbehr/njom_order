import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/widgets/buttons/subtle_button.dart';
import '../../../../models/theme/theme_setting.dart';

class CategoryBar extends StatelessWidget {
  final List<String> items;
  final ThemeSetting themeSetting;
  final Function(int) onCategorySelect;
  const CategoryBar({
    super.key,
    required this.items,
    required this.themeSetting,
    required this.onCategorySelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: width,
      color: themeSetting.primaryColor,
      child: ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: SubtleButton(
              themeSetting: themeSetting,
              onPressed: () => onCategorySelect(index),
              text: items[index],
              onColor: true,
            ),
          );
        },
      ),
    );
  }
}
