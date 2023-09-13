import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/industry.dart';
import 'data_constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class IndustriesDataProvider {
  static Future<Map<String, Industry>> getAllIndustries() async {
    Map<String, Industry> industriesDict = {};

    QuerySnapshot industriesSnapshot =
        await _firestore.collection(industriesCollections).get();

    for (var industryDoc in industriesSnapshot.docs) {
      DocumentReference industryRef =
          _firestore.collection(industriesCollections).doc(industryDoc.id);
      QuerySnapshot jobsSnapshot = await industryRef.collection('jobs').get();

      List<Map<String, dynamic>> jobsData = [];
      for (var jobDoc in jobsSnapshot.docs) {
        jobsData.add(jobDoc.data() as Map<String, dynamic>);
      }

      Map<String, dynamic> industryData =
          industryDoc.data() as Map<String, dynamic>;
      industryData['jobs'] = jobsData;

      Industry industry = Industry.fromMap(industryData);
      industriesDict[industry.industryId] = industry;
    }

    return industriesDict;
  }
}
