import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final firestore = FirebaseFirestore.instance;

class UserJourneyDataProvider {
  static Future<void> updateProspects(String deviceId) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    await firestore.collection('prospects').doc(deviceId).set({
      'prospect_uid': deviceId,
      'first_load_time': currentTime,
    });
  }

  static Future<void> updateNewcomer(String uid) async {
    // 1. get Device ID
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_id');

    // 2. Using the Device ID, get Prospect data
    DocumentSnapshot prospectData =
        await firestore.collection('prospects').doc(deviceId).get();

    // Cast the data to Map<String, dynamic>
    Map<String, dynamic>? prospectDataMap =
        prospectData.data() as Map<String, dynamic>?;
    int firstLoadTime = prospectDataMap?['first_load_time'] ?? 0;

    // 3. Update AppUser UserJourney with the Prospect data and NewComer status
    await firestore.collection('AppUsers').doc(uid).update({
      'userJourney': {
        'prospect': firstLoadTime,
        'newcomer': DateTime.now().millisecondsSinceEpoch,
      },
    });
  }

  // Update Crm that a new User have been registered
}
