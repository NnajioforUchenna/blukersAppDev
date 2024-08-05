import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'data_constants.dart';

class UserJourneyDataProvider {
  static String baseUrl = '$baseUrlAppEngineFunctions/user_journey';

  static Future<void> updateProspects(String deviceId) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_prospects'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'deviceId': deviceId, 'firstLoadTime': currentTime}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update prospects: ${response.body}');
      }
    } catch (e) {
      print('Error updating prospects: $e');
    }
  }

  static Future<void> updateNewcomer(String uid) async {
    try {
      final SharedPreferencesAsync prefs = SharedPreferencesAsync();
      String? deviceId = await prefs.getString('device_id');
      if (deviceId == null) {
        print('Device ID not found');
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/update_newcomer'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'uid': uid, 'deviceId': deviceId}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update newcomer: ${response.body}');
      }
    } catch (e) {
      print('Error updating newcomer: $e');
    }
  }

  static Future<void> updateInitiate(String uid) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_initiate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'uid': uid}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update initiate: ${response.body}');
      }
    } catch (e) {
      print('Error updating initiate: $e');
    }
  }

  static Future<void> updateMember(String uid) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_member'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'uid': uid}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update member: ${response.body}');
      }
    } catch (e) {
      print('Error updating member: $e');
    }
  }

  static Future<void> updateSubscriber(String? uid) async {
    if (uid == null) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_subscriber'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'uid': uid}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update subscriber: ${response.body}');
      }
    } catch (e) {
      print('Error updating subscriber: $e');
    }
  }



  static Future<void> updateEliteClient(String uid) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_elite_client'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'uid': uid}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update elite client: ${response.body}');
      }
    } catch (e) {
      print('Error updating elite client: $e');
    }
  }
}
