import 'dart:convert';

import 'package:acsn_app/models/start_job_screen_model/job_question_model.dart';

EndJobQuestionModel endJobModelFromJson(String str) => EndJobQuestionModel.fromJson(json.decode(str));

String endJobModelToJson(EndJobQuestionModel data) => json.encode(data.toJson());

class EndJobQuestionModel {
  int statusCode;
  bool success;
  List<QuestionData> data;

  EndJobQuestionModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory EndJobQuestionModel.fromJson(Map<String, dynamic> json) => EndJobQuestionModel(
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

/*class Datum {
  int jobQuestionId;
  String question;
  bool isStart;
  String questionType;
  // dynamic createdBy;
  // dynamic createdOn;
  // dynamic modifyBy;
  // dynamic modifyOn;
  bool isActive;

  Datum({
    required this.jobQuestionId,
    required this.question,
    required this.isStart,
    required this.questionType,
    required this.createdBy,
    required this.createdOn,
    required this.modifyBy,
    required this.modifyOn,
    required this.isActive,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jobQuestionId: json["JobQuestionID"],
    question: json["Question"],
    isStart: json["IsStart"],
    questionType: json["QuestionType"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"],
    modifyBy: json["ModifyBy"],
    modifyOn: json["ModifyOn"],
    isActive: json["IsActive"],
  );

  Map<String, dynamic> toJson() => {
    "JobQuestionID": jobQuestionId,
    "Question": question,
    "IsStart": isStart,
    "QuestionType": questionType,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn,
    "ModifyBy": modifyBy,
    "ModifyOn": modifyOn,
    "IsActive": isActive,
  };
}*/
