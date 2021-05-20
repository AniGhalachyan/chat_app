import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sheredPreferencUserLoggedInKey = "ISLOGGEDIN";
  static String sheredPreferencUserNameKey = "USERNAMEKEY";
  static String sheredPreferencUserEmailKey = "USEREEMAILKEY";
  static String sheredPreferencUserImageKey = "USERIMAGEKEY";

  static Future<bool> saveUserLoggedInShP(bool isUserLOggedIN) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setBool(sheredPreferencUserLoggedInKey, isUserLOggedIN);
  }

  static Future<bool> saveUserNameShP(String isUserName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString(sheredPreferencUserNameKey, isUserName);
  }

  static Future<bool> saveUserEmailShP(String isUserEmail) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString(sheredPreferencUserEmailKey, isUserEmail);
  }

  static Future<bool> saveUserImagelShP(String isUserImage) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setString(sheredPreferencUserEmailKey, isUserImage);
  }

  static Future<bool> getUserLoggedInShP() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(sheredPreferencUserLoggedInKey);
  }

  static Future<String> getUserNameShP() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(sheredPreferencUserNameKey);
  }

  static Future<String> getUserEmailShP() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(sheredPreferencUserEmailKey);
  }

  static Future<String> getUserImageShP() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(sheredPreferencUserImageKey);
  }
}
