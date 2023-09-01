import 'dart:developer';
import 'package:acsn_app/utils/userdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static String isUserLoggedInKey = "isUserLoggedInKey"; // bool
  static String userNameKey = "userNameKey"; // String
  static String userPasswordKey = "userPasswordKey"; // String
  static String userLoginTokenKey = "userLoginTokenKey"; // String
  static String fieldWorkerIdKey = "fieldWorkerIdKey";

  Future<void> setUserDetails({
    required String userName,
    required String userpassword,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userNameKey, userName);
    prefs.setString(userPasswordKey, userpassword);
    UserDetails.username = prefs.getString(userNameKey) ?? "";
    UserDetails.userPassword = prefs.getString(userPasswordKey) ?? "";
    log("userName : ${UserDetails.username}");
    log("userPassword : ${UserDetails.userPassword}");
  }

  Future<void> userAllDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(isUserLoggedInKey);
    prefs.setBool(isUserLoggedInKey, false);
  }

  Future<void> setBoolValueInPrefs(
      {required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    log('prefs value :${prefs.getBool(key)}');
  }

  Future<void> setStringValueInPrefs({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    log('prefs value :${prefs.getString(key)}');
  }

  Future<bool> getBoolFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? true;
    return value;
  }

  Future<String> getStringFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    return value;
  }

  Future<String>  getUserLoggedInFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    return value;
  }


}
