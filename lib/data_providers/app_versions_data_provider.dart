import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blukers/utils/helpers/index.dart';
import 'package:pub_semver/pub_semver.dart';
import 'data_constants.dart';

final firestore = FirebaseFirestore.instance;

class AppVersionsDataProvider {
  Future<Map<String, dynamic>> getLatestVersionDoc() async {
    try {
      var appVersionsDoc = await FirebaseFirestore.instance
          .collection(appVersionsCollection)
          .doc('latest')
          .get();

      Map<String, dynamic> data = appVersionsDoc.data() as Map<String, dynamic>;

      return data;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> shouldUpdateApp() async {
    bool answer = false;
    String iOSUrl = "";
    String androidUrl = "";
    String latestVersion = "1.0.0";
    try {
      String currentAppVersion = AppVersionHelper().get();
      Map<String, dynamic> latestVersionData = await getLatestVersionDoc();
      String latestVersion = latestVersionData['version'] ?? "";

      if (latestVersionData.containsKey('version') &&
          latestVersion != "" &&
          Version.parse(latestVersion) > Version.parse(currentAppVersion)) {
        // print('versions are not the same');
        // print('current version: $currentAppVersion');
        // print('latest version: ' + latestVersionData["version"]);

        answer = true;
        iOSUrl = latestVersionData['iOSUrl'];
        androidUrl = latestVersionData['androidUrl'];
        latestVersion = latestVersionData['version'];
      }
    } catch (e) {
      // print('shouldUpdateApp() - inside catch');
      // print(e);
      // return Future.error(e.toString());
    }
    return {
      'answer': answer,
      'iOSUrl': iOSUrl,
      'androidUrl': androidUrl,
      'latestVersion': latestVersion,
    };
  }
}
