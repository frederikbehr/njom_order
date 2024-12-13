import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/item/item_display.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/pages/home/ordering/category_section/menu_item_card.dart';

import '../../../../models/item/item.dart';
import '../../../../models/item/item_factory.dart';
import '../../../loading/loading.dart';

class CategorySection extends StatelessWidget {
  final String category;
  final ThemeSetting themeSetting;
  final Stream<QuerySnapshot> stream;
  final Function(ItemDisplay) onItemPressed;
  final Function(Item) onAddToCart;
  const CategorySection({
    super.key,
    required this.category,
    required this.themeSetting,
    required this.stream,
    required this.onItemPressed,
    required this.onAddToCart,
  });

  double calculateAspectRatio() {
    const double spacing = 12;
    double cardWidth = (width-spacing*4)/3;
    double cardHeight = 327;
    return cardWidth / cardHeight;
  }

  @override
  Widget build(BuildContext context) {
    double cardDiameter = (width-12*4)/3;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
            child: Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 36,
                color: themeSetting.titleOnBackground
              ),
            ),
          ),
        ),
        StreamBuilder(
          stream: stream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading(themeSetting: themeSetting);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (!snapshot.hasData) {
              return const Text("No data");
            } else {
              final List<Item?> items = snapshot.data!.docs.map((e) => ItemFactory.getItemFromSnapshot(e)).toList();
              items.removeWhere((e) => e == null);
              items.sort((a,b) => a!.category.compareTo(b!.category));
              return SizedBox(
                width: width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: calculateAspectRatio()),
                  itemCount: items.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (items[index] == null) {
                      debugPrint("Item in StreamBuilder has a null value.");
                      return const SizedBox();
                    }
                    return MenuItemCard(
                      themeSetting: themeSetting,
                      item: items[index]!,
                      cardDiameter: cardDiameter,
                      onPressed: (val) => onItemPressed(ItemDisplay(item: items[index]!, image: val)),
                      onAddToCart: () => onAddToCart(items[index]!),
                    );
                  },
                ),
              );
            }
          },
        ),
        const SizedBox(height: 128),
      ],
    );
  }
}
