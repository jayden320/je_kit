import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double? minWidth;
  final Decoration? decoration;

  const Button({
    required this.child,
    required this.onPressed,
    this.margin,
    this.padding,
    this.color,
    this.disabledColor,
    this.borderRadius,
    this.width,
    this.height,
    this.minWidth,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: borderRadius != null ? Clip.antiAlias : Clip.none,
        child: MaterialButton(
          textColor: const Color(0xFF333333),
          child: child,
          onPressed: onPressed,
          elevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          padding: padding,
          minWidth: minWidth,
          disabledColor: disabledColor,
          color: color,
        ),
      ),
    );
  }
}
