import 'dart:convert';
import 'dart:developer';

import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constance/api_url.dart';
import '../models/completed_jobs_screen_model/completed_jobs_model.dart';
import '../utils/user_preference.dart';

class CompletedJobScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();
  Headers headers = Headers();

  String fieldWorkerId = "";

  List<JobDetails> completedJobList = [];

  RxBool isPreviousButtonShow = true.obs;


  Future<void> getWorkerFinishJobFunction() async {
    isLoading(true);
    String url = ApiUrl.completedJobApi;
    log('getWorkerFinishJob Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"FieldWorkerID": fieldWorkerId};

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response :${response.body}');

      CompletedJobsModel completedJobsModel = CompletedJobsModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = completedJobsModel.success;

      if(isSuccessStatus.value) {
        completedJobList.clear();
        if(completedJobsModel.data.isNotEmpty) {
          // completedJobList.addAll(completedJobsModel.data);
        }
        log('completedJobList length : ${completedJobList.length}');
      } else {
        log('getWorkerFinishJob Else');
      }

    } catch(e) {
      log('getWorkerFinishJob Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  Future<void> getPreviousWeekCompletedJobFunction() async {
    isLoading(true);
    String url = ApiUrl.previousCompletedJobAPi;
    log('getPreviousWeekCompletedJob Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {"FieldWorkerID": fieldWorkerId};

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response :${response.body}');

      CompletedJobsModel completedJobsModel = CompletedJobsModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = completedJobsModel.success;

      if(isSuccessStatus.value) {
        isPreviousButtonShow(false);
        completedJobList.clear();
        if(completedJobsModel.data.isNotEmpty) {
          completedJobList.addAll(completedJobsModel.data);
        }
        log('completedJobList length : ${completedJobList.length}');
      } else {
        log('getWorkerFinishJob Else');
      }
    } catch(e) {
      log('getPreviousWeekCompletedJob Error :$e');
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
    isLoading(true);
    fieldWorkerId = await userPreference.getStringFromPrefs(key: UserPreference.fieldWorkerIdKey);
    log('fieldWorkerId:$fieldWorkerId');
    await getWorkerFinishJobFunction();
  }


}