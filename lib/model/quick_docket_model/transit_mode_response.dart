import 'dart:convert';

TransitModeResponse transitModeResponseFromJson(String str) =>
    TransitModeResponse.fromJson(json.decode(str));

String transitModeResponseToJson(TransitModeResponse data) =>
    json.encode(data.toJson());

class TransitModeResponse {
  TransitModeResponse({
    required this.transitModeList,
    required this.message,
    required this.statusCode,
    required this.status,
  });

  List<TransitMode> transitModeList;
  String message;
  int statusCode;
  int status;

  factory TransitModeResponse.fromJson(Map<dynamic, dynamic> json) =>
      TransitModeResponse(
        transitModeList: List<TransitMode>.from(json["data"].map((x) => TransitMode.fromJson(x))),
        message: json["message"],
        statusCode: json["statusCode"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(transitModeList.map((x) => x.toJson())),
        "message": message,
        "statusCode": statusCode,
        "status": status,
      };
}

class TransitMode {
  TransitMode({
    required this.codeId,
    required this.codeDesc,
    required this.codeType,
    required this.codeAccess,
  });

  String codeId;
  String codeDesc;
  String codeType;
  String codeAccess;

  factory TransitMode.fromJson(Map<dynamic, dynamic> json) => TransitMode(
        codeId: json["codeId"] ?? "",
        codeDesc: json["codeDesc"] ?? "",
        codeType: json["codeType"] ?? "",
        codeAccess: json["codeAccess"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "codeId": codeId,
        "codeDesc": codeDesc,
        "codeType": codeType,
        "codeAccess": codeAccess,
      };
}
