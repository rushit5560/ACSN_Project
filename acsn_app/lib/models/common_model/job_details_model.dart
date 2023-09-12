class JobDetails {
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
  String phoneNo;
  String jobType;
  String specialNotes;
  String clientNotes;
  String jobDescription;
  dynamic fundingType;
  List<dynamic> callOutcomeList;
  bool changeSchedule;

  JobDetails({
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
    required this.phoneNo,
    required this.jobType,
    required this.specialNotes,
    required this.clientNotes,
    required this.jobDescription,
    required this.fundingType,
    required this.callOutcomeList,
    required this.changeSchedule,
  });

  factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
    jobId: json["JobID"] ?? 0,
    jobCode: json["JobCode"] ?? "",
    siteName: json["SiteName"] ?? "",
    siteAddress: json["SiteAddress"] ?? "",
    paymentReferenceNumber: json["PaymentReferenceNumber"] ?? "",
    description: json["Description"] ?? "",
    startDate: json["StartDate"] ?? "",
    startTime: json["StartTime"] ?? "",
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
    clientNotes: json["ClientNotes"] ?? "",
    jobDescription: json["JobDescription"] ?? "",
    fundingType: json["FundingType"],
    callOutcomeList: List<dynamic>.from((json["CallOutcomeList"] ?? []).map((x) => x)),
    changeSchedule: false,
  );

}