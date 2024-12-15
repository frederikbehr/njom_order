import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/item/item_display.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/icon_button.dart';
import '../../../../models/item/item.dart';
import '../../../../widgets/buttons/icon_text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemPage extends StatelessWidget {
  final ItemDisplay item;
  final ThemeSetting themeSetting;
  final Function(Item) onAddToCard;
  const ItemPage({super.key, required this.item, required this.themeSetting, required this.onAddToCard});

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 32;
    final double dialogWidth = width * 0.5;
    final double imageWidth = dialogWidth - horizontalPadding*2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: dialogWidth,
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
            color: themeSetting.dialog,
          ),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconButton(
                        themeSetting: themeSetting,
                        onPressed: () => Navigator.pop(context),
                        icon: Icons.close_outlined,
                        backgroundColor: Colors.transparent,
                        iconColor: themeSetting.bodyOnBackground,
                        iconSize: 36,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(themeSetting.borderRadiusValue),
                    child: SizedBox(
                      width: imageWidth,
                      height: imageWidth,
                      child: item.image != null? item.image! : const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    item.item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeSetting.titleOnBackground,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.item.category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeSetting.accent,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.item.description,
                    style: TextStyle(
                      color: themeSetting.bodyOnBackground,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${item.item.price.toStringAsFixed(2).replaceFirst(".", ",")} DKK",
                          style: TextStyle(
                            color: themeSetting.titleOnBackground,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        CustomIconTextButton(
                          themeSetting: themeSetting,
                          onPressed: () => onAddToCard(item.item),
                          icon: Icons.shopping_basket_outlined,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          iconColor: themeSetting.accent.computeLuminance() > 0.5? Colors.black45 : Colors.white60,
                          text: AppLocalizations.of(context)!.add_to_cart,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
