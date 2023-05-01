import 'dart:async';
import 'package:flutter/material.dart';
import 'screen.dart';

mixin LoginRequirement on Widget {}

class Utility {
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future popToFirstPage(BuildContext context) async {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  static afterLayout(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      callback();
    });
  }

  static fixedFontSize(double fontSize) {
    return fontSize / Screen.textScaleFactor;
  }

  static List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}

extension JJTextEditingController on TextEditingController {
  selectAll() {
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

