import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:push_notifications_with_awesome_notifications/push%20notifications/notifications.dart';
import 'package:push_notifications_with_awesome_notifications/push%20notifications/plant_stats_page.dart';
import 'package:push_notifications_with_awesome_notifications/push%20notifications/utilities.dart';
import 'package:push_notifications_with_awesome_notifications/push%20notifications/widgets.dart';

class PushHomePage extends StatefulWidget {
  const PushHomePage({Key? key}) : super(key: key);

  @override
  State<PushHomePage> createState() => _PushHomePageState();
}

class _PushHomePageState extends State<PushHomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: const Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notification created on ${notification.channelKey}'),
        ),
      );
    });
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const PlantStatsPage(),
          ),
          (route) => route.isFirst);
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Thumbs'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PlantStatsPage()));
            },
            icon: const Icon(
              Icons.insert_chart_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const PlantImage(),
            const SizedBox(height: 25),
            HomePageButtons(
              onPressedOne: createPlantFoodNotification,
              onPressedTwo: () async {
                NotificationWeekAndTime? pickedSchedule =
                    await pickSchedule(context);
                if (pickedSchedule != null) {
                  createWaterReminderNotification(pickedSchedule);
                }
              },
              onPressedThree: cancelScheduledNotification,
            ),
          ],
        ),
      ),
    );
  }
}
