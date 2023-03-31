import 'dart:developer';

import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/models/job_model.dart';
import 'package:acsn/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class BookedFutureJobsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  final size = Get.size;

  String date = '';
  String timeValue = '';
  DateTime dateTime = DateTime.now();

  TextEditingController searchTextEditingController = TextEditingController();

  List<JobModel> bookedFutureJobsList = [
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
  ];
  void showDatePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: size.height * 0.4,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
                height: size.height * 0.32,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  minimumYear: 1940,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime value) {
                    var dateFormat = DateFormat('dd/M/yyyy').format(value);
                    date = dateFormat;
                    isLoading(true);
                    isLoading(false);
                    log("date $date");
                  },
                )),
            // Close the modal
            TextButton(
              child: Text(
                'OK',
                style: TextStyleConfig.textStyle(
                  textColor: AppColors.drawerBackGroundColor,
                  fontSize: 15.sp,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ).commonSymmetricPadding(horizontal: 10, vertical: 15),
    );
  }

  void showTimePicker(ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: size.height * 0.4,
        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
                height: size.height * 0.32,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  // use24hFormat: true,
                  initialDateTime: dateTime,
                  // maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime dateTimevalue) {
                    log("dateTimevalue: $dateTimevalue");
                    String time = DateFormat('hh:mm a').format(dateTimevalue);
                    timeValue = time;
                    isLoading(true);
                    isLoading(false);

                    log('time : $timeValue');
                  },
                )),
            // Close the modal
            TextButton(
              child: Text(
                'OK',
                style: TextStyleConfig.textStyle(
                  textColor: AppColors.drawerBackGroundColor,
                  fontSize: 15.sp,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ).commonSymmetricPadding(horizontal: 10, vertical: 15),
    );
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
