import 'dart:convert';

CrossingAgentResponse crossingAgentResponseFromJson(String str) => CrossingAgentResponse.fromJson(json.decode(str));

class CrossingAgentResponse {
  int statusCode;
  int status;
  CrossingAgentData data;
  dynamic errors;
  dynamic metaData;
  String message;

  CrossingAgentResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory CrossingAgentResponse.fromJson(Map<String, dynamic> json) => CrossingAgentResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: CrossingAgentData.fromJson(json["data"] ?? {}),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class CrossingAgentData {
  List<CrossingAgentItem> venderscodes;

  CrossingAgentData({
    required this.venderscodes,
  });

  factory CrossingAgentData.fromJson(Map<String, dynamic> json) => CrossingAgentData(
    venderscodes: json["venderscodes"] != null 
        ? List<CrossingAgentItem>.from(json["venderscodes"].map((x) => CrossingAgentItem.fromJson(x)))
        : [],
  );
}

class CrossingAgentItem {
  String vendorcode;
  String vendorname;

  CrossingAgentItem({
    required this.vendorcode,
    required this.vendorname,
  });

  factory CrossingAgentItem.fromJson(Map<String, dynamic> json) => CrossingAgentItem(
    vendorcode: json["vendorcode"] ?? "",
    vendorname: json["vendorname"] ?? "",
  );
}
