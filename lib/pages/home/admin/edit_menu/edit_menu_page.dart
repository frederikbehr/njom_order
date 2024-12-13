import 'package:flutter/material.dart';
import 'package:nom_order/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../controller/controller.dart';

class EditMenuPage extends StatefulWidget {
  final Controller controller;
  const EditMenuPage({super.key, required this.controller});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.menu,
        bottomBorder: false,
        themeSetting: widget.controller.themeSetting,
        leadingButton: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
