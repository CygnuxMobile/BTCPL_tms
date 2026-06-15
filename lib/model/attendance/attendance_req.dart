import 'dart:convert';

AttendanceReq attendanceReqFromJson(String str) => AttendanceReq.fromJson(json.decode(str));

String attendanceReqToJson(AttendanceReq data) => json.encode(data.toJson());

class AttendanceReq {
  final String userId;
  final String location;
  final String attendanceDate;
  final bool isClockIn;
  final int attandanceId;

  AttendanceReq({
    required this.userId,
    required this.location,
    required this.attendanceDate,
    required this.isClockIn,
    required this.attandanceId,
  });

  factory AttendanceReq.fromJson(Map<String, dynamic> json) => AttendanceReq(
    userId: json["userId"],
    location: json["location"],
    attendanceDate: json["attendanceDate"],
    isClockIn: json["isClockIn"],
    attandanceId: json["attandanceId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "location": location,
    "attendanceDate": attendanceDate,
    "isClockIn": isClockIn,
    "attandanceId": attandanceId,
  };
}


