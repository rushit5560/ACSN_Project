import 'dart:convert';
import 'dart:developer';
import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:acsn_app/models/start_job_screen_model/job_question_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:acsn_app/constance/api_url.dart';
import 'package:get/get.dart';

import '../models/end_job_question_screen_model/end_job_question_model.dart';

class FinishJobScreenController extends GetxController {
  JobDetails jobDetails = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<QuestionData> jobEndQuestionList = [];

  Headers headers = Headers();

  TextEditingController fieldWorkerNoteController = TextEditingController();
  TextEditingController internalNoteController = TextEditingController();

  Future<void> getFinishJobQuestionFunction() async {
    isLoading(true);
    String url =ApiUrl.getFinishJobQuestionApi;
    log('getFinishJobQuestion Api Url :$url');

    try {
      Map<String, dynamic> bodyData = {
        "JobID": jobDetails.jobId.toString()
      };

      log('BodyData :$bodyData');

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );
      log('jobStatusChange response :${response.body}');

      EndJobQuestionModel endJobQuestionModel = EndJobQuestionModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = endJobQuestionModel.success;

      if(isSuccessStatus.value) {
        jobEndQuestionList.clear();
        jobEndQuestionList.addAll(endJobQuestionModel.data);
        log('jobEndQuestionList Length :${jobEndQuestionList.length}');

      } else {
        log('getFinishJobQuestion Else');
      }


    } catch(e) {
      log('getFinishJobQuestion Error :$e');
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
    log('jobId :${jobDetails.jobId.toString()}');
    await getFinishJobQuestionFunction();
  }

}