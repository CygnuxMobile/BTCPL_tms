import 'dart:convert';

DriverDetailsResponse driverDetailsResponseFromJson(String str) => DriverDetailsResponse.fromJson(json.decode(str));

class DriverDetailsResponse {
  int statusCode;
  int status;
  DriverDetailsData data;
  dynamic errors;
  dynamic metaData;
  String message;

  DriverDetailsResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory DriverDetailsResponse.fromJson(Map<String, dynamic> json) => DriverDetailsResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: DriverDetailsData.fromJson(json["data"] ?? {}),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class DriverDetailsData {
  int driver_Id;
  String driver_Name;
  String mobileno;
  String license_No;
  String issue_By_RTO;
  String valdity_date;

  DriverDetailsData({
    required this.driver_Id,
    required this.driver_Name,
    required this.mobileno,
    required this.license_No,
    required this.issue_By_RTO,
    required this.valdity_date,
  });

  factory DriverDetailsData.fromJson(Map<String, dynamic> json) => DriverDetailsData(
    driver_Id: json["driver_Id"] ?? 0,
    driver_Name: json["driver_Name"] ?? "",
    mobileno: json["mobileno"] ?? "",
    license_No: json["license_No"] ?? "",
    issue_By_RTO: json["issue_By_RTO"] ?? "",
    valdity_date: json["valdity_date"] ?? "",
  );
}
