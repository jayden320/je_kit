import 'package:flutter/material.dart';
import 'button.dart';

class DefaultCell extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Widget? rightWidget;
  final String? subtitle;
  final Widget? leftWidget;
  final bool isArrowVisible;
  final double rightPadding;
  final Color? subtitleColor;
  final bool isSeparatorVisible;

  const DefaultCell({
    this.title,
    this.subtitle,
    this.rightWidget,
    this.leftWidget,
    this.onPressed,
    this.isArrowVisible = false,
    this.rightPadding = 15,
    this.isSeparatorVisible = true,
    this.subtitleColor,
    Key? key,
  }) : super(key: key);

  Widget buildContent(BuildContext context) {
    var themeData = Theme.of(context);
    return Row(
      children: <Widget>[
        if (leftWidget != null) leftWidget!,
        if (leftWidget != null) const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              if (isSeparatorVisible) const SizedBox(height: 1),
              Expanded(
                child: Row(
                  children: [
                    if (title != null) Text(title!, style: themeData.textTheme.titleMedium, maxLines: 1),
                    Expanded(
                      child: (subtitle != null)
                          ? Text(
                              '   ' + subtitle!,
                              style: TextStyle(fontSize: 16, color: subtitleColor ?? Colors.black87),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : const SizedBox(),
                    ),
                    if (rightWidget != null) rightWidget!,
                    SizedBox(width: isArrowVisible ? 12 : rightPadding),
                    if (isArrowVisible) const Icon(Icons.arrow_forward_ios, color: Colors.black45, size: 16),
                    if (isArrowVisible) const SizedBox(width: 10),
                  ],
                ),
              ),
              if (isSeparatorVisible) const Divider(height: 1)
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      height: 44,
      padding: EdgeInsets.zero,
      color: Colors.white,
      disabledColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: buildContent(context),
            ),
          ),
        ],
      ),
    );
  }
}
