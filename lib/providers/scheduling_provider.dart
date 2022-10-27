import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/service/service_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  SchedulingProvider() {
    getScheduling();
  }

  static const themeKey = 'sheduling_key';

  bool _isScheduling = false;
  bool get isScheduling => _isScheduling;

  Future<bool> schedulingActived(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isScheduling = value;
    sharedPreferences.setBool(themeKey, value);
    if (_isScheduling) {
      log('Scheduling Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Scheduling Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  getScheduling() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isScheduling = sharedPreferences.getBool(themeKey) ?? false;
    notifyListeners();
  }
}
