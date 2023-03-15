import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/constants/preferences_constants.dart';

class PreferenceObj {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return;
  }

  static Future<bool> clearPreferenceDataAndLogout() async {
    return await _sharedPreferences.clear();
  }

  static bool get getIsLogin =>
      _sharedPreferences.getBool(
        PreferencesConstants.isLogin,
      ) ??
      false;

  static Future<bool> setIsLogin({required bool isLoggedIn}) async =>
      _sharedPreferences.setBool(
        PreferencesConstants.isLogin,
        isLoggedIn,
      );

  static String? get getName =>
      _sharedPreferences.getString(PreferencesConstants.name);

  static Future<bool> setName({required String name}) async {
    return await _sharedPreferences.setString(
      PreferencesConstants.name,
      name,
    );
  }

  static String? get getUserId =>
      _sharedPreferences.getString(PreferencesConstants.userId);

  static Future<bool> setUserId({required String userId}) async {
    return await _sharedPreferences.setString(
      PreferencesConstants.userId,
      userId,
    );
  }

  static String? get getEmailId =>
      _sharedPreferences.getString(PreferencesConstants.emailId);

  static Future<bool> setEmailId({required String emailId}) async {
    return await _sharedPreferences.setString(
      PreferencesConstants.emailId,
      emailId,
    );
  }

  static String? get getProfileUrl =>
      _sharedPreferences.getString(PreferencesConstants.profileUrl);

  static Future<bool> setProfileUrl({required String profileUrl}) async {
    return await _sharedPreferences.setString(
      PreferencesConstants.profileUrl,
      profileUrl,
    );
  }
}
