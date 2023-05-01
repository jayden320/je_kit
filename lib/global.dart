import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import './foundation/platform_utility.dart';

enum BuildMode {
  debug,
  profile,
  release,
}

class Global {
  static late String documentsDirectory;

  static late String tempDirectory;

  static late PackageInfo packageInfo;

  static PlatformUtility platform = Platform.isIOS ? PlatformUtilityIOS() : PlatformUtilityAndroid();

  static BuildMode buildMode = (() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.release;
    }
    var result = BuildMode.profile;
    assert(() {
      result = BuildMode.debug;
      return true;
    }());
    return result;
  }());

  static setup() async {
    packageInfo = await PackageInfo.fromPlatform();
    documentsDirectory = (await getApplicationDocumentsDirectory()).path;
    tempDirectory = (await getTemporaryDirectory()).path;

    await platform.setup();
  }
}
