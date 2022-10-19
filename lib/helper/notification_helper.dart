import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/models/restaurant_model.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? __intance;

  NotificationHelper.__interval() {
    __intance = this;
  }

  factory NotificationHelper() => __intance ?? NotificationHelper.__interval();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;
        if (payload != null) {
          log('notification paload: ' + payload);
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurants restaurants) async {
    var channelId = '1';
    var channelName = 'channel_01';
    var channelDescription = 'Restaurant app';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    var titleNotification = "<b>Daily Reminder Restaurant</b>";
    var title = restaurants.name ?? '';

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, title, platformChannelSpecifics,
        payload: jsonEncode(restaurants.toJson()));
  }

  // void configureSelectNotificationSubject(String route) {
  //   selectNotificationSubject.stream.listen(
  //     (String payload) async {
  //       var data = Restaurants.fromJson(json.decode(payload));
  //       var restaurant = data;
  //     },
  //   );
  // }
}
