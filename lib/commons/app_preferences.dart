import 'package:api_dictionary/commons/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{
  AppPreferences._();

  static late SharedPreferences _preferences;

  /// Initialization before using
  static Future<void> initialize() async{
    _preferences = await SharedPreferences.getInstance();
  }

  static set recentWordsList(String stringObjects) => setData<String>(AppConstants.recentWordsList, stringObjects);

  static String get recentWordsList => getData(AppConstants.recentWordsList);

  /// Set SharedPreference data method
  static Future<void> setData<T>(String key, dynamic value) async{
    switch(T){
      case String:
        await _preferences.setString(key, value);
        break;
      case int:
        await _preferences.setInt(key, value);
        break;
      case double:
        await _preferences.setDouble(key, value);
        break;
      case bool:
        await _preferences.setBool(key, value);
        break;
    }
  }

  /// Get SharedPreference data method
  static T getData<T>(String key){
    dynamic data;
    switch(T){
      case String:
        data = _preferences.getString(key) ?? '';
        break;
      case int:
        data = _preferences.getInt(key) ?? -1;
        break;
      case double:
        data = _preferences.getDouble(key) ?? 0.0;
        break;
      case bool:
        data = _preferences.getBool(key) ?? false;
        break;
    }
    return data as T;
  }

  static void clearAll() => _preferences.clear();
}