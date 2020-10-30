import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final setLightTheme = _buildLightTheme();
final setDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  return ThemeData(
    buttonColor: Colors.white,
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xff333333),
    accentColor: Colors.cyan,
    indicatorColor: Colors.cyanAccent,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData(
    buttonColor: Color(0xff333333),
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xffDDDDDD),
    accentColor: Colors.green,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );
}
