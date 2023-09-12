import 'dart:convert';

JobQuestionModel startJobModelFromJson(String str) => JobQuestionModel.fromJson(json.decode(str));

String startJobModelToJson(JobQuestionModel data) => json.encode(data.toJson());

class JobQuestionModel {
  int statusCode;
  bool success;
  List<QuestionData> data;

  JobQuestionModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory JobQuestionModel.fromJson(Map<String, dynamic> json) => JobQuestionModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    data: List<QuestionData>.from((json["data"] ?? []).map((x) => QuestionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class QuestionData {
  int jobQuestionId;
  String question;
  bool isStart;
  String questionType;
  // dynamic createdBy;
  // dynamic createdOn;
  // dynamic modifyBy;
  // dynamic modifyOn;
  bool isActive;
  String answer;

  QuestionData({
    required this.jobQuestionId,
    required this.question,
    required this.isStart,
    required this.questionType,
    // required this.createdBy,
    // required this.createdOn,
    // required this.modifyBy,
    // required this.modifyOn,
    required this.isActive,
    required this.answer,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) => QuestionData(
    jobQuestionId: json["JobQuestionID"] ?? 0,
    question: json["Question"] ?? "",
    isStart: json["IsStart"] ?? false,
    questionType: json["QuestionType"] ?? "",
    // createdBy: json["CreatedBy"],
    // createdOn: json["CreatedOn"],
    // modifyBy: json["ModifyBy"],
    // modifyOn: json["ModifyOn"],
    isActive: json["IsActive"] ?? false,
    answer: ""
  );

  Map<String, dynamic> toJson() => {
    "JobQuestionID": jobQuestionId,
    "Question": question,
    "IsStart": isStart,
    "QuestionType": questionType,
    // "CreatedBy": createdBy,
    // "CreatedOn": createdOn,
    // "ModifyBy": modifyBy,
    // "ModifyOn": modifyOn,
    "IsActive": isActive,
  };
}
