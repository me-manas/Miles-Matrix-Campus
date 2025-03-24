import 'dart:convert';
import 'package:matrix_campus/domain/core/local/app_references_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  final SharedPreferences _sharedPreferences;

  AppPreference(this._sharedPreferences);

  String? readString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  Future<bool> setUserInfo(Map<String, dynamic> data) {
    return setString(AppPreferencesKey.user, json.encode(data));
  }

  //
  String? getUserInfo() {
    final user = readString(AppPreferencesKey.user);
    if (user?.isNotEmpty ?? false) {
      return json.encode(user);
    }
    return null;
  }

  Future<bool> clearAll() {
    return _sharedPreferences.clear();
  }

  String? getAccessToken() {
    final token = readString(AppPreferencesKey.accessToken);
    return token;
  }

  bool get userLoginStatus =>
      _sharedPreferences.getString(AppPreferencesKey.accessToken)?.isNotEmpty ??
      false;
}
