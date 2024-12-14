import 'package:flutter/material.dart';
import 'package:nom_order/models/order/order_stage.dart';
import 'package:nom_order/pages/home/admin/edit_menu/edit_menu_page.dart';
import 'package:nom_order/pages/home/admin/settings/settings.dart';
import 'package:nom_order/pages/home/admin/top_bar.dart';
import 'package:nom_order/widgets/app_bar/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/controller.dart';

class AdminPage extends StatefulWidget {
  final Controller controller;
  const AdminPage({super.key, required this.controller});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  OrderStage? filterByStage;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.controller.themeSetting.background,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.admin_page,
        bottomBorder: false,
        themeSetting: widget.controller.themeSetting,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TopBar(
              themeSetting: widget.controller.themeSetting,
              onChanged: (val) => setState(() => filterByStage = val),
              onMenuEditButtonPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditMenuPage(controller: widget.controller);
              })),
              onSettingsButtonPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Settings(controller: widget.controller);
              })),
            ),
          ],
        ),
      ),
    );
  }
}
