import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Converter {
  static int intValue(dynamic data) {
    if (data is int) {
      return data;
    }
    if (data is String) {
      if (data == '') {
        return 0;
      }
      var result = int.tryParse(data) ?? 0;
      return result;
    }
    if (data is bool) {
      return data ? 1 : 0;
    }
    if (data is double) {
      return data.toInt();
    }
    return 0;
  }

  static String stringValue(dynamic data) {
    if (data is String) {
      return data;
    }
    if (data is int || data is double) {
      return data.toString();
    }
    if (data is bool) {
      return data ? '1' : '0';
    }
    return '';
  }

  static double doubleValue(dynamic data) {
    if (data is double) {
      return data;
    }
    if (data is int) {
      return data.toDouble();
    }
    if (data is String) {
      if (data == '') {
        return 0.0;
      }
      return double.parse(data);
    }
    if (data is bool) {
      return data ? 1.0 : 0.0;
    }
    return 0.0;
  }

  static bool boolValue(dynamic data) {
    if (data is bool) {
      return data;
    }
    if (data is int || data is double) {
      return data == 1;
    }
    if (data is String) {
      return data == '1' || data == 'true';
    }
    return false;
  }

  static Color? colorValue(dynamic data) {
    if (data == null || data is! String || data.isEmpty) {
      return null;
    }
    dynamic colorStr = data;
    if (colorStr.startsWith('#')) {
      colorStr = colorStr.substring(1);
    }
    colorStr = 'FF' + colorStr;
    int value = int.parse(colorStr, radix: 16);
    return Color(value);
  }
}
