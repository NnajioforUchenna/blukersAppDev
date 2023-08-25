import 'package:cloud_firestore/cloud_firestore.dart';
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
    try {
      Map<String, dynamic> latestVersionData = await getLatestVersionDoc();

      return latestVersionData;
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}
