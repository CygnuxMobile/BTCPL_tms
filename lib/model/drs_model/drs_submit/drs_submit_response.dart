import 'dart:convert';

DrsSubmitResponse drsSubmitResponseFromJson(String str) => DrsSubmitResponse.fromJson(json.decode(str));

String drsSubmitResponseToJson(DrsSubmitResponse data) => json.encode(data.toJson());

class DrsSubmitResponse {
  final int statusCode;
  final int status;
  final dynamic data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  DrsSubmitResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory DrsSubmitResponse.fromJson(Map<String, dynamic> json) => DrsSubmitResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    data: json["data"],
    errors:json["errors"],
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


