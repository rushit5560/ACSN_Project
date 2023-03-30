import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/job_model.dart';

class BookedDatePassedScreenController extends GetxController {
  RxBool isLoading = false.obs;
  final size = Get.size;
  String date = '';
  String timeValue = '';
  DateTime dateTime = DateTime.now();
  RxString datePassingvalue = ''.obs;
  RxString selectedDobNumber = "Select Date Of Birth".obs;

  TextEditingController searchTextEditingController = TextEditingController();

  List<JobModel> bookedDatePassedList = [
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
        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    isLoading(true);
                    var dateFormat = DateFormat('dd/M/yyyy').format(value);
                    date = dateFormat;
                    log("date $date");
                    isLoading(false);
                  },
                )),
            // Close the modal
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
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
                  initialDateTime: DateTime.now(),
                  // maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime dateTime) {
                    isLoading(true);
                    dateTime = dateTime;
                    isLoading(false);
                    log("_dateTime: $dateTime");
                  },
                )),
            // Close the modal
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
