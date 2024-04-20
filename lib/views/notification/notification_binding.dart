import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ints/base/base_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}

class NotificationController extends BaseController {
  bool isAvailableNoti = true;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late RxString message;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  _registerOnFirebase() {
    _fcm.subscribeToTopic('all');
    _fcm.getToken().then((token) => print("FCM token: $token"));
  }

  @override
  void onInit() {
    _registerOnFirebase();
    _registerOnFirebase();
    getMessage();
    super.onInit();
  }

  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      print('Message received: $remoteMessage');
      message.value = remoteMessage.notification!.body ?? "";
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      print('Message received: $remoteMessage');
      message.value = remoteMessage.notification!.body ?? "";
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'com.ints.appfood',
        't&t food',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
      ); 
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.show(
        int.parse(remoteMessage.messageId ?? ''),
        remoteMessage.notification?.title ?? '',
        remoteMessage.notification?.body ?? '',
        platformChannelSpecifics,
      );
    });
  }
}
