import 'package:acsn/common_modules/auth_screen_text_field.dart';
import 'package:acsn/common_modules/custom_submit_button.dart';
import 'package:acsn/constance/app_images.dart';
import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/constance/message.dart';
import 'package:acsn/controller/auth_controller/login_screen_controller.dart';
import 'package:acsn/screens/home_screen/home_screen.dart';
import 'package:acsn/utils/field_validator.dart';
import 'package:acsn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginScreenController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: AppColors.scaffoldBackGroundColor,

        body: Form(
          key: loginScreenController.formKey,
          child: Column(
            children: [
              Image.asset(AppImages.logoImage)
                  .commonSymmetricPadding(horizontal: 5.w),
              SizedBox(height: 10.h),
              TextFieldModule(
                fieldController:
                    loginScreenController.emailTextEditingController,
                hintText: 'Email address',
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.backGroundColor,
                ),
                validate: (value) => FieldValidator().validateEmail(value!),
              ),
              SizedBox(height: 4.h),
              Obx(
                () => TextFieldModule(
                  obscureText: loginScreenController.isPasswordVisible.value,
                  fieldController:
                      loginScreenController.passwordTextEditingController,
                  hintText: 'Password',
                  keyboardType: TextInputType.text,
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginScreenController.isPasswordVisible.value =
                          !loginScreenController.isPasswordVisible.value;
                    },
                    icon: Icon(
                      loginScreenController.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.backGroundColor,
                    ),
                  ),
                  validate: (value) =>
                      FieldValidator().validatePassword(value!),
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: AppColors.backGroundColor,
                      value: loginScreenController.isRememberMe.value,
                      onChanged: (bool? value) {
                        loginScreenController.isRememberMe.value = value!;
                      },
                    ),
                  ),
                  Text(
                    "Remember Me?",
                    style: TextStyleConfig.textStyle(
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
              SizedBox(height: 4.h),
              CustomSubmitButtonModule(
                labelText: AppMessage.login,
                onPress: () async {
                  if (loginScreenController.formKey.currentState!
                      .validate()) {
                    await loginScreenController.loginFunction();
                  }
                },
              ).commonSymmetricPadding(horizontal: 8.w)
            ],
          ).commonOnlyPadding(left: 20, right: 20, top: 10.h),
        ),
      ),
    );
  }
}
