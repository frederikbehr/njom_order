import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../controller/controller.dart';

class HomePage extends StatefulWidget {
  final Controller controllerInstance;
  const HomePage({super.key, required this.controllerInstance});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.controllerInstance.themeSetting.background,
      appBar: AppBar(
        backgroundColor: widget.controllerInstance.themeSetting.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.ordering,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
