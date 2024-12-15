import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/models/order/order_item.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/pages/home/ordering/cart_page/order_item_card.dart';
import 'package:nom_order/pages/home/ordering/cart_page/total_display.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';
import '../../../../models/order/order.dart';

class CartPage extends StatefulWidget {
  final ThemeSetting themeSetting;
  final MenuOrder order;
  final Function(MenuOrder) onSend;
  final Function(OrderItem) onDecrement;
  const CartPage({
    super.key,
    required this.themeSetting,
    required this.order,
    required this.onSend,
    required this.onDecrement,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(48, 24, 48, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.order_summary,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            Divider(height: 72, thickness: 1.5, color: widget.themeSetting.shadow),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.order.items.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return OrderItemCard(
                  key: UniqueKey(),
                  orderItem: widget.order.items[index],
                  themeSetting: widget.themeSetting,
                  onDelete: () {
                    debugPrint("length: ${widget.order.items.length}, index=$index");
                    widget.onDecrement(widget.order.items[index]);
                    widget.order.decrementItem(widget.order.items[index]);
                    setState(() {});
                  },
                );
              },
            ),
            Divider(height: 72, thickness: 1.5, color: widget.themeSetting.shadow),
            TotalDisplay(total: widget.order.totalPrice, themeSetting: widget.themeSetting),
            const SizedBox(height: 24),
            CustomButton(
              onPressed: () => widget.onSend(widget.order),
              borderRadius: BorderRadius.circular(100),
              backgroundColor: widget.themeSetting.accent,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16),
                child: Text(
                  AppLocalizations.of(context)!.order_now,
                  style: TextStyle(
                    fontSize: 20,
                    color: widget.themeSetting.titleOnColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 72),
          ],
        ),
      ),
    );
  }
}
