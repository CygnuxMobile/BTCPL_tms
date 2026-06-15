/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

AttendanceResponse attendanceResponseFromJson(String str) => AttendanceResponse.fromJson(json.decode(str));

String attendanceResponseToJson(AttendanceResponse data) => json.encode(data.toJson());

class AttendanceResponse {
    AttendanceResponse({
        required this.data,
        required this.message,
        required this.statusCode,
        required this.status,
    });

    Data data;
    String message;
    int statusCode;
    int status;

    factory AttendanceResponse.fromJson(Map<dynamic, dynamic> json) => AttendanceResponse(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["statusCode"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "statusCode": statusCode,
        "status": status,
    };
}

class Data {
    Data({
        required this.isAttendanceRequest,
        required this.id,
        required this.message,
        required this.status,
    });

    bool isAttendanceRequest;
    int id;
    String message;
    bool status;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        isAttendanceRequest: json["isAttendanceRequest"] ?? false,
        id: json["id"] ?? 0,
        message: json["message"] ?? '',
        status: json["status"] ?? 0,
    );

    Map<dynamic, dynamic> toJson() => {
        "isAttendanceRequest": isAttendanceRequest,
        "id": id,
        "message": message,
        "status": status,
    };
}
