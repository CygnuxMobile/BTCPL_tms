import 'dart:convert';

GeneralMasterResponse generalMasterResponseFromJson(String str) => GeneralMasterResponse.fromJson(json.decode(str));

String generalMasterResponseToJson(GeneralMasterResponse data) => json.encode(data.toJson());

class GeneralMasterResponse {
  final int statusCode;
  final int status;
  final List<GeneralMasterList> generalMasterList;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  GeneralMasterResponse({
    required this.statusCode,
    required this.status,
    required this.generalMasterList,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory GeneralMasterResponse.fromJson(Map<String, dynamic> json) => GeneralMasterResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    generalMasterList: List<GeneralMasterList>.from(json["data"].map((x) => GeneralMasterList.fromJson(x))),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "data": List<dynamic>.from(generalMasterList.map((x) => x.toJson())),
    "errors": errors,
    "metaData": metaData,
    "message": message,
  };
}

class GeneralMasterList {
  final String codeType;
  final String codeId;
  final String codeDesc;
  final String codeAccess;

  GeneralMasterList({
    required this.codeType,
    required this.codeId,
    required this.codeDesc,
    required this.codeAccess,
  });

  factory GeneralMasterList.fromJson(Map<String, dynamic> json) => GeneralMasterList(
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
