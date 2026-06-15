import 'dart:convert';

CustListResponse custListResponseFromJson(String str) => CustListResponse.fromJson(json.decode(str));

String custListResponseToJson(CustListResponse data) => json.encode(data.toJson());

class CustListResponse {
  final int statusCode;
  final int status;
  final List<CustList> custList;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  CustListResponse({
    required this.statusCode,
    required this.status,
    required this.custList,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory CustListResponse.fromJson(Map<String, dynamic> json) => CustListResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    custList: List<CustList>.from(json["data"].map((x) => CustList.fromJson(x))),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "data": List<dynamic>.from(custList.map((x) => x.toJson())),
    "errors": errors,
    "metaData": metaData,
    "message": message,
  };
}

class CustList {
  final String custcd;
  final String custnm;

  CustList({
    required this.custcd,
    required this.custnm,
  });

  factory CustList.fromJson(Map<String, dynamic> json) => CustList(
    custcd: json["custcd"],
    custnm: json["custnm"],
  );

  Map<String, dynamic> toJson() => {
    "custcd": custcd,
    "custnm": custnm,
  };
}

