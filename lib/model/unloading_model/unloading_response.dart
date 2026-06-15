import 'dart:convert';

UnloadingResponse unloadingResponseFromJson(String str) =>
    UnloadingResponse.fromJson(json.decode(str));

String unloadingResponseToJson(UnloadingResponse data) =>
    json.encode(data.toJson());

class UnloadingResponse {
  final String statusCode;
  final String status;
  final Data data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  UnloadingResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory UnloadingResponse.fromJson(Map<String, dynamic> json) =>
      UnloadingResponse(
        statusCode: json["statusCode"].toString(),
        status: json["status"].toString(),
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
  final String orgncd;
  final String route;
  final String eta;
  final String thcdt;
  final String vehno;
  final String thcno;
  final List<GetLsNoDatum> getLsNoData;

  Data({
    required this.orgncd,
    required this.route,
    required this.eta,
    required this.thcdt,
    required this.vehno,
    required this.thcno,
    required this.getLsNoData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orgncd: json["orgncd"] ?? '',
        route: json["route"] ?? '',
        eta: json["eta"] ?? '',
        thcdt: json["thcdt"] ?? '',
        vehno: json["vehno"] ?? '',
        thcno: json["thcno"] ?? '',
        getLsNoData: List<GetLsNoDatum>.from(
            json["getLSNo_data"].map((x) => GetLsNoDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orgncd": orgncd,
        "route": route,
        "eta": eta,
        "thcdt": thcdt,
        "vehno": vehno,
        "thcno": thcno,
        "getLSNo_data": List<dynamic>.from(getLsNoData.map((x) => x.toJson())),
      };
}

class GetLsNoDatum {
  final String dockno;
  final String mode;
  final String dockdt;
  final String location;
  final String csgenm;
  final String csgnnm;
  final String nopkgs;
  final String actuwt;
  final String thcbr;
  final String totalLoadpkgsno;
  final String totalLoadactuwt;

  GetLsNoDatum({
    required this.dockno,
    required this.mode,
    required this.dockdt,
    required this.location,
    required this.csgenm,
    required this.csgnnm,
    required this.nopkgs,
    required this.actuwt,
    required this.thcbr,
    required this.totalLoadpkgsno,
    required this.totalLoadactuwt,
  });

  factory GetLsNoDatum.fromJson(Map<String, dynamic> json) => GetLsNoDatum(
        dockno: json["dockno"] ?? '',
        mode: json["mode"] ?? '',
        dockdt: json["dockdt"] ?? '',
        location: json["location"] ?? '',
        csgenm: json["csgenm"] ?? '',
        csgnnm: json["csgnnm"] ?? '',
        nopkgs: json["nopkgs"].toString() ??'0',
        actuwt: json["actuwt"].toString() ?? '0',
        thcbr: json["thcbr"] ?? '',
        totalLoadpkgsno: json["total_LOADPKGSNO"].toString() ?? '0.0',
        totalLoadactuwt: json["total_LOADACTUWT"].toString() ?? '0.0',
      );

  Map<String, dynamic> toJson() => {
        "dockno": dockno,
        "mode": mode,
        "dockdt": dockdt,
        "location": location,
        "csgenm": csgenm,
        "csgnnm": csgnnm,
        "nopkgs": nopkgs,
        "actuwt": actuwt,
        "thcbr": thcbr,
        "total_LOADPKGSNO": totalLoadpkgsno,
        "total_LOADACTUWT": totalLoadactuwt,
      };
}
