import 'dart:developer';

import 'package:acsn_app/utils/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUrl {
  // static String database = "http://app.acsn.com.au/";
  static String database = "http://5.189.147.159:8047/";
  static String baseUrl = "${database}ACSNApi/";

  static String fieldWorkerLoginOneTimeApi = "${baseUrl}GetFieldWorkerLoginOneTimeV2";
  static String getTotalJobCountApi = "${baseUrl}Mob_GetTotalJobsCountByFieldWorkerId";
  static String getNotYetBookedApi = "${baseUrl}Mob_GetAllListByFieldWorkerId";
  static String getBookedFutureJobsApi = "${baseUrl}mob_GetAllScheduledListByFieldWorkerId";
  static String saveScheduleApi = "${baseUrl}UpdateJobScheduleTimes";
  static String updateJobNoteApi = "${baseUrl}UpdateJobNotes";
  static String jobNoteRequiredApi = "${baseUrl}MakeJobNotRequired";
  static String searchJobApi = "${baseUrl}Mob_GetSearchRelatedJobs";

  static String getTodayWorkerJobApi = "${baseUrl}Mob_GetJobListByFieldWorkerId";
  static String getJobQuestionApi = "${baseUrl}GetJobStartQuetion";
  static String insertJobQuestionAnswerApi = "${baseUrl}InsertJobQuestionAnswer";
  static String updateJobApi = "${baseUrl}UpdateJob";
  static String insertGpsLocationApi = "${baseUrl}InsertFieldWorkerGPS";
  static String getFinishJobQuestionApi = "${baseUrl}GetJobEndQuetion";
  static String bookedDatePassedJobApi = "${baseUrl}Mob_GetPandingJobListByFieldWorkerId";
  static String completedJobApi = "${baseUrl}Mob_GetAllCompletedJobsByFieldWorkerId";
  static String completedJobDetailsApi = "${baseUrl}Mob_GetCompletedJobDetailsByJobId";
  static String completedJobQAndAApi = "${baseUrl}Mob_GetCompletedJobQuestionAnswerByJobId";
  static String previousCompletedJobAPi = "${baseUrl}Mob_GetAllPrevCompletedJobsByFieldWorkerId";
  static String saveJobFinishDetailsApi = "${baseUrl}SaveJobFinishDetails";
  static String getClientContactApi = "${baseUrl}Mob_GetClientContactsByJobId";
  static String getJobNotesApi = "${baseUrl}Mob_GetJobNotesByJobId";
  static String getReferenceNumberApi = "${baseUrl}Mob_GetJobReferenceNumberByJobId";
  static String getJobItemApi = "${baseUrl}Mob_GetJobItemsByJobId";
  static String getFinishJobSavedDetailsApi = "${baseUrl}Mob_GetFinishJobSavedDetails";
  static String updateJobItemApi = "${baseUrl}UpdateJobItem";
}

class Headers {

  String token = "";

  Future<Map<String, String>> getHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserPreference.userLoginTokenKey) ?? "";
    Map<String, String> header = {
      'token': token
    };
    log('token : $token');
    return header;
  }

  Future<Map<String, String>> getHeader2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserPreference.userLoginTokenKey) ?? "";
    //todo - use user token
    Map<String, String> header = {
      'token': token,
      "Content-Type": "application/json"
    };
    return header;
  }

}