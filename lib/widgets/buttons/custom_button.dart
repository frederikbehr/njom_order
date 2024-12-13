import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final Widget? child;
  final ShapeBorder? shapeBorder;
  final BoxDecoration? boxDecoration;
  final Color? splashColor;
  final double? maxHeight;
  const CustomButton({
    super.key,
    this.backgroundColor,
    required this.onPressed,
    required this.borderRadius,
    this.child,
    this.shapeBorder,
    this.boxDecoration,
    this.splashColor,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: maxHeight != null? BoxConstraints(
        maxWidth: 400,
        maxHeight: maxHeight?? 400,
      ) : BoxConstraints.tightFor(),
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
