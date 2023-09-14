import 'dart:convert';

FinishJobSavedDetailsModel finishJobSavedDetailsModelFromJson(String str) => FinishJobSavedDetailsModel.fromJson(json.decode(str));

String finishJobSavedDetailsModelToJson(FinishJobSavedDetailsModel data) => json.encode(data.toJson());

class FinishJobSavedDetailsModel {
  int statusCode;
  bool success;
  Data data;

  FinishJobSavedDetailsModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory FinishJobSavedDetailsModel.fromJson(Map<String, dynamic> json) => FinishJobSavedDetailsModel(
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
  String completionNote;
  String noPaymentReason;
  String clientSignature;
  String itemToAdd;
  List<JobSavedAnswer> jobSavedAnswer;
  List<ListJobPhoto> listJobPhotos;

  Data({
    required this.description,
    required this.specialNotes,
    required this.completionNote,
    required this.noPaymentReason,
    required this.clientSignature,
    required this.itemToAdd,
    required this.jobSavedAnswer,
    required this.listJobPhotos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    description: json["Description"] ?? "",
    specialNotes: json["SpecialNotes"] ?? "",
    completionNote: json["CompletionNote"] ?? "",
    noPaymentReason: json["NoPaymentReason"] ?? "",
    clientSignature: json["ClientSignature"] ?? "",
    itemToAdd: json["ItemToAdd"] ?? "",
    jobSavedAnswer: List<JobSavedAnswer>.from((json["JobSavedAnswer"] ?? []).map((x) => JobSavedAnswer.fromJson(x))),
    listJobPhotos: List<ListJobPhoto>.from((json["listJobPhotos"] ?? []).map((x) => ListJobPhoto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Description": description,
    "SpecialNotes": specialNotes,
    "CompletionNote": completionNote,
    "NoPaymentReason": noPaymentReason,
    "ClientSignature": clientSignature,
    "ItemToAdd": itemToAdd,
    "JobSavedAnswer": List<dynamic>.from(jobSavedAnswer.map((x) => x.toJson())),
    "listJobPhotos": List<dynamic>.from(listJobPhotos.map((x) => x.toJson())),
  };
}

class JobSavedAnswer {
  int quesId;
  String answer;

  JobSavedAnswer({
    required this.quesId,
    required this.answer,
  });

  factory JobSavedAnswer.fromJson(Map<String, dynamic> json) => JobSavedAnswer(
    quesId: json["QuesId"] ?? 0,
    answer: json["Answer"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "QuesId": quesId,
    "Answer": answer,
  };
}

class ListJobPhoto {
  String path;

  ListJobPhoto({
    required this.path,
  });

  factory ListJobPhoto.fromJson(Map<String, dynamic> json) => ListJobPhoto(
    path: json["path"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "path": path,
  };
}
