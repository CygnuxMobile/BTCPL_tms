import 'dart:convert';

CheckValidDocketNoResponse checkValidDocketNoResponseFromJson(String str) => CheckValidDocketNoResponse.fromJson(json.decode(str));

String checkValidDocketNoResponseToJson(CheckValidDocketNoResponse data) => json.encode(data.toJson());

class CheckValidDocketNoResponse {
  final int statusCode;
  final int status;
  final Data data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  CheckValidDocketNoResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory CheckValidDocketNoResponse.fromJson(Map<String, dynamic> json) => CheckValidDocketNoResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"],
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
  final String codeId;
  final String codeDesc;

  Data({
    required this.codeId,
    required this.codeDesc,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    codeId: json["codeId"],
    codeDesc: json["codeDesc"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "codeId": codeId,
    "codeDesc": codeDesc,
  };
}
