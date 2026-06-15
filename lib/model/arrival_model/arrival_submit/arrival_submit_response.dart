import 'dart:convert';

ThcArrivalSubmitRequsetResponse ThcArrivalSubmitRequsetResponseFromJson(String str) =>
    ThcArrivalSubmitRequsetResponse.fromJson(json.decode(str));

String ThcArrivalSubmitRequsetResponseToJson(ThcArrivalSubmitRequsetResponse data) =>
    json.encode(data.toJson());

class ThcArrivalSubmitRequsetResponse {
  final int statusCode;
  final int status;
  final dynamic data;
  final Errors errors;
  final dynamic metaData;
  final dynamic message;

  ThcArrivalSubmitRequsetResponse({
    required this.statusCode,
    required this.status,
    this.data,
    required this.errors,
    this.metaData,
    this.message,
  });

  factory ThcArrivalSubmitRequsetResponse.fromJson(Map<String, dynamic> json) =>
      ThcArrivalSubmitRequsetResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        data: json["data"],
        errors: Errors.fromJson(json["errors"]),
        metaData: json["metaData"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": data,
        "errors": errors.toJson(),
        "metaData": metaData,
        "message": message,
      };
}

class Errors {
  final int status;
  final String message;
  final dynamic errors;
  final String timeStamp;

  Errors({
    required this.status,
    required this.message,
    this.errors,
    required this.timeStamp,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        status: json["status"],
        message: json["message"],
        errors: json["errors"],
        timeStamp: json["timeStamp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors,
        "timeStamp": timeStamp,
      };
}
