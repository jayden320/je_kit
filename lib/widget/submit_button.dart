import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'indicator_button.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final IndicatorButtonPressed? onPressed;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double height;
  final double? width;
  final Gradient? gradient;

  const SubmitButton({
    required this.title,
    required this.onPressed,
    this.color,
    this.height = 46,
    this.width,
    this.margin,
    this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndicatorButton(
      onPressed: onPressed,
      height: height,
      margin: margin,
      width: width,
      color: color ?? Theme.of(context).primaryColor,
      disabledColor: Theme.of(context).primaryColor.withAlpha(55),
      borderRadius: BorderRadius.circular(height / 2),
      activityIndicator: CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
        child: const CupertinoActivityIndicator(radius: 12.5),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        gradient: gradient,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
