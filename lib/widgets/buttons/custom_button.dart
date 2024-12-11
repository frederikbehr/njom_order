import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final Widget? child;
  final ShapeBorder? shapeBorder;
  final BoxDecoration? boxDecoration;
  final Color? splashColor;
  const CustomButton({
    super.key,
    this.backgroundColor,
    required this.onPressed,
    required this.borderRadius,
    this.child,
    this.shapeBorder,
    this.boxDecoration,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: Material(
        color: backgroundColor?? Colors.transparent,
        shape: shapeBorder,
        child: InkWell(
          onTap: () => onPressed(),
          borderRadius: borderRadius,
          splashColor: splashColor,
          child: child,
        ),
      ),
    );
  }
}
