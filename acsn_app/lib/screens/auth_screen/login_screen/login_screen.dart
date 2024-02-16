import 'package:acsn_app/common_widgets/custom_loader.dart';
import 'package:acsn_app/utils/userdetails.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:acsn_app/constance/extension.dart';
import 'package:flutter/material.dart';
import '../../../common_modules/auth_screen_text_field.dart';
import '../../../common_modules/custom_submit_button.dart';
import '../../../constance/app_images.dart';
import '../../../constance/color.dart';
import '../../../constance/message.dart';
import '../../../controller/auth_controller/login_screen_controller.dart';
import '../../../utils/field_validator.dart';
import '../../../utils/style.dart';

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

        body: Obx(
          () => loginScreenController.isLoading.value
              ? const CustomLoader()
              : Form(
                  key: loginScreenController.formKey,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Image.asset(AppImages.logoImage).commonSymmetricPadding(horizontal: 5.w),
                        SizedBox(height: 10.h),
                        TextFieldModule(
                          fieldController: loginScreenController.userNameTextEditingController,
                          hintText: AppMessage.userName,
                          keyboardType: TextInputType.text,
                          suffixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.backGroundColor,
                          ),
                          validate: (value) => FieldValidator().validateName(value!),
                        ),
                        SizedBox(height: 4.h),
                        Obx(
                          () => TextFieldModule(
                            obscureText: loginScreenController.isPasswordVisible.value,
                            fieldController: loginScreenController.passwordTextEditingController,
                            hintText: AppMessage.password,
                            keyboardType: TextInputType.text,
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginScreenController.isPasswordVisible.value = !loginScreenController.isPasswordVisible.value;
                              },
                              icon: Icon(
                                loginScreenController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.backGroundColor,
                              ),
                            ),
                            validate: (value) => FieldValidator().validatePassword(value!),
                          ),
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                activeColor: AppColors.backGroundColor,
                                value: loginScreenController.isRememberMe.value,
                                onChanged: (bool? value) async {
                                  loginScreenController.isRememberMe.value = value!;
                                  if (loginScreenController.isRememberMe.value == true) {
                                    await loginScreenController.userPreference.setUserDetails(
                                        userName: loginScreenController.userNameTextEditingController.text.trim(),
                                        userpassword: loginScreenController.passwordTextEditingController.text.trim(),
                                        isRememberMe: loginScreenController.isRememberMe.value);
                                  } else {
                                    await loginScreenController.userPreference
                                        .removeUserDetails(isRememberMe: loginScreenController.isRememberMe.value);
                                  }
                                },
                              ),
                            ),
                            Text(
                              AppMessage.rememberMe,
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
                            if (loginScreenController.formKey.currentState!.validate()) {
                              await loginScreenController.loginFunction();
                            }
                          },
                        ).commonSymmetricPadding(horizontal: 8.w)
                      ],
                    ).commonOnlyPadding(left: 20, right: 20, top: 10.h),
                  ),
                ),
        ),
      ),
    );
  }
}
