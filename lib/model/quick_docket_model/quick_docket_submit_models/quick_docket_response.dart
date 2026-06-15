import 'dart:convert';

QuickDocketSubmitResponse quickDocketSubmitResponseFromJson(String str) => QuickDocketSubmitResponse.fromJson(json.decode(str));

String quickDocketSubmitResponseToJson(QuickDocketSubmitResponse data) => json.encode(data.toJson());

class QuickDocketSubmitResponse {
  final int statusCode;
  final int status;
  final Data data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  QuickDocketSubmitResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory QuickDocketSubmitResponse.fromJson(Map<String, dynamic> json) => QuickDocketSubmitResponse(
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
  final String docketno;
  final String orgncd;
  final String destcd;
  final String dockdt;
  final dynamic podName;
  final String originDest;
  final dynamic cnor;
  final dynamic cnee;
  final double pkgsno;
  final String cdeldt;
  final dynamic getTrackingData;

  Data({
    required this.docketno,
    required this.orgncd,
    required this.destcd,
    required this.dockdt,
    required this.podName,
    required this.originDest,
    required this.cnor,
    required this.cnee,
    required this.pkgsno,
    required this.cdeldt,
    required this.getTrackingData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    docketno: json["docketno"],
    orgncd: json["orgncd"],
    destcd: json["destcd"],
    dockdt: json["dockdt"],
    podName: json["podName"],
    originDest: json["origin_dest"],
    cnor: json["cnor"],
    cnee: json["cnee"],
    pkgsno: json["pkgsno"],
    cdeldt: json["cdeldt"],
    getTrackingData: json["getTracking_data"],
  );

  Map<String, dynamic> toJson() => {
    "docketno": docketno,
    "orgncd": orgncd,
    "destcd": destcd,
    "dockdt": dockdt,
    "podName": podName,
    "origin_dest": originDest,
    "cnor": cnor,
    "cnee": cnee,
    "pkgsno": pkgsno,
    "cdeldt": cdeldt,
    "getTracking_data": getTrackingData,
  };
}
