// To parse this JSON data, do
//
//     final attendanceRes = attendanceResFromJson(jsonString);

import 'dart:convert';

AttendanceRes attendanceResFromJson(String str) => AttendanceRes.fromJson(json.decode(str));

String attendanceResToJson(AttendanceRes data) => json.encode(data.toJson());

class AttendanceRes {
  final int statusCode;
  final int status;
  final Data data;
  final String errors;
  final String metaData;
  final String message;

  AttendanceRes({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory AttendanceRes.fromJson(Map<String, dynamic> json) => AttendanceRes(
    statusCode: json["statusCode"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
    errors: json["errors"]??'',
    metaData: json["metaData"]??'',
    message: json["message"]??'',
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "data": data.toJson(),
    "errors": errors,
    "metaData": metaData,
    "message": message,
  };
}

class Data {
  final bool status;
  final String message;
  final int id;

  Data({
    required this.status,
    required this.message,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"] ?? false,
    message: json["message"] ?? '',
    id: json["id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "id": id,
  };
}
