import 'dart:convert';
import 'dart:developer';
import 'package:acsn_app/constance/api_url.dart';
import 'package:acsn_app/constance/extension.dart';
import 'package:acsn_app/controller/home_screen_controller.dart';
import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../constance/color.dart';
import '../models/booked_future_job_screen_model/booked_future_job_model.dart';
import '../models/not_yet_booked_models/save_schedule_model.dart';
import '../utils/style.dart';
import 'package:http/http.dart' as http;

import '../utils/user_preference.dart';
class BookedFutureJobsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final size = Get.size;

  final homeScreenController = Get.find<HomeScreenController>();

  String date = '';
  String timeValue = '';
  DateTime dateTime = DateTime.now();

  String fieldWorkerId = "";
  UserPreference userPreference = UserPreference();
  Headers headers = Headers();

  TextEditingController searchTextEditingController = TextEditingController();

  List<JobDetails> bookedFutureJobsList = [];


  // Get booked future jobs list function
  Future<void> getWorkerBookedFutureJobsFunction() async {
    isLoading(true);
    String url = ApiUrl.getBookedFutureJobsApi;
    log('Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"FieldWorkerID": fieldWorkerId};


      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response :${response.body}');

      BookedFutureJobsModel bookedFutureJobsModel = BookedFutureJobsModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = bookedFutureJobsModel.success;

      if(isSuccessStatus.value) {
        bookedFutureJobsList.clear();
        if(bookedFutureJobsModel.data.isNotEmpty) {
          bookedFutureJobsList.addAll(bookedFutureJobsModel.data);
        }
        log('bookedFutureJobsList Length :${bookedFutureJobsList.length}');

      } else {
        log('getWorkerBookedFutureJobs Else');
      }

    } catch(e) {
      log('getWorkerBookedFutureJobs Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  // Save job date & time
  Future<void> saveScheduleFunction({
    required String jobId,
    required int index,
  }) async {
    isLoading(true);
    String url = ApiUrl.saveScheduleApi;
    log('saveSchedule Api Url :$url');

    try {
      Map<String, String> bodyData = {
        "JobID": jobId,
        "FieldWorkerID": fieldWorkerId,
        "jobDate": bookedFutureJobsList[index].startDate,
        "JobTime": bookedFutureJobsList[index].startTime
      };
      log('bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response12121 :${response.body}');

      SaveScheduleModel saveScheduleModel =
      SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        bookedFutureJobsList[index].changeSchedule = false;
        await homeScreenController.getTotalJobCountFunction().then((value) {
          Get.back();
          homeScreenController.isLoading(true);
          homeScreenController.isLoading(false);
        });
        // Get.back();
      } else {
        log('saveScheduleFunction Else');
      }
    } catch (e) {
      log('saveScheduleFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  // Update job notes
  Future<void> updateJobNotesFunction(int index) async {
    isLoading(true);
    String url = ApiUrl.updateJobNoteApi;
    log('updateJobNotesFunction Api Url : $url');

    try {
      Map<String, dynamic> bodyData = {
        "JobID": bookedFutureJobsList[index].jobId.toString(),
        "FieldWorkerID": fieldWorkerId,
        "FieldWorkerNote": bookedFutureJobsList[index].jobDescription,
        "InternalNote": bookedFutureJobsList[index].specialNotes
      };
      log('Update note body data :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );

      log('updateJobNotes response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: "Notes are saved.");
      } else {
        log('saveScheduleFunction Else');
      }

    } catch(e) {
      log('updateJobNotesFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  // Job not require
  Future<void> jobNotRequiredFunction({required String jobId}) async {
    isLoading(true);
    String url = ApiUrl.jobNoteRequiredApi;
    log('Job not required api url :$url');

    try {
      Map<String, String> bodyData = {
        "JobID": jobId,
        "FieldWorkerID": fieldWorkerId
      };
      log('bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('job not required response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: "Job is canceled");
      } else {
        log('saveScheduleFunction Else');
      }

    } catch(e) {
      log('jobNotRequiredFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  void showDatePicker(ctx, int index) {
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
                    bookedFutureJobsList[index].startDate = dateFormat;
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

  void showTimePicker(ctx, int index) {
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
                    bookedFutureJobsList[index].startTime = time;
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

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    isLoading(true);
    fieldWorkerId = await userPreference.getStringFromPrefs(key: UserPreference.fieldWorkerIdKey);
    log('fieldWorkerId:$fieldWorkerId');
    await getWorkerBookedFutureJobsFunction();
  }

}
