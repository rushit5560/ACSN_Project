import 'dart:convert';

import 'package:acsn_app/models/common_model/job_details_model.dart';

TodayJobModel todayJobModelFromJson(String str) => TodayJobModel.fromJson(json.decode(str));

// String todayJobModelToJson(TodayJobModel data) => json.encode(data.toJson());

class TodayJobModel {
  int statusCode;
  bool success;
  List<JobDetails> data;

  TodayJobModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory TodayJobModel.fromJson(Map<String, dynamic> json) => TodayJobModel(
    statusCode: json["statusCode"],
    success: json["success"],
    data: List<JobDetails>.from(json["data"].map((x) => JobDetails.fromJson(x))),
  );

}

