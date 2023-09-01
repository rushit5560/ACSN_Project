import 'dart:convert';

FieldWorkerLoginModel fieldWorkerLoginModelFromJson(String str) =>
    FieldWorkerLoginModel.fromJson(json.decode(str));

String fieldWorkerLoginModelToJson(FieldWorkerLoginModel data) =>
    json.encode(data.toJson());

class FieldWorkerLoginModel {
  FieldWorkerLoginModel({
    required this.statusCode,
    required this.success,
    required this.workerList,
  });

  int statusCode;
  bool success;
  WorkerList workerList;

  factory FieldWorkerLoginModel.fromJson(Map<String, dynamic> json) =>
      FieldWorkerLoginModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        workerList: WorkerList.fromJson(json["WorkerList"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        // "WorkerList": workerList.toJson(),
      };
}

class WorkerList {
  WorkerList({
    required this.fieldWorkerId,
    required this.name,
    required this.surname,
    // this.preffredName,
    // this.mobile,
    // this.email,
    required this.userName,
    required this.password,
    // this.dob,
    // this.photo,
    // this.signature,
    // this.signpath,
    // this.state,
    // this.city,
    // this.street,
    // this.postcode,
    // this.isActive,
    // this.complianceName,
    // this.compliancePhoto,
    // this.complianceSignature,
    // this.complianceSigned,
    // this.isCompliance,
    // this.notes,
    // this.licenseNumber,
    // this.expiryDate,
    // this.licAttchement,
    // this.contractorId,
    required this.loginToken,
    required this.loginMessage,
    // this.fieldWorkerCode,
    // this.aspNetUserId,
    // this.createdBy,
    // this.createdOn,
    // this.modifiedBy,
    // this.modifiedOn,
    // this.lastLoginDate,
    // this.selContractor,
  });

  int fieldWorkerId;
  String name;
  String surname;
  // dynamic preffredName;
  // dynamic mobile;
  // dynamic email;
  String userName;
  String password;
  // dynamic dob;
  // dynamic photo;
  // dynamic signature;
  // dynamic signpath;
  // dynamic state;
  // dynamic city;
  // dynamic street;
  // dynamic postcode;
  // bool isActive;
  // dynamic complianceName;
  // dynamic compliancePhoto;
  // dynamic complianceSignature;
  // dynamic complianceSigned;
  // dynamic isCompliance;
  // dynamic notes;
  // dynamic licenseNumber;
  // dynamic expiryDate;
  // dynamic licAttchement;
  // int contractorId;
  String loginToken;
  String loginMessage;
  // dynamic fieldWorkerCode;
  // dynamic aspNetUserId;
  // dynamic createdBy;
  // dynamic createdOn;
  // dynamic modifiedBy;
  // dynamic modifiedOn;
  // dynamic lastLoginDate;
  // dynamic selContractor;

  factory WorkerList.fromJson(Map<String, dynamic> json) => WorkerList(
        fieldWorkerId: json["FieldWorkerID"] ?? 0,
        name: json["Name"] ?? "",
        surname: json["Surname"] ?? "",
        // preffredName: json["PreffredName"],
        // mobile: json["Mobile"],
        // email: json["Email"],
        userName: json["UserName"] ?? "",
        password: json["Password"] ?? "",
        // dob: json["DOB"],
        // photo: json["Photo"],
        // signature: json["Signature"],
        // signpath: json["signpath"],
        // state: json["state"],
        // city: json["CITY"],
        // street: json["STREET"],
        // postcode: json["Postcode"],
        // isActive: json["IsActive"],
        // complianceName: json["ComplianceName"],
        // compliancePhoto: json["CompliancePhoto"],
        // complianceSignature: json["ComplianceSignature"],
        // complianceSigned: json["ComplianceSigned"],
        // isCompliance: json["IsCompliance"],
        // notes: json["Notes"],
        // licenseNumber: json["LicenseNumber"],
        // expiryDate: json["ExpiryDate"],
        // licAttchement: json["LicAttchement"],
        // contractorId: json["ContractorId"],
        loginToken: json["LoginToken"] ?? "",
        loginMessage: json["LoginMessage"] ?? "",
        // fieldWorkerCode: json["FieldWorkerCode"],
        // aspNetUserId: json["AspNetUserID"],
        // createdBy: json["CreatedBy"],
        // createdOn: json["CreatedOn"],
        // modifiedBy: json["ModifiedBy"],
        // modifiedOn: json["ModifiedOn"],
        // lastLoginDate: json["LastLoginDate"],
        // selContractor: json["SelContractor"],
      );

  /*Map<String, dynamic> toJson() => {
    "FieldWorkerID": fieldWorkerId,
    "Name": name,
    "Surname": surname,
    "PreffredName": preffredName,
    "Mobile": mobile,
    "Email": email,
    "UserName": userName,
    "Password": password,
    "DOB": dob,
    "Photo": photo,
    "Signature": signature,
    "signpath": signpath,
    "state": state,
    "CITY": city,
    "STREET": street,
    "Postcode": postcode,
    "IsActive": isActive,
    "ComplianceName": complianceName,
    "CompliancePhoto": compliancePhoto,
    "ComplianceSignature": complianceSignature,
    "ComplianceSigned": complianceSigned,
    "IsCompliance": isCompliance,
    "Notes": notes,
    "LicenseNumber": licenseNumber,
    "ExpiryDate": expiryDate,
    "LicAttchement": licAttchement,
    "ContractorId": contractorId,
    "LoginToken": loginToken,
    "LoginMessage": loginMessage,
    "FieldWorkerCode": fieldWorkerCode,
    "AspNetUserID": aspNetUserId,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn,
    "ModifiedBy": modifiedBy,
    "ModifiedOn": modifiedOn,
    "LastLoginDate": lastLoginDate,
    "SelContractor": selContractor,
  };*/
}
