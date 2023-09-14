import 'dart:convert';
import 'dart:developer';
import 'package:acsn_app/controller/booked_future_jobs_screen_controller.dart';
import 'package:acsn_app/controller/today_jobs_screen_controller.dart';
import 'package:acsn_app/models/not_yet_booked_models/save_schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:acsn_app/constance/api_url.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constance/enums.dart';
import '../constance/message.dart';
import '../models/start_job_screen_model/job_question_model.dart';
import '../utils/user_preference.dart';

class StartJobScreenController extends GetxController {
  String jobId = Get.arguments[0] ?? "";
  ComingFromScreen comingFromScreen = Get.arguments[1] ?? ComingFromScreen.todayJobs;
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  String fieldWorkerId = "";
  UserPreference userPreference = UserPreference();


  RxBool isDDLoading = false.obs;
  RxBool isRadioLoading = false.obs;

  Headers headers = Headers();
  List<QuestionData> questionList = [];

  String getCurrentDate() {
    var currentDate =  DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.now());
    return currentDate;
  }

  Future<void> getJobQuestionFunction() async {
    isLoading(true);
    String url = ApiUrl.getJobQuestionApi;
    log('getJobQuestion Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {
        "JobID": jobId
      };
      log('Job Question bodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('getJobQuestion response :${response.body}');

      JobQuestionModel startJobModel = JobQuestionModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = startJobModel.success;

      if(isSuccessStatus.value) {
        questionList.clear();
        if(startJobModel.data.isNotEmpty) {
          questionList.addAll(startJobModel.data);
        }
        log('questionList Length :${questionList.length}');
      } else {
        log('getJobQuestion Else');
      }


    } catch(e) {
      log('getJobQuestion Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  Future<void> insertJobQuestionAnswerFunction() async {
    isLoading(true);
    String url = ApiUrl.insertJobQuestionAnswerApi;
    log('insertJobQuestionAnswer Api Url :$url');

    try {
      var questionAnswerList = [];
      for(var element in questionList) {
        var singleItem = {
          "JobQuestionID": element.jobQuestionId.toString(),
          "Answer": element.answer,
          "FieldWorkerID": fieldWorkerId,
          "CreatedOn" : getCurrentDate()
        };
        questionAnswerList.add(singleItem);
      }
      log('questionAnswerList : $questionAnswerList');

      Map<String, dynamic> bodyData = {
        "objSQAList" : questionAnswerList,
        "Type": "Start",
        "JobID": jobId,
        "ClientSignature" : ""
      };
      log('bodyData :${jsonEncode(bodyData)}');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader2(),
        body: json.encode(bodyData),
      );

      log('insertJobQuestionAnswer response :${response.body}');

      SaveScheduleModel saveScheduleModel = SaveScheduleModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = saveScheduleModel.success;

      if(isSuccessStatus.value) {
        // here call update job status api
        await jobStatusChangeFunction(jobStatus: AppMessage.startedStatus);
      } else {
        log('insertJobQuestionAnswer  Else');
      }
    } catch(e) {
      log('insertJobQuestionAnswer Error :$e');
      rethrow;
    }

  }

  // Change job status
  Future<void> jobStatusChangeFunction({required String jobStatus}) async {
    isLoading(true);
    String url = ApiUrl.updateJobApi;
    log('jobStatusChange Api Url :$url');

    try {

      Map<String, dynamic> bodyData = {
        "JobID": jobId,
        "FieldWorkerID": fieldWorkerId,
        "Status": jobStatus,
        "jobDate": getCurrentDate(),
        "JobCompDetail" : "",
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

      if(isSuccessStatus.value) {
        await insertFieldWorkerGpsLocationFunction(
          jobId: jobId,
          activity: jobStatus,
        );
      } else {
        log('jobStatusChange Else');
      }
    } catch(e) {
      log('jobStatusChange Error :$e');
      rethrow;
    }
    // isLoading(false);
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
      if(isSuccessStatus.value) {
        //todo - below code uncomment
        Get.back();
        if(comingFromScreen == ComingFromScreen.todayJobs) {
          final todayJobsScreenController = Get.find<TodayJobsScreenController>();
          await todayJobsScreenController.initMethod();
        } else if(comingFromScreen == ComingFromScreen.futureJobs) {
          final bookedFutureJobsScreenController = Get.find<BookedFutureJobsScreenController>();
          await bookedFutureJobsScreenController.initMethod();
        }
      } else {
        log('jobStatusChange Else');
      }
    } catch(e) {
      log('insertFieldWorkerGpsLocation Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    log('jobId: $jobId');
    fieldWorkerId = await userPreference.getStringFromPrefs(key: UserPreference.fieldWorkerIdKey);
    await getJobQuestionFunction();
  }

  ddLoad() {
    isDDLoading(true);
    isDDLoading(false);
  }
  radioLoad() {
    isRadioLoading(true);
    isRadioLoading(false);
  }

}