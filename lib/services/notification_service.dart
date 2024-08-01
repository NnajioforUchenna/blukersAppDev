import 'package:blukers/data_providers/user_data_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/app_user/app_user.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> requestForNotificationPermission(AppUser? appUser) async {
  NotificationSettings settings = await messaging.getNotificationSettings();

  // Delay for 30 Seconds
  await Future.delayed(const Duration(seconds: 10));

  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('We have permission');
    // Set up the token in the database
    setupToken(appUser!.uid);
  } else {
    print('We dont have accepted permission');
    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('We now have permission');
      // Set up the token in the database
      setupToken(appUser!.uid);
    }
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String? title = message.notification?.title;
    String? body = message.notification?.body;

    EasyLoading.showToast(
      title ?? 'No Title',
      duration: const Duration(seconds: 10),
      dismissOnTap: true,
      toastPosition: EasyLoadingToastPosition.top,
      maskType: EasyLoadingMaskType.none,
    );

    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    print('Message Title: $title');
    print('Message Body: $body');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> getToken(FirebaseMessaging messaging) async {
  String? token;
  if (kIsWeb) {
    String validKey =
        'BKTUvKrXq-WYWeW2uIFaBsHe4GFG6dh1SHwY5tn7UJ9IYLLBdLyWh94zOjdbZUTvS9lLE0z2PpaJ_XyZTBIVxdE';

    token = await messaging.getToken(
      vapidKey: validKey,
    );
  } else {
    token = await messaging.getToken();
  }
}

Future<void> saveTokenToDatabase(String token, String uid) async {
  await UserDataProvider.saveTokenToDatabase(token, uid);
}

Future<void> setupToken(String uid) async {
  String? token;
  if (kIsWeb) {
    String validKey =
        'BKTUvKrXq-WYWeW2uIFaBsHe4GFG6dh1SHwY5tn7UJ9IYLLBdLyWh94zOjdbZUTvS9lLE0z2PpaJ_XyZTBIVxdE';

    token = await messaging.getToken(
      vapidKey: validKey,
    );

    await saveTokenToDatabase(token!, uid);
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      // Now, you can pass both the token and the uid to the save function.
      saveTokenToDatabase(token, uid);
    });
  } else {
    token = await messaging.getToken();
    await saveTokenToDatabase(token!, uid);
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      // Now, you can pass both the token and the uid to the save function.
      saveTokenToDatabase(token, uid);
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
