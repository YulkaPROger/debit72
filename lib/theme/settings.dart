import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Класс, содержащий все настройки приложения
/// На данный момент состоит только из настроек темы
class Settings extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  Settings(this.sharedPreferences);

  bool get isDarkMode => sharedPreferences?.getBool("isDarkMode") ?? false;

  void setDarkMode(bool val) {
    sharedPreferences?.setBool("isDarkMode", val);
    notifyListeners();
  }
}
