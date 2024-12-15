import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/db/menu/menu_db.dart';
import 'package:nom_order/db/order/order_db.dart';
import 'package:nom_order/models/item/item_display.dart';
import 'package:nom_order/models/order/cart.dart';
import 'package:nom_order/models/order/order.dart';
import 'package:nom_order/pages/home/ordering/category_bar/category_bar.dart';
import 'package:nom_order/pages/home/ordering/category_section/category_section.dart';
import 'package:nom_order/pages/home/ordering/help_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/pages/home/ordering/item_page/item_page.dart';
import 'package:nom_order/pages/home/ordering/order_button/order_button.dart';
import 'package:nom_order/pages/home/ordering/cart_page/cart_page.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';
import 'package:nom_order/widgets/buttons/icon_button.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';
import '../../../controller/controller.dart';
import '../../../models/item/item.dart';

class OrderingPage extends StatefulWidget {
  final Controller controller;

  const OrderingPage({
    super.key,
    required this.controller,
  });

  @override
  State<OrderingPage> createState() => _OrderingPageState();
}

class _OrderingPageState extends State<OrderingPage> {
  final GlobalKey<OrderButtonState> _orderButtonKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late final DialogTemplates dialogTemplates = DialogTemplates(themeSetting: widget.controller.themeSetting);
  late final List<GlobalKey> _keys = List.generate(
    widget.controller.userData.categories.length, (_) => GlobalKey());
  late final MenuDB menuDB = MenuDB(widget.controller.firebase, widget.controller.getUID()!);
  late final OrderDB orderDB = OrderDB(widget.controller.firebase, widget.controller.getUID()!);
  late final Cart cart = Cart(
    items: [],
    tableId: widget.controller.deviceInfo!.tableId,
  );

  Future signOut() async {
    await widget.controller.deviceDB.removeDeviceInfo();
    widget.controller.deviceInfo = null;
    await widget.controller.authService.auth.signOut();
    reopenApp();
  }

  void reopenApp() => Phoenix.rebirth(context);

  void _scrollToKey(int index) {
    Scrollable.ensureVisible(
      _keys[index].currentContext!,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      alignment: -0.4,
    );
  }

  void addToCart(Item item) {
    dialogTemplates.showScaffoldMessage(
      context,
      !cart.contains(item)? AppLocalizations.of(context)!.x_added_to_cart(item.title)
          : AppLocalizations.of(context)!.another_x_added_to_cart(item.title),
      const Duration(milliseconds: 700),
    );
    cart.addMenuItem(item);
    _orderButtonKey.currentState?.update(cart.items.length);
  }

  void showItemDialog(ItemDisplay item) {
    dialogTemplates.openDialog(context, ItemPage(
      item: item,
      themeSetting: widget.controller.themeSetting,
      onAddToCard: (val) => addToCart(val),
    ));
  }

  Future sendOrder(MenuOrder order) async {
    Navigator.pop(context);
    if (order.items.isNotEmpty) {
      await orderDB.addOrder(order);
      cart.reset();
      _orderButtonKey.currentState?.update(0);
      setState(() {});
      dialogTemplates.showScaffoldMessage(context, AppLocalizations.of(context)!.order_sent, const Duration(seconds: 2));
    } else {
      dialogTemplates.showScaffoldMessage(context, AppLocalizations.of(context)!.order_empty, const Duration(seconds: 2));
    }
  }

  Future openCart() async {
    await dialogTemplates.openModal(
      context,
      CartPage(
        themeSetting: widget.controller.themeSetting,
        order: cart.makeOrder(),
        onSend: (order) => sendOrder(order),
        onDecrement: (val) {
          int cartIndex = cart.items.indexWhere((e) => e.title == val.item.title && e.description == val.item.description);
          if (cartIndex == -1) {
            debugPrint("Could not decrement item from order");
          } else {
            cart.items.removeAt(cartIndex);
            _orderButtonKey.currentState?.update(cart.items.length);
          }
        },
      ),
    ).then((_) => _orderButtonKey.currentState?.update(cart.items.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.controller.themeSetting.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.controller.userData.categories.length,
                  padding: const EdgeInsets.symmetric(vertical: 180),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return CategorySection(
                      key: _keys[index],
                      category: widget.controller.userData.categories[index],
                      themeSetting: widget.controller.themeSetting,
                      stream: menuDB.getItemsByCategoryStreamReference(widget.controller.userData.categories[index]),
                      onItemPressed: (val) => showItemDialog(val),
                      onAddToCart: (val) => addToCart(val),
                    );
                  },
                ),
                CustomButton(
                  onPressed: () => signOut(),
                  borderRadius: BorderRadius.circular(widget.controller.themeSetting.borderRadiusValue),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                    child: Text(
                      AppLocalizations.of(context)!.sign_out,
                      style: TextStyle(
                        color: widget.controller.themeSetting.bodyOnBackground,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 240),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Column(
              children: [
                HelpBar(themeSetting: widget.controller.themeSetting),
                CategoryBar(
                  themeSetting: widget.controller.themeSetting,
                  onCategorySelect: (val) => _scrollToKey(val),
                  items: widget.controller.userData.categories,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 48,
            left: 0,
            child: SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: 0,
                      child: CustomIconButton(
                        themeSetting: widget.controller.themeSetting,
                        onPressed: () {},
                        icon: Icons.language_outlined,
                        iconSize: 32,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                    OrderButton(
                      key: _orderButtonKey,
                      themeSetting: widget.controller.themeSetting,
                      onPressed: () => openCart(),
                    ),
                    CustomIconButton(
                      themeSetting: widget.controller.themeSetting,
                      onPressed: () {}, icon: Icons.language_outlined,
                      iconSize: 36,
                      backgroundColor: widget.controller.themeSetting.primaryColor,
                      padding: const EdgeInsets.all(14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
