import 'dart:convert';

CompletedJobDetailsModel completedJobDetailsModelFromJson(String str) => CompletedJobDetailsModel.fromJson(json.decode(str));

// String completedJobDetailsModelToJson(CompletedJobDetailsModel data) => json.encode(data.toJson());

class CompletedJobDetailsModel {
  int statusCode;
  bool success;
  List<JobDatum> data;

  CompletedJobDetailsModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory CompletedJobDetailsModel.fromJson(Map<String, dynamic> json) => CompletedJobDetailsModel(
    statusCode: json["statusCode"],
    success: json["success"],
    data: List<JobDatum>.from(json["data"].map((x) => JobDatum.fromJson(x))),
  );

  // Map<String, dynamic> toJson() => {
  //   "statusCode": statusCode,
  //   "success": success,
  //   "data": List<dynamic>.from(data.map((x) => x.toJson())),
  // };
}

class JobDatum {
  int jobId;
  String jobCode;
  int fieldWorkerId;
  String state;
  String siteName;
  String siteAddress;
  String customerBooking;
  String description;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String clientName;
  String jobStatus;
  String mobileNo;
  String phoneNo;
  String jobType;
  String specialNotes;
  String completionNote;
  String itemToBeAdded;
  String paymentMethod;
  bool isPayment;

  JobDatum({
    required this.jobId,
    required this.jobCode,
    required this.fieldWorkerId,
    required this.state,
    required this.siteName,
    required this.siteAddress,
    required this.customerBooking,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.clientName,
    required this.jobStatus,
    required this.mobileNo,
    required this.phoneNo,
    required this.jobType,
    required this.specialNotes,
    required this.completionNote,
    required this.itemToBeAdded,
    required this.paymentMethod,
    required this.isPayment,
  });

  factory JobDatum.fromJson(Map<String, dynamic> json) => JobDatum(
    jobId: json["JobID"] ?? 0,
    jobCode: json["JobCode"] ?? "",
    fieldWorkerId: json["FieldWorkerID"] ?? 0,
    state: json["State"] ?? "",
    siteName: json["SiteName"] ?? "",
    siteAddress: json["SiteAddress"] ?? "",
    customerBooking: json["CustomerBooking"] ?? "",
    description: json["Description"] ?? "",
    startDate: json["StartDate"] ?? "",
    startTime: json["StartTime"] ?? "",
    endDate: json["EndDate"] ?? "",
    endTime: json["EndTime"] ?? "",
    clientName: json["clientName"] ?? "",
    jobStatus: json["JobStatus"] ?? "",
    mobileNo: json["MobileNo"] ?? "",
    phoneNo: json["PhoneNo"] ?? "",
    jobType: json["JobType"] == "L"
        ? "Lawn Mow"
        : json["JobType"] == "LY"
        ? "Lawn Mow & Yard Tidy"
        : json["JobType"] == "LM"
        ? "EXTRA LM"
        : json["JobType"] == "TT"
        ? "Travel Time"
        : json["JobType"] == "RC"
        ? "Rubbish Collection"
        : "",
    specialNotes: json["SpecialNotes"] ?? "",
    completionNote: json["CompletionNote"] ?? "",
    itemToBeAdded: json["ItemToBeAdded"] ?? "",
    paymentMethod: json["PaymentMethod"] ?? "",
    isPayment: json["IsPayment"] ?? false,
  );

  /*Map<String, dynamic> toJson() => {
    "JobID": jobId,
    "JobCode": jobCode,
    "FieldWorkerID": fieldWorkerId,
    "State": state,
    "SiteName": siteName,
    "SiteAddress": siteAddress,
    "CustomerBooking": customerBooking,
    "Description": description,
    "StartDate": startDate,
    "StartTime": startTime,
    "EndDate": endDate,
    "EndTime": endTime,
    "clientName": clientName,
    "JobStatus": jobStatus,
    "MobileNo": mobileNo,
    "PhoneNo": phoneNo,
    "JobType": jobType,
    "SpecialNotes": specialNotes,
    "CompletionNote": completionNote,
    "ItemToBeAdded": itemToBeAdded,
    "PaymentMethod": paymentMethod,
    "IsPayment": isPayment,
  };*/
}
