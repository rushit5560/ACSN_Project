import 'dart:convert';
import 'dart:developer';
import 'package:acsn_app/constance/extension.dart';
import 'package:acsn_app/constance/message.dart';
import 'package:acsn_app/controller/home_screen_controller.dart';
import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../constance/api_url.dart';
import '../constance/color.dart';
import '../models/not_yet_booked_models/save_schedule_model.dart';
import '../models/today_job_screen_model/today_job_model.dart';
import '../utils/style.dart';
import '../utils/user_preference.dart';
import 'package:http/http.dart' as http;

class TodayJobsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final size = Get.size;

  final homeScreenController = Get.find<HomeScreenController>();

  UserPreference userPreference = UserPreference();
  Headers headers = Headers();

  String fieldWorkerId = "";

  String date = '';
  String timeValue = '';
  DateTime dateTime = DateTime.now();
  TextEditingController searchTextEditingController = TextEditingController();

  List<JobDetails> todayJobsList = [];

  // Get Current date
  String getCurrentDate() {
    var currentDate = DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.now());
    return currentDate;
  }

  // Get Today's job
  Future<void> getWorkerTodayJobFunction() async {
    isLoading(true);
    String url = ApiUrl.getTodayWorkerJobApi;
    log('Ge Today worker api url :$url');

    try {
      Map<String, dynamic> bodyData = {"FieldWorkerID": fieldWorkerId};

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response :${response.body}');

      TodayJobModel todayJobModel = TodayJobModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = todayJobModel.success;

      if (isSuccessStatus.value) {
        todayJobsList.clear();
        if (todayJobModel.data.isNotEmpty) {
          todayJobsList.addAll(todayJobModel.data);
        }
        log('todayJobsList Length :${todayJobsList.length}');
      } else {
        log('getWorkerTodayJob Else');
      }
    } catch (e) {
      log('getWorkerTodayJob Error :$e');
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
        "jobDate": todayJobsList[index].startDate,
        "JobTime": todayJobsList[index].startTime
      };
      log('bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response12121 :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        todayJobsList[index].changeSchedule = false;
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
        "JobID": todayJobsList[index].jobId.toString(),
        "FieldWorkerID": fieldWorkerId,
        "FieldWorkerNote": todayJobsList[index].description,
        "InternalNote": todayJobsList[index].specialNotes
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
    } catch (e) {
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
      Map<String, String> bodyData = {"JobID": jobId, "FieldWorkerID": fieldWorkerId};
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
        Get.back();
        Fluttertoast.showToast(msg: "Job is canceled");
        await homeScreenController.getTotalJobCountFunction().then((value) {
          Get.back();
          homeScreenController.isLoading(true);
          homeScreenController.isLoading(false);
        });
      } else {
        log('saveScheduleFunction Else');
      }
    } catch (e) {
      log('jobNotRequiredFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  // Change job status
  Future<void> jobStatusChangeFunction({required String jobId, required String jobStatus}) async {
    isLoading(true);
    String url = ApiUrl.updateJobApi;
    log('jobStatusChange Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {
        "JobID": jobId,
        "FieldWorkerID": fieldWorkerId,
        "Status": jobStatus,
        "jobDate": getCurrentDate(),
        "JobCompDetail": "",
        "NoPaymentReason": ""
      };
      log('bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('jobStatusChange response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        await insertFieldWorkerGpsLocationFunction(
          jobId: jobId,
          activity: jobStatus,
        );
      } else {
        log('jobStatusChange Else');
      }
    } catch (e) {
      log('jobStatusChange Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  Future<void> insertFieldWorkerGpsLocationFunction({required String jobId, required String activity}) async {
    isLoading(true);
    String url = ApiUrl.insertGpsLocationApi;
    log('insertFieldWorkerGpsLocation Api Url : $url');

    try {
      Map<String, dynamic> bodyData = {
        "FieldWorkerID": fieldWorkerId,
        "JobID": jobId,
        "Lat": "0",
        "Lng": "0",
        "Time_stamp": getCurrentDate(),
        "Activity": activity == "Push"
            ? "Push"
            : activity == "Started"
                ? AppMessage.resStarted
                : ""
      };

      log('bodyData : $bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('insertFieldWorkerGpsLocation response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;
      if (isSuccessStatus.value) {
        //todo - gps api call
        await getWorkerTodayJobFunction();
      } else {
        log('jobStatusChange Else');
      }
    } catch (e) {
      log('insertFieldWorkerGpsLocation Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  void showDatePicker(ctx, int index) {
    var dateFormat1 = DateFormat('dd/M/yyyy').format(DateTime.now());
    todayJobsList[index].startDate = dateFormat1;
    date = dateFormat1;
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
                  maximumYear: DateTime.now().year + 20,
                  onDateTimeChanged: (DateTime value) {
                    var dateFormat = DateFormat('dd/M/yyyy').format(value);
                    todayJobsList[index].startDate = dateFormat;
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
    // String time1 = DateFormat('hh:mm a').format(DateTime.now());
    // todayJobsList[index].startTime = time1;
    // timeValue = time1;
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
                    todayJobsList[index].startTime = time;
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
    await getWorkerTodayJobFunction();
  }
}
