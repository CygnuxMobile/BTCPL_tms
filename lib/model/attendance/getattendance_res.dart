// To parse this JSON data, do
//
//     final getattendanceRes = getattendanceResFromJson(jsonString);

import 'dart:convert';

GetattendanceRes getattendanceResFromJson(String str) =>
    GetattendanceRes.fromJson(json.decode(str));

class GetattendanceRes {
  final int statusCode;
  final int status;
  final List<Datum> data;
  final String errors;
  final String metaData;
  final String message;

  GetattendanceRes({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory GetattendanceRes.fromJson(Map<String, dynamic> json) =>
      GetattendanceRes(
        statusCode: json["statusCode"] ,
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errors: json["errors"] ?? '',
        metaData: json["metaData"] ?? '',
        message: json["message"] ?? '',
      );

}

class Datum {
  final String inTime;
  final String outTime;
  final String attendanceStatus;
  final int attendanceId;
  final String userId;
  final bool isClockIn;
  final bool isClockOut;

  Datum({
    required this.inTime,
    required this.outTime,
    required this.attendanceId,
    required this.userId,
    required this.isClockIn,
    required this.isClockOut,
    required this.attendanceStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        inTime: json["inTime"] ?? '',
        outTime: json["outTime"] ?? '',
        attendanceStatus: json["attendanceStatus"] ?? '',
        attendanceId: json["attendanceId"]??0,
        userId: json["userId"] ?? '',
        isClockIn: json["isClockIn"] ?? false,
        isClockOut: json["isClockOut"] ?? false,
      );

}
