import 'package:flutter/material.dart';
import 'package:nom_order/models/order/order_item.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:nom_order/widgets/buttons/icon_button.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItem orderItem;
  final ThemeSetting themeSetting;
  final VoidCallback onDelete;
  const OrderItemCard({
    super.key,
    required this.orderItem,
    required this.themeSetting,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomIconButton(
                onPressed: () => onDelete(),
                icon: Icons.remove_circle_outline_outlined,
                themeSetting: themeSetting,
                backgroundColor: Colors.transparent,
                iconColor: themeSetting.shadow,
                padding: const EdgeInsets.all(8),
                iconSize: 24,
              ),
              const SizedBox(width: 12),
              Text(
                "${orderItem.amount}x",
                style: TextStyle(
                  color: themeSetting.titleOnBackground,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                orderItem.item.title,
                style: TextStyle(
                  color: themeSetting.titleOnBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Text(
            "DKK ${orderItem.price}",
            style: TextStyle(
              color: themeSetting.bodyOnBackground,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
