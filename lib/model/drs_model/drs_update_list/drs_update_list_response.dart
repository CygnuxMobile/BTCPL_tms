import 'dart:convert';

DrsUpdateListResponse drsUpdateListResponseFromJson(String str) =>
    DrsUpdateListResponse.fromJson(json.decode(str));

String drsUpdateListResponseToJson(DrsUpdateListResponse data) =>
    json.encode(data.toJson());

class DrsUpdateListResponse {
  final int statusCode;
  final int status;
  final Data data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  DrsUpdateListResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory DrsUpdateListResponse.fromJson(Map<String, dynamic> json) =>
      DrsUpdateListResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
        errors: json["errors"] ?? '',
        metaData: json["metaData"] ?? '',
        message: json["message"] ?? '',
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
  final List<DrsList> drsLists;

  Data({
    required this.drsLists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        drsLists: List<DrsList>.from(
            json["drsLists"].map((x) => DrsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drsLists": List<dynamic>.from(drsLists.map((x) => x.toJson())),
      };
}

class DrsList {
  final String pdcno;
  final int toTDkt;
  final String deliveryAgent;
  final String pdcdt;

  DrsList({
    required this.pdcno,
    required this.toTDkt,
    required this.deliveryAgent,
    required this.pdcdt,
  });

  factory DrsList.fromJson(Map<String, dynamic> json) => DrsList(
        pdcno: json["pdcno"] ?? '',
        toTDkt: json["toT_DKT"] ?? 0,
        deliveryAgent: json["deliveryAgent"] ?? '',
        pdcdt: json["pdcdt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "pdcno": pdcno,
        "toT_DKT": toTDkt,
        "deliveryAgent": deliveryAgent,
        "pdcdt": pdcdt,
      };
}
