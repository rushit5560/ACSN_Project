import 'dart:convert';

JobExpectedItemsModel jobExpectedItemsModelFromJson(String str) => JobExpectedItemsModel.fromJson(json.decode(str));

String jobExpectedItemsModelToJson(JobExpectedItemsModel data) => json.encode(data.toJson());

class JobExpectedItemsModel {
  int statusCode;
  bool success;
  List<ExpectedItem> data;

  JobExpectedItemsModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory JobExpectedItemsModel.fromJson(Map<String, dynamic> json) => JobExpectedItemsModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    data: List<ExpectedItem>.from((json["data"] ?? []).map((x) => ExpectedItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ExpectedItem {
  String jobItem;

  ExpectedItem({
    required this.jobItem,
  });

  factory ExpectedItem.fromJson(Map<String, dynamic> json) => ExpectedItem(
    jobItem: json["JobItem"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "JobItem": jobItem,
  };
}
