import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nom_order/models/theme/theme_setting.dart';

class Loading extends StatelessWidget {
  final ThemeSetting themeSetting;
  const Loading({super.key, required this.themeSetting});

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: themeSetting.secondary,
      size: 40,
    );
  }
}
