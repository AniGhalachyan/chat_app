import 'package:chat_app/values/theme.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData themeData;
  Color background = Colors.white;

  ThemeNotifier({this.themeData});

  getTheme() => themeData;

  setTheme(ThemeData darkLightThem) async {
    if (darkLightThem == darkTheme) {
      background = Colors.black;
    } else {
      background = Colors.white;
    }
    themeData = darkLightThem;
    notifyListeners();
  }
}
