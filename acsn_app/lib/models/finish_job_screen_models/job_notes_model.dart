import 'dart:convert';

JobNotesModel jobNotesModelFromJson(String str) => JobNotesModel.fromJson(json.decode(str));

String jobNotesModelToJson(JobNotesModel data) => json.encode(data.toJson());

class JobNotesModel {
  int statusCode;
  bool success;
  Data data;

  JobNotesModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory JobNotesModel.fromJson(Map<String, dynamic> json) => JobNotesModel(
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
  String description;
  String specialNotes;

  Data({
    required this.description,
    required this.specialNotes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    description: json["Description"] ?? "",
    specialNotes: json["SpecialNotes"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Description": description,
    "SpecialNotes": specialNotes,
  };
}
