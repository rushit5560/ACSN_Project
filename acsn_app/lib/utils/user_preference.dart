import 'dart:developer';
import 'package:acsn_app/utils/userdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static String isUserLoggedInKey = "isUserLoggedInKey"; // bool
  static String isRememberKey = "isRememberKey"; // bool
  static String userNameKey = "userNameKey"; // String
  static String userPasswordKey = "userPasswordKey"; // String
  static String userLoginTokenKey = "userLoginTokenKey"; // String
  static String fieldWorkerIdKey = "fieldWorkerIdKey";

  static String username = "";
  static String userPassword = "";
  static bool isRememberMeValue = false;

  Future<void> setUserDetails({
    required String userName,
    required String userpassword,
    required bool isRememberMe,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, userName);
    await prefs.setString(userPasswordKey, userpassword);
    await prefs.setBool(isRememberKey, isRememberMe);
    username = prefs.getString(userNameKey) ?? "";
    userPassword = prefs.getString(userPasswordKey) ?? "";
    isRememberMeValue = prefs.getBool(isRememberKey) ?? false;
    log("userName : $username");
    log("userPassword : $userPassword");
    log("isRememberKey : $isRememberMeValue");
  }

  // Future<void> removeUserDetails() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // await prefs.remove(userNameKey);
  //   // await prefs.remove(userPasswordKey);
  //   // await prefs.remove(isRememberKey);
  //
  //   username = "";
  //   userPassword = "";
  //   isRememberMeValue = false;
  //
  //   log("userName : $username");
  //   log("userPassword : $userPassword");
  //   log("isRememberKey : $isRememberMeValue");
  // }

  Future<void> removeUserDetails({
    required bool isRememberMe,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, "");
    await prefs.setString(userPasswordKey, "");
    await prefs.setBool(isRememberKey, isRememberMe);
    username = prefs.getString(userNameKey) ?? "";
    userPassword = prefs.getString(userPasswordKey) ?? "";
    isRememberMeValue = prefs.getBool(isRememberKey) ?? false;
    log("userName : $username");
    log("userPassword : $userPassword");
    log("isRememberKey : $isRememberMeValue");
  }

  Future<void> userAllDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(isUserLoggedInKey);
    prefs.setBool(isUserLoggedInKey, false);
  }

  Future<void> userAllDataRemoveFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isUserLoggedInKey, false);
    prefs.remove(userLoginTokenKey);
    prefs.remove(fieldWorkerIdKey);
  }

  Future<void> setBoolValueInPrefs({required String key, required bool value}) async {
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

  Future<bool> getBoolFromPrefsIsRemember({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? false;
    return value;
  }

  Future<String> getStringFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    return value;
  }

  Future<String> getUserLoggedInFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    return value;
  }

  static Future<void> readDataInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString(userNameKey) ?? "";
    userPassword = prefs.getString(userPasswordKey) ?? "";
    isRememberMeValue = prefs.getBool(isRememberKey) ?? false;
    log("userName : ${username}");
    log("userPassword : ${userPassword}");
    log("isRememberKey : ${isRememberMeValue}");
  }
}
