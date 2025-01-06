import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController = StreamController();

  static _onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onTap,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static void displayNotification({String? message}) async {
    const StyleInformation bigTextStyleInformation =
    BigTextStyleInformation(
      'Este é o texto detalhado que será exibido na notificação. Você pode incluir muito mais informações aqui do que no texto normal.',
      htmlFormatBigText: true,
      contentTitle: 'Título da Notificação',
      htmlFormatContentTitle: true,
      summaryText: 'Resumo',
      htmlFormatSummaryText: true,
    );

    try {
      // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final id = 1234;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          "push_notification_driver",
          "push_notification_driver_channel",
          importance: Importance.low,
          priority: Priority.low,
          playSound: false,
          enableVibration: false,
styleInformation: bigTextStyleInformation,
          channelAction: AndroidNotificationChannelAction.update
        ),
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        'Custom Title',
        message,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}