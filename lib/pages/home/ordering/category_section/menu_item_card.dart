import 'package:flutter/material.dart';
import 'package:nom_order/models/item/item.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/icon_button.dart';

class MenuItemCard extends StatelessWidget {
  final ThemeSetting themeSetting;
  final Item item;
  final double cardDiameter;
  const MenuItemCard({
    super.key,
    required this.themeSetting,
    required this.item,
    required this.cardDiameter,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 0.8,
          color: themeSetting.shadow.withOpacity(0.04),
        ),
      ),
      child: InkWell(
        onTap: () {},
        splashColor: themeSetting.secondary.withOpacity(0.2),
        child: SizedBox(
          width: cardDiameter,
          height: cardDiameter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 24),
                    SizedBox(
                      width: cardDiameter/2,
                      height: cardDiameter/2,
                      child: item.imageURL == null? const SizedBox() : ClipRRect(
                        borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                        child: Image.network(
                          item.imageURL!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.title,
                      style: TextStyle(
                        color: themeSetting.titleOnBackground,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: TextStyle(
                        color: themeSetting.bodyOnBackground,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${item.price.toStringAsFixed(2)} DKK",
                        style: TextStyle(
                          color: themeSetting.titleOnBackground,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      CustomIconButton(
                        themeSetting: themeSetting,
                        onPressed: () {},
                        icon: Icons.shopping_basket_outlined,
                        iconSize: 28,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
