import 'dart:convert';

DocketDetail docketDetailFromJson(String str) => DocketDetail.fromJson(json.decode(str));

String docketDetailToJson(DocketDetail data) => json.encode(data.toJson());

class DocketDetail {
  DocketDetail({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  final int statusCode;
  final int status;
  final List<DocketInfo> data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  factory DocketDetail.fromJson(Map<String, dynamic> json) => DocketDetail(
        statusCode: json["statusCode"],
        status: json["status"],
        data: List<DocketInfo>.from(json["data"].map((x) => DocketInfo.fromJson(x))),
        errors: json["errors"],
        metaData: json["metaData"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errors": errors,
        "metaData": metaData,
        "message": message,
      };
}

class DocketInfo {
  DocketInfo({
    required this.dockno,
    required this.manualDockno,
    required this.dockdt,
    required this.edd,
    required this.orgncd,
    required this.pkgsno,
    required this.actuwt,
    required this.reassigNDestcd,
    required this.csgnnm,
    required this.csgenm,
    required this.toloc,
  });

  final String dockno;
  final String manualDockno;
  final String dockdt;
  final String edd;
  final String orgncd;
  final double pkgsno;
  final double actuwt;
  final String reassigNDestcd;
  final String csgnnm;
  final String csgenm;
  final String toloc;

  factory DocketInfo.fromJson(Map<String, dynamic> json) => DocketInfo(
        dockno: json["dockno"] ?? '',
        manualDockno: json["manual_dockno"] ?? '',
        dockdt: json["dockdt"] ?? '',
        edd: json["edd"] ?? '',
        orgncd: json["orgncd"] ?? '',
        pkgsno: json["pkgsno"] ?? 0.0,
        actuwt: json["actuwt"] ?? 0.0,
        reassigNDestcd: json["reassigN_DESTCD"] ?? '',
        csgnnm: json["csgnnm"] ?? '',
        csgenm: json["csgenm"] ?? '',
        toloc: json["to_loc"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "dockno": dockno,
        "manual_dockno": manualDockno,
        "dockdt": dockdt,
        "edd": edd,
        "orgncd": orgncd,
        "pkgsno": pkgsno,
        "actuwt": actuwt,
        "reassigN_DESTCD": reassigNDestcd,
        "csgnnm": csgnnm,
        "csgenm": csgenm,
      };
}
