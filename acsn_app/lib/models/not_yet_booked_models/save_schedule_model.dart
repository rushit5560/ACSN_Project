import 'dart:convert';

SaveScheduleModel saveScheduleModelFromJson(String str) => SaveScheduleModel.fromJson(json.decode(str));

String saveScheduleModelToJson(SaveScheduleModel data) => json.encode(data.toJson());

class SaveScheduleModel {
  int statusCode;
  bool success;
  String message;

  SaveScheduleModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  factory SaveScheduleModel.fromJson(Map<String, dynamic> json) => SaveScheduleModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
  };
}