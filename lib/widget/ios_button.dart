import 'package:flutter/cupertino.dart';

class IOSButton extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? disabledColor;
  final VoidCallback? onPressed;
  final double? minSize;
  final double pressedOpacity;
  final BorderRadius borderRadius;

  const IOSButton({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.color,
    this.disabledColor,
    this.minSize,
    this.pressedOpacity = 0.5,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      key: key,
      child: child,
      padding: padding,
      color: color,
      disabledColor: disabledColor ?? const Color(0xFFAAAAAA),
      minSize: minSize,
      pressedOpacity: pressedOpacity,
      borderRadius: borderRadius,
      onPressed: onPressed,
    );
  }
}
