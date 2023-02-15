import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SPUtils {

  static SPUtils? _instance;

  factory SPUtils() => _instance ??= SPUtils._initial();

  static SharedPreferences? sharedPreferences;

  SPUtils._initial() {
    init();
  }

  static Future<SPUtils?> init() async {
    if(_instance == null) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      _instance = SPUtils._pre(sharedPreferences);
    }
    return _instance;
  }

  SPUtils._pre(SharedPreferences preferences){
    sharedPreferences = preferences;
  }

  static void setString(key, value) {
    sharedPreferences?.setString(key, value);
  }

  static void setStringList(key, value) {
    sharedPreferences?.setStringList(key, value);
  }

  static void setInt(key, value) {
    sharedPreferences?.setInt(key, value);
  }

  static void setDouble(key, value) {
    sharedPreferences?.setDouble(key, value);
  }

  static void setBool(key, value) {
    sharedPreferences?.setBool(key, value);
  }

  static void setJson(key, value) {
    value = jsonEncode(value);
    sharedPreferences?.setString(key, value);
  }

  static T? get<T>(key){
    var result = sharedPreferences?.get(key);
    if(result!=null){
      return result as T;
    }
    return null;
  }

  static Map<String, dynamic>? getJson(key) {
    String? result = sharedPreferences?.getString(key);
    if (null != result) {
      return jsonDecode(result!);
    }
    return null;
  }

  static void clear() {
    sharedPreferences?.clear();
  }

  static void remove(key) {
    sharedPreferences?.remove(key);
  }

  static void reload() {
    sharedPreferences?.reload();
  }
}
