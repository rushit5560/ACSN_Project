import 'dart:convert';
import 'dart:developer';
import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:acsn_app/constance/api_url.dart';
import 'package:get/get.dart';

import '../models/completed_jobs_screen_model/completed_job_details_model.dart';
import '../models/completed_jobs_screen_model/completed_job_question_answer_model.dart';

class CompletedJobDetailsScreenController extends GetxController {
  String jobId = Get.arguments[0] ?? "";

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  Headers headers = Headers();
  JobDatum? jobDetails;
  List<JobQA> startQuestionList = [];
  List<JobQA> endQuestionList = [];

  Future<void> getCompletedJobDetailsFunction() async {
    isLoading(true);
    String url = ApiUrl.completedJobDetailsApi;
    log('getCompletedJobDetails Api Url : $url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobId};
      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('response :${response.body}');

      CompletedJobDetailsModel completedJobDetailsModel = CompletedJobDetailsModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = completedJobDetailsModel.success;

      if(isSuccessStatus.value) {
        jobDetails = completedJobDetailsModel.data[0];
      } else {
        log('getCompletedJobDetails Else');
      }
    } catch(e) {
      log('getCompletedJobDetails Error :$e');
      rethrow;
    }
    // isLoading(false);
    await getJobQuestionAndAnswerFunction();
  }

  Future<void> getJobQuestionAndAnswerFunction() async {
    isLoading(true);
    String url = ApiUrl.completedJobQAndAApi;
    log('getJobQuestionAndAnswer Api Url : $url');

    try {
      Map<String, dynamic> bodyData = {"JobID": jobId};
      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      // log('getJobQuestionAndAnswer response :${response.body}');

      CompletedJobQuestionAnswerModel completedJobQuestionAnswerModel = CompletedJobQuestionAnswerModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = completedJobQuestionAnswerModel.success;

      if(isSuccessStatus.value) {
        startQuestionList.clear();
        endQuestionList.clear();

        if(completedJobQuestionAnswerModel.data.isNotEmpty) {
          for(var item in completedJobQuestionAnswerModel.data) {
            if(item.isStart == true) {
              startQuestionList.add(item);
            } else {
              endQuestionList.add(item);
            }
          }
        }

        log('startQuestionList Length : ${startQuestionList.length}');
        log('endQuestionList Length : ${endQuestionList.length}');

      } else {
        log('getJobQuestionAndAnswer Else');
      }

    } catch(e) {
      log('getJobQuestionAndAnswer Error :$e');
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
    await getCompletedJobDetailsFunction();
  }
}