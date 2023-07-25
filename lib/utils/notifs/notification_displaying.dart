import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> notification_for_required() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        channelKey: 'high_importance_channel',
        id: createUniqueId(),
        title: 'Earplugs are required',
        body:
            'If not available, withdrawal from the environment is also an option',
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/2.png',
      ),
    );
  }

  Future<void> notification_for_recommended() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'high_importance_channel',
        title: 'Earplugs are recommended',
        body:
            'If not available, withdrawal from the environment is also an option',
        bigPicture: 'asset://assets/1.png',
        largeIcon: 'asset://assets/1.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }