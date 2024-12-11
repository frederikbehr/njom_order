import 'package:flutter/material.dart';
import '../../../data/dimensions.dart';

class RegisterFormButton extends StatelessWidget {
  final String title;
  final bool register;
  final VoidCallback callback;
  const RegisterFormButton({
    super.key,
    required this.title,
    required this.register,
    required this.callback,
  });

  final double _borderRadius = 200;
  final double _spacing = 48;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadius),
            bottomLeft: Radius.circular(register? 0 : _borderRadius),
            topRight: Radius.circular(_borderRadius),
            bottomRight: Radius.circular(register? _borderRadius : 0),
          ),
        ),
        color: register? const Color(0xfffac90a) : const Color(0xff41b658),
        child: InkWell(
          onTap: () => callback(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadius),
            bottomLeft: Radius.circular(register? 0 : _borderRadius),
            topRight: Radius.circular(_borderRadius),
            bottomRight: Radius.circular(register? _borderRadius : 0),
          ),
          splashColor: Colors.white24,
          child: SizedBox(
            width: width-_spacing*2.5,
            height: 66,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
