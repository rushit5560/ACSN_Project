import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constance/api_url.dart';
import '../../models/login_screen_model/field_worker_login_model.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../utils/user_preference.dart';
import '../../utils/userdetails.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxBool isRememberMe = false.obs;
  UserPreference userPreference = UserPreference();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  /// When initialize the screen that time getting user details
  Future<void> getUserLoginDetails() async {
    userNameTextEditingController.text = await userPreference.getStringFromPrefs(key: UserPreference.userNameKey);
    passwordTextEditingController.text = await userPreference.getStringFromPrefs(key: UserPreference.userPasswordKey);
    isRememberMe.value = await userPreference.getBoolFromPrefsIsRemember(key: UserPreference.isRememberKey);

    log("userName : ${UserPreference.username}");
    log("userPassword : ${UserPreference.userPassword}");
    log("isRememberKey : ${UserPreference.isRememberMeValue}");
  }

  // /// Login time save the user login details
  // Future<void> setUserLoginDetails() async {
  //   await userPreference.setStringValueInPrefs(
  //     key: UserPreference.userNameKey,
  //     value: userNameTextEditingController.text.trim().toLowerCase(),
  //   );
  //   await userPreference.setStringValueInPrefs(
  //     key: UserPreference.userPasswordKey,
  //     value: passwordTextEditingController.text.trim().toLowerCase(),
  //   );
  // }

  /// Login button function
  Future<void> loginFunction() async {
    isLoading(true);
    String url = ApiUrl.fieldWorkerLoginOneTimeApi;
    log("loginFunction url : $url");
    try {
      Map<String, dynamic> bodyData = {"UserName": userNameTextEditingController.text.trim(), "Password": passwordTextEditingController.text.trim()};

      http.Response response = await http.post(Uri.parse(url), body: bodyData);

      log("loginFunction responsebody: ${response.body}");

      FieldWorkerLoginModel fieldWorkerLoginModel = FieldWorkerLoginModel.fromJson(json.decode(response.body));

      if (fieldWorkerLoginModel.statusCode == 200) {
        log("loginFunction response.statusCoe: ${response.statusCode}");
        // Check user & pass remember or not
        // isRememberMe.value ? await setUserLoginDetails() : null;

        // // User details saved in prefs
        userPreference.setBoolValueInPrefs(key: UserPreference.isUserLoggedInKey, value: true);
        // userPreference.setBoolValueInPrefs(key: UserPreference.isRememberKey, value: isRememberMe.value);
        userPreference.setStringValueInPrefs(key: UserPreference.userLoginTokenKey, value: fieldWorkerLoginModel.workerList.loginToken);
        userPreference.setStringValueInPrefs(key: UserPreference.fieldWorkerIdKey, value: fieldWorkerLoginModel.workerList.fieldWorkerId.toString());

        userNameTextEditingController.clear();
        passwordTextEditingController.clear();

        if (fieldWorkerLoginModel.workerList.loginToken.isNotEmpty) {
          Get.offAll(() => HomeScreen());
        }
      } else if (fieldWorkerLoginModel.statusCode == 204) {
        Fluttertoast.showToast(msg: "Invalid login credential");
      }
    } catch (e) {
      log("loginFunction error :$e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    await getUserLoginDetails();
  }
}
