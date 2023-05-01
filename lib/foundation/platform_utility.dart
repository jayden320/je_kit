import 'package:device_info/device_info.dart';

abstract class PlatformUtility {
  String get platformName;
  String get systemVersion;
  bool get isPhysicalDevice;
  String get manufacturer;
  Future setup();
}

class PlatformUtilityIOS extends PlatformUtility {
  late IosDeviceInfo deviceInfo;

  @override
  String get platformName => 'iOS';

  @override
  bool get isPhysicalDevice => deviceInfo.isPhysicalDevice;

  @override
  String get systemVersion => deviceInfo.systemVersion;

  @override
  Future setup() async {
    deviceInfo = await DeviceInfoPlugin().iosInfo;
  }

  @override
  String get manufacturer => 'apple';
}

class PlatformUtilityAndroid extends PlatformUtility {
  late AndroidDeviceInfo deviceInfo;

  @override
  String get platformName => 'android';

  @override
  bool get isPhysicalDevice => deviceInfo.isPhysicalDevice;

  @override
  String get systemVersion => deviceInfo.version.codename;

  @override
  Future setup() async {
    deviceInfo = await DeviceInfoPlugin().androidInfo;
  }

  @override
  String get manufacturer {
    // case 'huawei': // 华为
    // case 'xiaomi': // 小米
    // case 'oppo': // Oppo
    // case 'vivo': // Vivo
    // case 'meizu': // 魅族
    // case 'samsung': // 三星
    // case 'blackshark': // 黑鲨
    String manufacturer = deviceInfo.manufacturer.isNotEmpty ? deviceInfo.manufacturer.toLowerCase() : 'unknown';
    return manufacturer;
  }
}
