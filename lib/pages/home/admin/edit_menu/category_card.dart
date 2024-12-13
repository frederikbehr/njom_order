import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/icon_button.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ThemeSetting themeSetting;
  const CategoryCard({
    super.key,
    required this.title,
    required this.onEdit,
    required this.onDelete,
    required this.themeSetting,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: themeSetting.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: themeSetting.titleOnBackground,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                CustomIconButton(
                  themeSetting: themeSetting,
                  onPressed: () => onEdit(),
                  icon: Icons.edit_outlined,
                ),
                const SizedBox(width: 12),
                CustomIconButton(
                  themeSetting: themeSetting,
                  onPressed: () => onDelete(),
                  icon: Icons.delete_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
