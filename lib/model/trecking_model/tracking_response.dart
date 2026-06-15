// To parse this JSON data, do
//
//     final treckingResponse = treckingResponseFromJson(jsonString);

import 'dart:convert';

TreckingResponse treckingResponseFromJson(String str) =>
    TreckingResponse.fromJson(json.decode(str));

String treckingResponseToJson(TreckingResponse data) =>
    json.encode(data.toJson());

class TreckingResponse {
  final int statusCode;
  final int status;
  final TrackingData trackingData;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  TreckingResponse({
    required this.statusCode,
    required this.status,
    required this.trackingData,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory TreckingResponse.fromJson(Map<String, dynamic> json) =>
      TreckingResponse(
        statusCode: json["statusCode"] ?? 0,
        status: json["status"] ?? 0,
        trackingData: TrackingData.fromJson(json["data"]),
        errors: json["errors"],
        metaData: json["metaData"],
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": trackingData.toJson(),
        "errors": errors,
        "metaData": metaData,
        "message": message,
      };
}

class TrackingData {
  final String docketno;
  final String docno;
  final String doc_dt;
  final String deldt;
  final String doc_TYPE;
  final String status;
  final String party_as;
  final String totalPkg;
  final String orgncd;
  final String destcd;
  final String dockdt;
  final dynamic podName;
  final String originDest;
  final String cnor;
  final String cnee;
  final String pkgsno;
  final String cdeldt;
  final String podLink;
  final String billingParty;
  final List<GetTrackingDatum> getTrackingData;

  TrackingData({
    required this.docketno,
    required this.docno,
    required this.orgncd,
    required this.destcd,
    required this.doc_dt,
    required this.deldt,
    required this.doc_TYPE,
    required this.status,
    required this.party_as,
    required this.totalPkg,
    required this.dockdt,
    required this.podLink,
    this.podName,
    required this.originDest,
    required this.cnor,
    required this.cnee,
    required this.pkgsno,
    required this.cdeldt,
    required this.billingParty,
    required this.getTrackingData,
  });

  factory TrackingData.fromJson(Map<String, dynamic> json) => TrackingData(
        docketno: json["docketno"] ?? '',
        docno: json["docno"] ?? '',
        orgncd: json["orgncd"] ?? "",
        destcd: json["destcd"] ?? '',
        dockdt: json["dockdt"] ?? '',
        podName: json["podName"] ?? '',
        originDest: json["origin_dest"] ?? '',
        cnor: json["cnor"] ?? "",
        cnee: json["cnee"] ?? '',
        pkgsno: json["pkgsno"].toString(),
        cdeldt: json["cdeldt"] ?? "",
        billingParty: json['billingParty'] ?? '',
        getTrackingData: List<GetTrackingDatum>.from(
            json["getTracking_data"] == null
                ? []
                : json["getTracking_data"]
                    .map((x) => GetTrackingDatum.fromJson(x))),
        doc_dt: json["doc_dt"] ?? '',
        deldt: json["deldt"] ?? '',
        doc_TYPE: json["doc_TYPE"] ?? '',
        status: json["status"] ?? '',
        party_as: json["party_as"] ?? '',
        totalPkg: json["totalPkg"].toString(),
        podLink: json["podLink"] ?? '',
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
        "getTracking_data":
            List<dynamic>.from(getTrackingData.map((x) => x.toJson())),
      };
}

class GetTrackingDatum {
  final String asdtDate;
  final String asdtTime;
  final String activity;
  final String color;

  GetTrackingDatum({
    required this.asdtDate,
    required this.asdtTime,
    required this.activity,
    required this.color,
  });

  factory GetTrackingDatum.fromJson(Map<String, dynamic> json) =>
      GetTrackingDatum(
        asdtDate: json["asdtDate"] ?? '',
        asdtTime: json["asdtTime"] ?? '',
        activity: json["activity"] ?? '',
        color: json["color"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "asdtDate": asdtDate,
        "asdtTime": asdtTime,
        "activity": activity,
        "color": color,
      };
}
