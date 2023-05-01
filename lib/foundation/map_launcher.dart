import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import '../widget/toast.dart';
import 'dart:io';

class MapLauncher {
  static showNavigationSheet(BuildContext context, double longitude, double latitude) {
    List<Map<String, dynamic>> list = [
      {'title': '高德地图', 'func': () => _gotoAMap(longitude, latitude)},
      {'title': '百度地图', 'func': () => _gotoBaiduMap(longitude, latitude)},
      {'title': '腾讯地图', 'func': () => _gotoTencentMap(longitude, latitude)},
    ];
    if (Platform.isIOS) {
      list.add({'title': '苹果地图', 'func': () => _gotoAppleMap(longitude, latitude)});
    }
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          actions: list
              .map((e) => CupertinoActionSheetAction(
                    onPressed: () {
                      e['func']();
                      Navigator.of(context).pop();
                    },
                    child: Text(e['title']),
                  ))
              .toList(),
        );
      },
    );
  }

  /// 高德地图
  static Future<bool> _gotoAMap(longitude, latitude) async {
    var url = Uri.parse(
        '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2');
    bool canLaunch = await canLaunchUrl(url);
    if (!canLaunch) {
      Toast.show('未检测到高德地图~');
      return false;
    }
    await launchUrl(url);
    return true;
  }

  /// 腾讯地图
  static Future<bool> _gotoTencentMap(longitude, latitude) async {
    var url = Uri.parse(
        'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ');
    bool canLaunch = await canLaunchUrl(url);
    if (!canLaunch) {
      Toast.show('未检测到腾讯地图~');
      return false;
    }
    await launchUrl(url);
    return true;
  }

  /// 百度地图
  static Future<bool> _gotoBaiduMap(longitude, latitude) async {
    var url = Uri.parse('baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving');
    bool canLaunch = await canLaunchUrl(url);
    if (!canLaunch) {
      Toast.show('未检测到百度地图~');
      return false;
    }
    await launchUrl(url);
    return true;
  }

  /// 苹果地图
  static Future<bool> _gotoAppleMap(longitude, latitude) async {
    var url = Uri.parse('http://maps.apple.com/?&daddr=$latitude,$longitude');
    bool canLaunch = await canLaunchUrl(url);
    if (!canLaunch) {
      Toast.show('打开失败~');
      return false;
    }
    await launchUrl(url);
    return true;
  }
}
