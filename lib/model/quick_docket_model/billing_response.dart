// To parse this JSON data, do
//
//     final billingTypeResponse = billingTypeResponseFromJson(jsonString);

import 'dart:convert';

BillingTypeResponse billingTypeResponseFromJson(String str) =>
    BillingTypeResponse.fromJson(json.decode(str));

String billingTypeResponseToJson(BillingTypeResponse data) =>
    json.encode(data.toJson());

class BillingTypeResponse {
  final int statusCode;
  final int status;
  final List<BillingTypeList> billingTypeList;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  BillingTypeResponse({
    required this.statusCode,
    required this.status,
    required this.billingTypeList,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory BillingTypeResponse.fromJson(Map<String, dynamic> json) =>
      BillingTypeResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        billingTypeList: List<BillingTypeList>.from(json["data"].map((x) => BillingTypeList.fromJson(x))),
        errors: json["errors"],
        metaData: json["metaData"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": List<dynamic>.from(billingTypeList.map((x) => x.toJson())),
        "errors": errors,
        "metaData": metaData,
        "message": message,
      };
}

class BillingTypeList {
  final String codeType;
  final String codeId;
  final String codeDesc;
  final String codeAccess;

  BillingTypeList({
    required this.codeType,
    required this.codeId,
    required this.codeDesc,
    required this.codeAccess,
  });

  factory BillingTypeList.fromJson(Map<String, dynamic> json) => BillingTypeList(
        codeType: json["codeType"],
        codeId: json["codeId"],
        codeDesc: json["codeDesc"],
        codeAccess: json["codeAccess"],
      );

  Map<String, dynamic> toJson() => {
        "codeType": codeType,
        "codeId": codeId,
        "codeDesc": codeDesc,
        "codeAccess": codeAccess,
      };
}
