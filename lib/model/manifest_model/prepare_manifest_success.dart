
import 'dart:convert';

PrepareManifestResponse prepareManifestResponseFromJson(String str) => PrepareManifestResponse.fromJson(json.decode(str));

String prepareManifestResponseToJson(PrepareManifestResponse data) => json.encode(data.toJson());

class PrepareManifestResponse {
  PrepareManifestResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  final int statusCode;
  final int status;
  final String data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  factory PrepareManifestResponse.fromJson(Map<String, dynamic> json) => PrepareManifestResponse(
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
