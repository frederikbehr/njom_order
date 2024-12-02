
import 'package:flutter/material.dart';
import 'package:nom_order/authentication/user.dart';
import 'package:nom_order/pages/home/home_page.dart';
import 'package:provider/provider.dart';
import '../data/dimensions.dart';
import '../data/runtime_manager.dart';
import '../pages/register/register.dart';

class Wrapper extends StatelessWidget {
  final RuntimeManager runtimeData;
  const Wrapper({super.key, required this.runtimeData});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUid?>(context);

    width = MediaQuery.of(context).size.width - MediaQuery.of(context).padding.left - MediaQuery.of(context).padding.right;
    height = MediaQuery.of(context).size.height;
    if (user != null) {
      return HomePage();
    } else {
      return Register();
    }
  }
}