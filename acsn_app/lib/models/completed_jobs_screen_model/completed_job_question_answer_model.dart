import 'dart:convert';

CompletedJobQuestionAnswerModel completedJobQuestionAnswerModelFromJson(String str) => CompletedJobQuestionAnswerModel.fromJson(json.decode(str));

String completedJobQuestionAnswerModelToJson(CompletedJobQuestionAnswerModel data) => json.encode(data.toJson());

class CompletedJobQuestionAnswerModel {
  int statusCode;
  bool success;
  List<JobQA> data;

  CompletedJobQuestionAnswerModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory CompletedJobQuestionAnswerModel.fromJson(Map<String, dynamic> json) => CompletedJobQuestionAnswerModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    data: List<JobQA>.from((json["data"] ?? []).map((x) => JobQA.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class JobQA {
  int jobQuestionId;
  String question;
  String answer;
  bool isStart;

  JobQA({
    required this.jobQuestionId,
    required this.question,
    required this.answer,
    required this.isStart,
  });

  factory JobQA.fromJson(Map<String, dynamic> json) => JobQA(
    jobQuestionId: json["JobQuestionID"] ?? 0,
    question: json["Question"] ?? "",
    answer: json["Answer"] ?? "",
    isStart: json["IsStart"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "JobQuestionID": jobQuestionId,
    "Question": question,
    "Answer": answer,
    "IsStart": isStart,
  };
}
