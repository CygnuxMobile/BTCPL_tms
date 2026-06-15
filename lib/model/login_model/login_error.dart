import 'dart:convert';

LoginError loginErrorFromJson(String str) => LoginError.fromJson(json.decode(str));

String loginErrorToJson(LoginError data) => json.encode(data.toJson());

class LoginError {
  LoginError({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  final int statusCode;
  final int status;
  final dynamic data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
    statusCode: json["statusCode"],
    status: json["status"],
    data: json["data"],
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "data": data,
    "errors": errors,
    "metaData": metaData,
    "message": message,
  };
}
