import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isPrivacyChecked = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController(text: "abc@gmail.com");
  TextEditingController passwordTextEditingController = TextEditingController(text: "123456789");

}
