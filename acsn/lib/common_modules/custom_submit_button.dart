import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomSubmitButtonModule extends StatelessWidget {
  Function() onPress;
  String labelText;
  Color buttonColor;
  CustomSubmitButtonModule({
    Key? key,
    required this.onPress,
    required this.labelText,
    this.buttonColor = AppColors.buttonColor,
  }) : super(key: key);
  // final locationManageScreenController = Get.find<LocationManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        // height: 50,
        width: Get.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
          onPressed: onPress,
          /*onPressed: () async {
            if (locationManageScreenController.formKey.currentState!
                .validate()) {
              if (locationManageScreenController.locationOption ==
                  LocationOption.create) {
                if (locationManageScreenController
                    .selectedValue.value ==
                    AppMessage.chooseOption) {
                  Fluttertoast.showToast(msg: "Please select status");
                } else {
                  await locationManageScreenController
                      .locationCreateFunction();
                }
              } else {
                await locationManageScreenController
                    .locationUpdateFunction();
              }
            }
          },*/
          child: Text(
            labelText,
            style: TextStyleConfig.textStyle(
              textColor: AppColors.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ).commonSymmetricPadding(vertical: 10),
        ),
      ),
    );
  }
}
