import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_constants.dart';

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

    // Update Crm that a new User have been registered
    final FirebaseFirestore crmFireStore = await getCRMFireStoreInstance();

    await crmFireStore
        .collection('Dashboard')
        .doc('Admin')
        .collection('NewUser')
        .doc(uid)
        .set({
      'uid': uid,
      'userJourney': {
        'prospect': firstLoadTime,
        'newcomer': DateTime.now().millisecondsSinceEpoch,
      }
    });
  }

  static Future<void> updateInitiate(String uid) async {
    // Update initiating profile creation

    // update the user journey
// Update the user journey
    await firestore.collection('AppUsers').doc(uid).set({
      'userJourney': {
        'initiateProfileCreation': DateTime.now().millisecondsSinceEpoch,
      },
    }, SetOptions(merge: true));

    // Update Crm that a new User have initiated profile creation
    final FirebaseFirestore crmFireStore = await getCRMFireStoreInstance();

    await crmFireStore
        .collection('Dashboard')
        .doc('Admin')
        .collection('InitiateProfileCreation')
        .doc(uid)
        .set({
      'uid': uid,
      'userJourney': {
        'initiate': DateTime.now().millisecondsSinceEpoch,
      }
    });
  }

  static Future<void> updateMember(String uid) async {
    // Update the user journey
    await firestore.collection('AppUsers').doc(uid).set({
      'userJourney': {
        'member': DateTime.now().millisecondsSinceEpoch,
      },
    }, SetOptions(merge: true));

    // Update Crm that a new User have been registered
    final FirebaseFirestore crmFireStore = await getCRMFireStoreInstance();

    await crmFireStore
        .collection('Dashboard')
        .doc('Admin')
        .collection('Member')
        .doc(uid)
        .set({
      'uid': uid,
      'userJourney': {
        'member': DateTime.now().millisecondsSinceEpoch,
      }
    });
  }

  static Future<void> updateSubscriber(String? uid) async {
    if (uid == null) {
      return;
    }

    // Update the user journey
    await firestore.collection('AppUsers').doc(uid).set({
      'userJourney': {
        'subscriber': DateTime.now().millisecondsSinceEpoch,
      },
    }, SetOptions(merge: true));

    // Update Crm that a new User have been registered
    final FirebaseFirestore crmFireStore = await getCRMFireStoreInstance();

    await crmFireStore
        .collection('Dashboard')
        .doc('Admin')
        .collection('Subscriber')
        .doc(uid)
        .set({
      'uid': uid,
      'userJourney': {
        'subscriber': DateTime.now().millisecondsSinceEpoch,
      }
    });
  }

  static Future<void> updateEliteClient(String uid) async {
    // Update the user journey
    await firestore.collection('AppUsers').doc(uid).set({
      'userJourney': {
        'eliteClient': DateTime.now().millisecondsSinceEpoch,
      },
    }, SetOptions(merge: true));

    // Update Crm that a new User have been registered
    final FirebaseFirestore crmFireStore = await getCRMFireStoreInstance();

    await crmFireStore
        .collection('Dashboard')
        .doc('Admin')
        .collection('EliteClient')
        .doc(uid)
        .set({
      'uid': uid,
      'userJourney': {
        'eliteClient': DateTime.now().millisecondsSinceEpoch,
      }
    });
  }
}
