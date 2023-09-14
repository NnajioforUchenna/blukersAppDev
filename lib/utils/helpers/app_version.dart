import 'package:package_info_plus/package_info_plus.dart';

class AppVersionHelper {
  String hardCodedVersion = "1.0.2";

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
