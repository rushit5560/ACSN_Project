import 'package:acsn_app/utils/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUrl {
  // static String database = "https://app.acsn.com.au/";
  static String database = "http://5.189.147.159:7010/";
  static String baseUrl = "${database}ACSNApi/";

  // static String fieldWorkerLoginOneTimeApi = "${baseUrl}GetFieldWorkerLoginOneTime";
  static String fieldWorkerLoginOneTimeApi = "${baseUrl}GetFieldWorkerLoginOneTimeV2";
  static String getTotalJobCountApi = "${baseUrl}Mob_GetTotalJobsCountByFieldWorkerId";
  static String getNotYetBookedApi = "${baseUrl}Mob_GetAllListByFieldWorkerId";
  static String getBookedFutureJobsApi = "${baseUrl}mob_GetAllScheduledListByFieldWorkerId";
  static String saveScheduleApi = "${baseUrl}UpdateJobScheduleTimes";
  static String updateJobNoteApi = "${baseUrl}UpdateJobNotes";
}

class Headers {

  String token = "";

  Future<Map<String, String>> getHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserPreference.userLoginTokenKey) ?? "";
    Map<String, String> header = {
      'token': token
    };
    return header;
  }

}