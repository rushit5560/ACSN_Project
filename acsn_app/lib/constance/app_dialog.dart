import 'dart:ui';

import 'package:acsn_app/constance/color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppDialogs {
  static jobNotRequiredDialog(BuildContext context, {required VoidCallback yesOnTap}) {
    return Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: AppColors.whiteColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          clipBehavior: Clip.antiAlias,
          // insetPadding: EdgeInsets.all(16.w),
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.w, bottom: 16 / 2),
                child: Text(
                  "Confirm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.w).copyWith(top: 15, bottom: 5),
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp, /*fontFamily: AppStyle.fontFamilyName, height: 1.5*/
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Hey 👋 ',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                          ),
                          // TextSpan(
                          //   text: "${LocalStorage.firstName} ${LocalStorage.lastName}, ",
                          //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                          // ),
                          TextSpan(
                            text: 'Are you sure this',
                            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                          ),
                          TextSpan(
                            text: ' job ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColors.backGroundColor,
                            ),
                          ),
                          TextSpan(
                            text: 'is not required?',
                            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 50,
                            // padding: EdgeInsets.symmetric(vertical: 16.w - 5),
                            color: const Color(0xffF2F2F2),
                            child: Center(
                              child: Text(
                                'No',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: yesOnTap,
                          child: Container(
                            height: 50,
                            // padding: EdgeInsets.symmetric(vertical: 16.w - 5),
                            color: AppColors.backGroundColor,
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static logOutDialog(BuildContext context, {required VoidCallback yesOnTap}) {
    return Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Dialog(
          backgroundColor: AppColors.whiteColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          clipBehavior: Clip.antiAlias,
          // insetPadding: EdgeInsets.all(16.w),
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.w, bottom: 16 / 2),
                child: Text(
                  "LOGOUT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.w).copyWith(top: 15, bottom: 5),
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp, /*fontFamily: AppStyle.fontFamilyName, height: 1.5*/
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Hey 👋 ',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                          ),
                          // TextSpan(
                          //   text: "${LocalStorage.firstName} ${LocalStorage.lastName}, ",
                          //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
                          // ),
                          TextSpan(
                            text: 'Are you sure you want to',
                            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                          ),
                          TextSpan(
                            text: ' logout ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColors.backGroundColor,
                            ),
                          ),
                          TextSpan(
                            text: '?',
                            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 50,
                            // padding: EdgeInsets.symmetric(vertical: 16.w - 5),
                            color: const Color(0xffF2F2F2),
                            child: Center(
                              child: Text(
                                'No',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: yesOnTap,
                          child: Container(
                            height: 50,
                            // padding: EdgeInsets.symmetric(vertical: 16.w - 5),
                            color: AppColors.backGroundColor,
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
