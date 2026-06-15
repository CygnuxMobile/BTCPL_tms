// To parse this JSON data, do
//
//     final thcArrivalSubmitRequest = thcArrivalSubmitRequestFromJson(jsonString);

import 'dart:convert';

ThcArrivalSubmitRequest thcArrivalSubmitRequestFromJson(String str) => ThcArrivalSubmitRequest.fromJson(json.decode(str));

String thcArrivalSubmitRequestToJson(ThcArrivalSubmitRequest data) => json.encode(data.toJson());

class ThcArrivalSubmitRequest {
  final String thcno;
  final String brcd;
  final String ad;
  final String at;
  final String baseUserName;
  final String isn;
  final String status;
  final int closekm;
  final String ir;
  final String transportMode;
  final String baseCompanyCode;

  ThcArrivalSubmitRequest({
    required this.thcno,
    required this.brcd,
    required this.ad,
    required this.at,
    required this.baseUserName,
    required this.isn,
    required this.status,
    required this.closekm,
    required this.ir,
    required this.transportMode,
    required this.baseCompanyCode,
  });

  factory ThcArrivalSubmitRequest.fromJson(Map<String, dynamic> json) => ThcArrivalSubmitRequest(
    thcno: json["thcno"],
    brcd: json["brcd"],
    ad: json["ad"],
    at: json["at"],
    baseUserName: json["baseUserName"],
    isn: json["isn"],
    status: json["status"],
    closekm: json["closekm"],
    ir: json["ir"],
    transportMode: json["transportMode"],
    baseCompanyCode: json["baseCompanyCode"],
  );

  Map<String, dynamic> toJson() => {
    "thcno": thcno,
    "brcd": brcd,
    "ad": ad,
    "at": at,
    "baseUserName": baseUserName,
    "isn": isn,
    "status": status,
    "closekm": closekm,
    "ir": ir,
    "transportMode": transportMode,
    "baseCompanyCode": baseCompanyCode,
  };
}
