import 'dart:convert';

StockUpdateSubmitResponse stockUpdateSubmitResponseFromJson(String str) =>
    StockUpdateSubmitResponse.fromJson(json.decode(str));

String stockUpdateSubmitResponseToJson(StockUpdateSubmitResponse data) =>
    json.encode(data.toJson());

class StockUpdateSubmitResponse {
  final String statusCode;
  final int status;
  final String data;
  final String errors;
  final String metaData;
  final String message;

  StockUpdateSubmitResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory StockUpdateSubmitResponse.fromJson(Map<String, dynamic> json) =>
      StockUpdateSubmitResponse(
        statusCode: json["statusCode"].toString(),
        status: json["status"],
        data: json["data"].toString(),
        errors: json["errors"].toString(),
        metaData: json["metaData"].toString(),
        message: json["message"].toString(),
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
