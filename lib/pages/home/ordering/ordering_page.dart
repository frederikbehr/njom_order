import 'package:flutter/material.dart';
import 'package:nom_order/db/local_db.dart';
import 'package:nom_order/pages/home/ordering/category_menu.dart';
import 'package:nom_order/pages/home/ordering/help_bar.dart';
import 'package:nom_order/widgets/app_bar/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/controller.dart';
import '../../../models/item/item.dart';

class OrderingPage extends StatelessWidget {
  final Controller controller;

  const OrderingPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HelpBar(themeSetting: controller.themeSetting),
            CategoryMenu(items: [])
          ],
        ),
      ),
    );
  }
}
