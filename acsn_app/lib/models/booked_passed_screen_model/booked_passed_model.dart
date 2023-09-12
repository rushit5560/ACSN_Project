import 'dart:convert';
import 'package:acsn_app/models/common_model/job_details_model.dart';

BookedPassedJobsModel bookedPassedJobsModelFromJson(String str) => BookedPassedJobsModel.fromJson(json.decode(str));

// String bookedPassedJobsModelToJson(BookedPassedJobsModel data) => json.encode(data.toJson());

class BookedPassedJobsModel {
  int statusCode;
  bool success;
  List<JobDetails> data;

  BookedPassedJobsModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory BookedPassedJobsModel.fromJson(Map<String, dynamic> json) => BookedPassedJobsModel(
    statusCode: json["statusCode"],
    success: json["success"],
    data: List<JobDetails>.from(json["data"].map((x) => JobDetails.fromJson(x))),
  );


}

/*class Datum {
  int jobId;
  String jobCode;
  String siteName;
  String siteAddress;
  String paymentReferenceNumber;
  String description;
  String startDate;
  String startTime;
  String clientName;
  String jobStatus;
  String mobileNo;
  String jobType;
  String? phoneNo;
  String? specialNotes;
  dynamic clientNotes;
  dynamic jobDescription;

  Datum({
    required this.jobId,
    required this.jobCode,
    required this.siteName,
    required this.siteAddress,
    required this.paymentReferenceNumber,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.clientName,
    required this.jobStatus,
    required this.mobileNo,
    required this.jobType,
    required this.phoneNo,
    required this.specialNotes,
    required this.clientNotes,
    required this.jobDescription,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jobId: json["JobID"],
    jobCode: json["JobCode"],
    siteName: json["SiteName"],
    siteAddress: json["SiteAddress"],
    paymentReferenceNumber: json["PaymentReferenceNumber"],
    description: json["Description"],
    startDate: json["StartDate"],
    startTime: json["StartTime"],
    clientName: json["clientName"],
    jobStatus: json["JobStatus"],
    mobileNo: json["MobileNo"],
    jobType: json["JobType"],
    phoneNo: json["PhoneNo"],
    specialNotes: json["SpecialNotes"],
    clientNotes: json["ClientNotes"],
    jobDescription: json["JobDescription"],
  );

  Map<String, dynamic> toJson() => {
    "JobID": jobId,
    "JobCode": jobCode,
    "SiteName": siteName,
    "SiteAddress": siteAddress,
    "PaymentReferenceNumber": paymentReferenceNumber,
    "Description": description,
    "StartDate": startDate,
    "StartTime": startTime,
    "clientName": clientName,
    "JobStatus": jobStatus,
    "MobileNo": mobileNo,
    "JobType": jobType,
    "PhoneNo": phoneNo,
    "SpecialNotes": specialNotes,
    "ClientNotes": clientNotes,
    "JobDescription": jobDescription,
  };
}*/
