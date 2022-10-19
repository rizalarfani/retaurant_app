import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      notifyListeners();
    } else {
      notifyListeners();
    }
    return true;
  }

  getScheduling() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isScheduling = sharedPreferences.getBool(themeKey)!;
    notifyListeners();
  }
}
