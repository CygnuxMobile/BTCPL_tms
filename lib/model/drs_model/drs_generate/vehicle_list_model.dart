import 'dart:convert';

VehicleListResponse vehicleListResponseFromJson(String str) => VehicleListResponse.fromJson(json.decode(str));

class VehicleListResponse {
  int statusCode;
  int status;
  VehicleListData data;
  dynamic errors;
  dynamic metaData;
  String message;

  VehicleListResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory VehicleListResponse.fromJson(Map<String, dynamic> json) => VehicleListResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: VehicleListData.fromJson(json["data"] ?? {}),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class VehicleListData {
  List<VehicleItem> mvLists;

  VehicleListData({
    required this.mvLists,
  });

  factory VehicleListData.fromJson(Map<String, dynamic> json) => VehicleListData(
    mvLists: json["mvLists"] != null 
        ? List<VehicleItem>.from(json["mvLists"].map((x) => VehicleItem.fromJson(x)))
        : [],
  );
}

class VehicleItem {
  String vehno;
  String dispVehicle;

  VehicleItem({
    required this.vehno,
    required this.dispVehicle,
  });

  factory VehicleItem.fromJson(Map<String, dynamic> json) => VehicleItem(
    vehno: json["vehno"] ?? "",
    dispVehicle: json["dispVehicle"] ?? "",
  );
}
