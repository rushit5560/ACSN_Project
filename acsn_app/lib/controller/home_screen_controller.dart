import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:acsn_app/constance/api_url.dart';
import 'package:acsn_app/utils/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/home_screen_model/job_count_model.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  UserPreference userPreference = UserPreference();
  Headers headers = Headers();
  String fieldWorkerId = "";

  RxInt notYetBookedCount = 0.obs;
  RxInt bookedFutureJobsCount = 0.obs;
  RxInt todayJobCount = 0.obs;
  RxInt bookedDatePassedCount = 0.obs;

  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> getTotalJobCountFunction() async {
    isLoading(true);
    String url = ApiUrl.getTotalJobCountApi;
    log('Get Total job count api url :$url');

    try {
      Map<String, String> bodyData = {"FieldWorkerID": fieldWorkerId};

      final response = await http.post(
        Uri.parse(url),
        headers: await headers.getHeader(),
        body: bodyData,
      );

      log('response :${response.body}');

      JobCountModel jobCountModel = JobCountModel.fromJson(json.decode(response.body));
      isSuccessStatus.value = jobCountModel.success;

      if (isSuccessStatus.value) {
        notYetBookedCount.value = jobCountModel.data.newCount;
        bookedFutureJobsCount.value = jobCountModel.data.scheduledCount;
        todayJobCount.value = jobCountModel.data.todayCount;
        bookedDatePassedCount.value = jobCountModel.data.pendingCount;
      } else {
        log('getTotalJobCountFunction Else');
      }
    } catch (e) {
      log('getTotalJobCountFunction Error :$e');
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
    fieldWorkerId = await userPreference.getStringFromPrefs(
        key: UserPreference.fieldWorkerIdKey);
    log('fieldWorkerId :$fieldWorkerId');
    await getTotalJobCountFunction();
  }
}
