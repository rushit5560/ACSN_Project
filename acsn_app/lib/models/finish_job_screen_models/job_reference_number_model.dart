import 'dart:convert';

JobReferenceNumberModel jobReferenceNumberModelFromJson(String str) => JobReferenceNumberModel.fromJson(json.decode(str));

String jobReferenceNumberModelToJson(JobReferenceNumberModel data) => json.encode(data.toJson());

class JobReferenceNumberModel {
  int statusCode;
  bool success;
  String data;

  JobReferenceNumberModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory JobReferenceNumberModel.fromJson(Map<String, dynamic> json) => JobReferenceNumberModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    data: json["data"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": data,
  };
}
