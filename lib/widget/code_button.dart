import 'package:flutter/material.dart';
import 'indicator_button.dart';

class CodeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int coldDownSeconds;
  final String title;
  final String resendTitle;
  final double width;

  const CodeButton({
    this.title = '发送验证码',
    this.resendTitle = '重新发送',
    this.width = 105,
    required this.onPressed,
    required this.coldDownSeconds,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (coldDownSeconds > 0) {
      return SizedBox(
        width: width,
        child: Center(
          child: Text(
            resendTitle + '($coldDownSeconds)',
            style: TextStyle(color: Theme.of(context).dividerColor),
          ),
        ),
      );
    }

    return IndicatorButton(
      onPressed: onPressed as Future<void> Function(),
      width: width,
      child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }
}
