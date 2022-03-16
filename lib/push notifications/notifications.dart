import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:push_notifications_with_awesome_notifications/push%20notifications/utilities.dart';

Future<void> createPlantFoodNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: creatUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
      body: 'Florist at 123 main st. has 2 in stock',
      bigPicture: 'asset://assets/images/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> createWaterReminderNotification(
    NotificationWeekAndTime notificationSchdule) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: creatUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.wheater_droplet} Add some water to your plant!',
      body: 'Water to your plant regularly to keep it healthy',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      )
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchdule.dayOfTheWeek,
      hour: notificationSchdule.timeOfDay.hour,
      minute: notificationSchdule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

Future<void> cancelScheduledNotification() async {
  await AwesomeNotifications().cancelAllSchedules();
}
