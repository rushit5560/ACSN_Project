import 'dart:convert';

import '../common_model/job_details_model.dart';

NotYetBookedJobModel notYetBookedJobModelFromJson(String str) => NotYetBookedJobModel.fromJson(json.decode(str));

// String notYetBookedJobModelToJson(NotYetBookedJobModel data) => json.encode(data.toJson());

class NotYetBookedJobModel {
  int statusCode;
  bool success;
  List<JobDetails> data;

  NotYetBookedJobModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory NotYetBookedJobModel.fromJson(Map<String, dynamic> json) => NotYetBookedJobModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    data: List<JobDetails>.from((json["data"] ?? []).map((x) => JobDetails.fromJson(x))),
  );

  /*Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };*/
}


