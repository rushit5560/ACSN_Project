import 'dart:convert';

ClientNumberModel clientNumberModelFromJson(String str) => ClientNumberModel.fromJson(json.decode(str));

String clientNumberModelToJson(ClientNumberModel data) => json.encode(data.toJson());

class ClientNumberModel {
  int statusCode;
  bool success;
  Data data;

  ClientNumberModel({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory ClientNumberModel.fromJson(Map<String, dynamic> json) => ClientNumberModel(
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
  String mobileNo;
  String phoneNo;

  Data({
    required this.mobileNo,
    required this.phoneNo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mobileNo: json["MobileNo"] ?? "",
    phoneNo: json["PhoneNo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "MobileNo": mobileNo,
    "PhoneNo": phoneNo,
  };
}
