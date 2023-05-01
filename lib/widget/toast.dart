import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quiver/strings.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

import '../foundation/http_error.dart';

class Toast {
  static Map<String, String> messageConversions = {};
  static List<String> messageIgnoreKeys = [];

  static show(String msg, {bool inMiddle = false}) {
    if (msg.isNotEmpty) {
      showToast(
        msg,
        textPadding: const EdgeInsets.all(10),
        position: ToastPosition.bottom,
      );
    }
  }

  static showError(dynamic e, {bool inMiddle = false}) {
    if (e is TypeError) {
      return;
    }
    if (e is HttpError || e is FlutterError || e is PlatformException || e is SocketException || e is HandshakeException) {
      var msg = e.message;

      for (var key in messageIgnoreKeys) {
        if (msg.contains(key)) {
          return;
        }
      }
      for (var key in messageConversions.keys) {
        if (msg.contains(key)) {
          msg = messageConversions[key];
        }
      }
      if (e is HttpError && isEmpty(msg)) {
        msg = '网络出问题了(${e.runtimeType})';
      }
      Toast.show(e.message, inMiddle: inMiddle);
    } else if (e is TimeoutException) {
      Toast.show('请求超时了~', inMiddle: inMiddle);
    } else {
      Toast.show(e.toString(), inMiddle: inMiddle);
    }
  }
}
