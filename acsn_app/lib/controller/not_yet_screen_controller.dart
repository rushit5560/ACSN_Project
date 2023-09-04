import 'dart:convert';
import 'dart:developer';
import 'package:acsn_app/constance/api_url.dart';
import 'package:acsn_app/constance/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../constance/color.dart';
import '../models/job_model.dart';
import '../models/not_yet_booked_models/not_yet_booked_job_model.dart';
import '../models/not_yet_booked_models/save_schedule_model.dart';
import '../utils/style.dart';
import '../utils/user_preference.dart';

class NotYetScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final size = Get.size;

  UserPreference userPreference = UserPreference();
  Headers headers = Headers();
  TextEditingController searchTextEditingController = TextEditingController();
  String fieldWorkerId = "";

  String date = '';
  String timeValue = '';
  DateTime dateTime = DateTime.now();

  List<JobDetails> jobsList = [];

  List<JobModel> jobList = [
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


  Future<void> getNotYetBookedJobsFunction() async {
    isLoading(true);
    String url = ApiUrl.getNotYetBookedApi;
    log('Not yet booked api url : $url');

    try {
      Map<String, String> bodyData = {"FieldWorkerID": fieldWorkerId};

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response :${response.body}');

      NotYetBookedJobModel notYetBookedJobModel = NotYetBookedJobModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = notYetBookedJobModel.success;

      if(isSuccessStatus.value) {
        jobsList.clear();
        jobsList.addAll(notYetBookedJobModel.data);
        log('jobsList Length :${jobsList.length}');
      } else {
        log('getNotYetBookedJobsFunction Else');
      }

    } catch(e) {
      log('getNotYetBookedJobsFunction Error :$e');
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
                    var dateFormat = DateFormat('dd/MM/yyyy').format(value);
                    jobsList[index].startDate = dateFormat;
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
                    jobsList[index].startTime = time;
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
        "jobDate": jobsList[index].startDate,
        "JobTime": jobsList[index].startTime
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
        jobsList[index].changeSchedule = false;
        // Get.back();//todo - When back issue solve then unHide this.
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
        "JobID": jobsList[index].jobId.toString(),
        "FieldWorkerID": fieldWorkerId,
        "FieldWorkerNote": jobsList[index].jobDescription,
        "InternalNote": jobsList[index].specialNotes
      };
      log('Update note body data :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );

      log('updateJobNotes response :${response.body}');
      
      SaveScheduleModel saveScheduleModel =
      SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if (isSuccessStatus.value) {
        Fluttertoast.showToast(msg: "Notes are saved.");
        // Get.back();//todo - When back issue solve then unHide this.
      } else {
        log('saveScheduleFunction Else');
      }

    } catch(e) {
      log('updateJobNotesFunction Error :$e');
      rethrow;
    }
    isLoading(false);
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
    await getNotYetBookedJobsFunction();
  }
}
