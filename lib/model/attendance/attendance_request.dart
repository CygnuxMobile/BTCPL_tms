import 'dart:convert';

AttendanceRequest attendanceRequestFromJson(String str) => AttendanceRequest.fromJson(json.decode(str));

String attendanceRequestToJson(AttendanceRequest data) => json.encode(data.toJson());

class AttendanceRequest {
    AttendanceRequest({
        required this.isAttendanceRequest,
        required this.isClockIn,
        required this.attandanceId,
        required this.location,
        required this.userId,
        required this.attendanceDate,
    });

    bool isAttendanceRequest;
    bool isClockIn;
    int attandanceId;
    String location;
    String userId;
    String attendanceDate;

    factory AttendanceRequest.fromJson(Map<dynamic, dynamic> json) => AttendanceRequest(
        isAttendanceRequest: json["isAttendanceRequest"] ?? false,
        isClockIn: json["isClockIn"] ?? false,
        attandanceId: json["attandanceId"] ?? 0,
        location: json["location"] ?? '',
        userId: json["userId"] ?? '',
        attendanceDate: json["attendanceDate"] ?? '',
    );

    Map<dynamic, dynamic> toJson() => {
        "isAttendanceRequest": isAttendanceRequest,
        "isClockIn": isClockIn,
        "attandanceId": attandanceId,
        "location": location,
        "userId": userId,
        "attendanceDate": attendanceDate,
    };
}
