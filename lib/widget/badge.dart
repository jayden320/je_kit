import 'package:flutter/material.dart';

enum BadgeType {
  dot,
  number,
}

class BadgeView extends StatelessWidget {
  final BadgeType type;
  final int? value;
  final bool visible;
  final double dotRedius;

  const BadgeView({this.type = BadgeType.number, this.value, this.visible = true, this.dotRedius = 5.0, Key? key})
      : super(key: key);

  final double badgeRedius = 9.0;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox();
    }

    var redColor = const Color(0xFFF65756);
    if (type == BadgeType.dot) {
      return Container(
        width: dotRedius * 2,
        height: dotRedius * 2,
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.circular(dotRedius),
          border: Border.all(color: const Color(0xFFD46564), width: 0.5),
        ),
      );
    }

    if (value == null || value == 0) {
      return const SizedBox();
    }

    var text = value.toString();
    if (value! < 9) {
      return Container(
        width: badgeRedius * 2,
        height: badgeRedius * 2,
        decoration: BoxDecoration(color: redColor, borderRadius: BorderRadius.circular(badgeRedius)),
        child: Center(
          child: Text(text, style: const TextStyle(fontSize: 11, color: Colors.white)),
        ),
      );
    }
    if (value! > 99) {
      text = '99+';
    }
    return Container(
      height: badgeRedius * 2,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: redColor, borderRadius: BorderRadius.circular(badgeRedius)),
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 11, color: Colors.white)),
      ),
    );
  }
}
