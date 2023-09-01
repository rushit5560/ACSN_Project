import 'package:acsn_app/utils/user_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUrl {
  static String database = "https://app.acsn.com.au/";
  static String baseUrl = "${database}ACSNApi/";

  // static String fieldWorkerLoginOneTimeApi = "${baseUrl}GetFieldWorkerLoginOneTime";
  static String fieldWorkerLoginOneTimeApi = "${baseUrl}GetFieldWorkerLoginOneTimeV2";
  static String getTotalJobCountApi = "${baseUrl}Mob_GetTotalJobsCountByFieldWorkerId";
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

  // Map<String, String> header = {
  //   'content-type': 'application/json',
  //   'token': token
  // };

}