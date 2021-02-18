import 'dart:io';
import 'package:enstaller/ui/util/MessagingService/random_string.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FirebaseMessagingService {
  final FlutterLocalNotificationsPlugin flutterlocalnotificationplugin = new FlutterLocalNotificationsPlugin();
  
  FirebaseMessagingService() {
    //initializing setting
    var android = AndroidInitializationSettings('@mipmap/launcher_icon');
    var ios = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: android, iOS: ios);
    flutterlocalnotificationplugin.initialize(initializationSettings);
  }

  sendNotification(String title, String body) {
      showNotification(title, body);
      }

  // TOP-LEVEL or STATIC function to handle background messages
  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
        print("3333333333333");
    showNotification(message['notification']['title'], message['notification']['body']);
    return Future<void>.value();
  }

  static showNotification(String title, String body) async {
    FlutterLocalNotificationsPlugin flutterlocalnotificationplugin =
        new FlutterLocalNotificationsPlugin();
    var androidinit = AndroidInitializationSettings('@mipmap/launcher_icon');
    var ios = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidinit, iOS: ios);
    flutterlocalnotificationplugin.initialize(initializationSettings);

    var android = AndroidNotificationDetails(
        title + randomNumeric(4).toString(),
        title + randomNumeric(4).toString(),
        body);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    flutterlocalnotificationplugin.show(
          int.parse(randomNumeric(4)), title, body, platform);
  }  
}
