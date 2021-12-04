import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;


class PreferenceUtils {

  static Future<SharedPreferences> get _instance async => _prefsInstance = await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;
  static late PreferenceUtils _preferenceUtils;

  static Future<PreferenceUtils> init() async {
    _prefsInstance = await _instance;
    _preferenceUtils = PreferenceUtils();
    return _preferenceUtils;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance.getBool(key) ?? defValue ?? false;
  }

  static bool containsKey(String key) {
    return _prefsInstance.containsKey(key);
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefsInstance.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefsInstance.setBool(key, value);
  }

  static Future<bool> removeKey(String key) async {
    return await _prefsInstance.remove(key);
  }

  static List<String> getKeys() {
    return _prefsInstance.getKeys().toList();
  }
}