import 'package:flutter/cupertino.dart';
import 'button.dart';

typedef IndicatorButtonPressed = Future<void> Function();

class IndicatorButton extends StatefulWidget {
  final IndicatorButtonPressed? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final double? minWidth;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? activityIndicator;
  final Decoration? decoration;
  final bool isIndicatorVisibleInLoading;

  const IndicatorButton({
    required this.child,
    required this.onPressed,
    this.margin,
    this.padding,
    this.color,
    this.disabledColor,
    this.borderRadius,
    this.width,
    this.height,
    this.activityIndicator,
    this.minWidth,
    this.decoration,
    this.isIndicatorVisibleInLoading = true,
    Key? key,
  }) : super(key: key);

  @override
  _IndicatorButtonState createState() => _IndicatorButtonState();
}

class _IndicatorButtonState extends State<IndicatorButton> {
  bool _isLoading = false;

  indicator() {
    if (widget.activityIndicator != null) {
      return widget.activityIndicator;
    }
    return const CupertinoActivityIndicator();
  }

  onPressed() async {
    if (_isLoading) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      await widget.onPressed!();
    } catch (e) {
      rethrow;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      child: (_isLoading && widget.isIndicatorVisibleInLoading) ? indicator() : widget.child,
      onPressed: widget.onPressed != null ? onPressed : null,
      margin: widget.margin,
      padding: widget.padding,
      color: widget.color,
      disabledColor: widget.disabledColor,
      borderRadius: widget.borderRadius,
      width: widget.width,
      height: widget.height,
      minWidth: widget.minWidth,
      decoration: widget.decoration,
    );
  }
}
