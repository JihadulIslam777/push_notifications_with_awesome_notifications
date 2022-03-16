import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_notifications_with_awesome_notifications/push%20notifications/push_home_page.dart';

void main() {
  AwesomeNotifications()
      .initialize('resource://drawable/res_notification_app_icon', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      defaultColor: Colors.teal,
      importance: NotificationImportance.High,
      channelShowBadge: true,
      channelDescription: 'Tushar',
    ),
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Scheduled Notifications',
      defaultColor: Colors.teal,
      locked: true,
      importance: NotificationImportance.High,
      soundSource: 'resource://raw/res_custom_notification',
      channelDescription: 'Niha',
    ),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PushHomePage(),
      //Theme data for Push Notifications
      theme: ThemeData(
        primaryColor: Colors.teal,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.tealAccent),
      ),
      home: const PushHomePage(),
      // Landing(
      //   authBaseExample: AuthExample(),
      // ),
    );
  }
}
