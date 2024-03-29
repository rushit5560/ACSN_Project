import 'package:acsn_app/constance/extension.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constance/color.dart';
import '../utils/style.dart';

class CustomSubmitButtonModule extends StatelessWidget {
  Function() onPress;
  String labelText;
  Color buttonColor;
  double? labelSize;
  CustomSubmitButtonModule({
    Key? key,
    required this.onPress,
    required this.labelText,
    this.buttonColor = AppColors.backGroundColor,
    this.labelSize,
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
          child: Text(
            labelText,
            style: TextStyleConfig.textStyle(
              textColor: AppColors.whiteColor,
              fontSize: labelSize ?? 16.sp,
            ),
          ).commonSymmetricPadding(vertical: 10),
        ),
      ),
    );
  }
}
