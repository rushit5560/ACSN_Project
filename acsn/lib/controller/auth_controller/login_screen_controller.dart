import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/home_screen/home_screen.dart';
import '../../utils/user_preference.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxBool isRememberMe = false.obs;

  UserPreference userPreference = UserPreference();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController(text: "abc@gmail.com");
  TextEditingController passwordTextEditingController = TextEditingController(text: "123456789");



  /// When initialize the screen that time getting user details
  Future<void> getUserLoginDetails() async {
    emailTextEditingController.text = await userPreference.getUserLoggedInFromPrefs(key: UserPreference.userEmailKey);
    passwordTextEditingController.text = await userPreference.getUserLoggedInFromPrefs(key: UserPreference.userPasswordKey);
  }

  /// Login time save the user login details
  Future<void> setUserLoginDetails() async {
    await userPreference.setStringValueInPrefs(
      key: UserPreference.userEmailKey,
      value: emailTextEditingController.text.trim().toLowerCase(),
    );
    await userPreference.setStringValueInPrefs(
      key: UserPreference.userPasswordKey,
      value: passwordTextEditingController.text.trim().toLowerCase(),
    );
  }

  /// Login button function
  Future<void> loginFunction() async {
    if(isRememberMe.value == true) {
      await setUserLoginDetails();
    }
    Get.off(() =>  HomeScreen());
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
