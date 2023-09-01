
import 'package:flutter/material.dart';

import '../constance/color.dart';
import '../constance/message.dart';
import '../utils/style.dart';

class CustomAlertDialog {
  void showAlertDialog({
    required BuildContext context,
    required String textContent,
    required Function() onYesTap,
    required Function() onCancelTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            textContent,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          contentPadding: const EdgeInsets.symmetric(vertical: 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          titleTextStyle: TextStyleConfig.textStyle(fontSize: 18),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onYesTap,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.scaffoldBackGroundColor,
                  ),
                  child: Text(
                    AppMessage.yes,
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.drawerBackGroundColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onCancelTap,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.scaffoldBackGroundColor,
                  ),
                  child: Text(
                    AppMessage.no,
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.drawerBackGroundColor,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
