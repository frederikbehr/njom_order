import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/db/menu/menu_db.dart';
import 'package:nom_order/models/order/order.dart';
import 'package:nom_order/pages/home/ordering/category_bar/category_bar.dart';
import 'package:nom_order/pages/home/ordering/category_section/category_section.dart';
import 'package:nom_order/pages/home/ordering/help_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/buttons/custom_button.dart';
import 'package:nom_order/widgets/buttons/icon_button.dart';
import 'package:nom_order/widgets/buttons/icon_text_button.dart';
import '../../../controller/controller.dart';

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
  final ScrollController _scrollController = ScrollController();
  late final List<GlobalKey> _keys = List.generate(
    widget.controller.userData.categories.length, (_) => GlobalKey());
  late final MenuDB menuDB = MenuDB(widget.controller.firebase, widget.controller.getUID()!);
  late final Order order = Order(
    id: "",
    items: [],
    tableId: widget.controller.deviceInfo!.tableId,
    timeReceived: null,
    amountToPay: 0,
    orderStage: null,
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
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      alignment: -0.4,
    );
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
                const SizedBox(height: 144),
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
                        iconSize: 30,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                    CustomIconTextButton(
                      themeSetting: widget.controller.themeSetting,
                      onPressed: () {},
                      fontSize: 20,
                      backgroundColor: widget.controller.themeSetting.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: width*0.16),
                      text: "${AppLocalizations.of(context)!.my_order} (${order.items.length})",
                      icon: Icons.check,
                      reverse: true,
                      addPadding: true,
                      iconColor: widget.controller.themeSetting.accent,
                    ),
                    CustomIconButton(
                      themeSetting: widget.controller.themeSetting,
                      onPressed: () {}, icon: Icons.language_outlined,
                      iconSize: 30,
                      backgroundColor: widget.controller.themeSetting.primaryColor,
                      padding: const EdgeInsets.all(16),
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
