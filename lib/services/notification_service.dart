import 'dart:convert';
import 'dart:io';

import 'package:blukers/main.dart';
import 'package:blukers/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final firebaseMessaging = FirebaseMessaging.instance;
final firestore = FirebaseFirestore.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
ChatProvider? chatProvider;
//final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationService {
  static Future<void> registerNotification(
      String uid, ChatProvider chatProv) async {
    chatProvider = chatProv;
    firebaseMessaging.requestPermission();
    //firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final res = json.decode(message.data["body"]);
      if (res["roomId"] != chatProvider?.activeRoomId) {
        showNotification(from: res["sendByNamy"], message: res["message"]);
      } else {
        print("no notification");
      }
      int index = chatProvider!.chatRooms
          .indexWhere((element) => element.id == res["roomId"]);
      chatProvider!.chatRooms[index].lastMessage = res["message"];
      chatProvider!.notifyListners();
      print('onMessage:: $res');
      //message.data;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      final res = json.decode(message.data["body"]);
      int index = chatProvider!.chatRooms
          .indexWhere((element) => element.id == res["roomId"]);
      chatProvider!.chatRooms[index].lastMessage = res["message"];
      chatProvider!.notifyListners();
      navigatorKey.currentState!.pushNamed('/chat-message', arguments: {
        "roomId": res["roomId"].toString(),
        "roomName": res["sendByNamy"].toString(),
      });
      // context.go( '/message',
      //     arguments: MessageArguments(message, true));
    });

    String? token = await firebaseMessaging.getToken();
    firestore.collection('AppUsers').doc(uid).update({'pushToken': token});
  }

  static void configLocalNotification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void showNotification(
      {required String from, required String message}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      // 'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, from, message, platformChannelSpecifics, payload: message);
  }
}
