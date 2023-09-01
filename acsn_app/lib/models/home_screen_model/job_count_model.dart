import 'dart:convert';

JobCountModel jobCountModelFromJson(String str) => JobCountModel.fromJson(json.decode(str));

String jobCountModelToJson(JobCountModel data) => json.encode(data.toJson());

class JobCountModel {
  int statusCode;
  bool success;
  Data data;

  JobCountModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory JobCountModel.fromJson(Map<String, dynamic> json) => JobCountModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    data: Data.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  int newCount;
  int todayCount;
  // dynamic noticecount;
  int pendingCount;
  int scheduledCount;

  Data({
    required this.newCount,
    required this.todayCount,
    // required this.noticecount,
    required this.pendingCount,
    required this.scheduledCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    newCount: json["NewCount"] ?? 0,
    todayCount: json["todayCount"] ?? 0,
    // noticecount: json["noticecount"] ?? 0,
    pendingCount: json["PendingCount"] ?? 0,
    scheduledCount: json["ScheduledCount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "NewCount": newCount,
    "todayCount": todayCount,
    // "noticecount": noticecount,
    "PendingCount": pendingCount,
    "ScheduledCount": scheduledCount,
  };
}
