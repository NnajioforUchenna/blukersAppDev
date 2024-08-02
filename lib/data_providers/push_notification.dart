import 'dart:convert';

import 'package:http/http.dart' as http;

class DataNotificationProvider {
  static Future sendPushNotification(
      {required String title,
      required String body,
      required String uid}) async {
    // send push notification
    const String apiUrl =
        'https://blukerscrm.uc.r.appspot.com/functions/send-notification';
    final Map<String, String> requestBody = {
      'title': title,
      'body': body,
      'uid': uid,
    };

    print('Sending notification with title: $title, body: $body, uid: $uid');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return 'Notification sent successfully';
      } else {
        return 'Failed to send notification. Status code: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error occurred while sending notification: $e';
    }
  }
}
