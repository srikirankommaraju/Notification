import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {


  //Singleton pattern
  static final LocalNotificationService _notificationService = LocalNotificationService._internal();
  factory LocalNotificationService() {
    return _notificationService;
  }
  LocalNotificationService._internal();


  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: IOSInitializationSettings(requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,));

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //When app is at foreground
  static void display(RemoteMessage message) async {
    try {
      //Dummy Id because it is unique
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Notification Details is important
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "push_notification", 'High Importance Notifications', // title
              importance: Importance.max,
              priority: Priority.high,),
      );

      await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }
}
