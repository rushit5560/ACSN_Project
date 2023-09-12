import 'dart:convert';

import 'package:acsn_app/models/common_model/job_details_model.dart';

CompletedJobsModel completedJobsModelFromJson(String str) => CompletedJobsModel.fromJson(json.decode(str));


class CompletedJobsModel {
  int statusCode;
  bool success;
  List<JobDetails> data;

  CompletedJobsModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory CompletedJobsModel.fromJson(Map<String, dynamic> json) => CompletedJobsModel(
    statusCode: json["statusCode"],
    success: json["success"],
    data: List<JobDetails>.from(json["data"].map((x) => JobDetails.fromJson(x))),
  );


}

