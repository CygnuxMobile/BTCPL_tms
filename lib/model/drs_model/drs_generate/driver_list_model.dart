import 'dart:convert';

DriverListResponse driverListResponseFromJson(String str) => DriverListResponse.fromJson(json.decode(str));

class DriverListResponse {
  int statusCode;
  int status;
  List<DriverListItem> data;
  dynamic errors;
  dynamic metaData;
  String message;

  DriverListResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory DriverListResponse.fromJson(Map<String, dynamic> json) => DriverListResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: json["data"] != null 
        ? List<DriverListItem>.from(json["data"].map((x) => DriverListItem.fromJson(x)))
        : [],
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class DriverListItem {
  int driver_Id;
  String driver_Name;

  DriverListItem({
    required this.driver_Id,
    required this.driver_Name,
  });

  factory DriverListItem.fromJson(Map<String, dynamic> json) => DriverListItem(
    driver_Id: json["driver_Id"] ?? 0,
    driver_Name: json["driver_Name"] ?? "",
  );
}
