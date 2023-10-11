import 'package:package_info_plus/package_info_plus.dart';
import 'package:blukers/config/index.dart';

class AppVersionHelper {
  // String hardCodedVersion = "1.0.2";
  String hardCodedVersion = Config().appVersion;

  getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  getInStringFormat() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  getInDoubleFormat() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return double.parse(packageInfo.version);
  }

  // hard coded

  getHardCodedVersionInStringFormat() {
    return hardCodedVersion;
  }

  getHardCodedVersionInDoubleFormat() {
    return double.parse(hardCodedVersion);
  }

  // get default version

  get() {
    // return getInStringFormat();
    return hardCodedVersion;
  }
}
