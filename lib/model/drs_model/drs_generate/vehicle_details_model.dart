import 'dart:convert';

VehicleDetailsResponse vehicleDetailsResponseFromJson(String str) => VehicleDetailsResponse.fromJson(json.decode(str));

class VehicleDetailsResponse {
  int statusCode;
  int status;
  VehicleDetailsData data;
  dynamic errors;
  dynamic metaData;
  String message;

  VehicleDetailsResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory VehicleDetailsResponse.fromJson(Map<String, dynamic> json) => VehicleDetailsResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: VehicleDetailsData.fromJson(json["data"] ?? {}),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class VehicleDetailsData {
  List<VehicleDetailItem> getVehicle;

  VehicleDetailsData({
    required this.getVehicle,
  });

  factory VehicleDetailsData.fromJson(Map<String, dynamic> json) => VehicleDetailsData(
    getVehicle: json["getVehicle"] != null 
        ? List<VehicleDetailItem>.from(json["getVehicle"].map((x) => VehicleDetailItem.fromJson(x)))
        : [],
  );
}

class VehicleDetailItem {
  String vehno;
  String chasisNo;
  String engineNo;
  String rcBookNo;
  String registrationDt;
  String insuranceValDt;
  String fitnessValDt;
  String vehprmdt;
  String vehicle_Type;
  String type_Name;
  double capacity;
  double rate_Per_KM;
  String fuel_Type;
  double usedcapacity;
  double payload;
  String vehicle_Active;
  String vehicle_Type_Active;
  String ftltyPe;
  String ftltypE_NAME;
  dynamic vendorCode;
  double startKM;

  VehicleDetailItem({
    required this.vehno,
    required this.chasisNo,
    required this.engineNo,
    required this.rcBookNo,
    required this.registrationDt,
    required this.insuranceValDt,
    required this.fitnessValDt,
    required this.vehprmdt,
    required this.vehicle_Type,
    required this.type_Name,
    required this.capacity,
    required this.rate_Per_KM,
    required this.fuel_Type,
    required this.usedcapacity,
    required this.payload,
    required this.vehicle_Active,
    required this.vehicle_Type_Active,
    required this.ftltyPe,
    required this.ftltypE_NAME,
    this.vendorCode,
    required this.startKM,
  });

  factory VehicleDetailItem.fromJson(Map<String, dynamic> json) => VehicleDetailItem(
    vehno: json["vehno"] ?? "",
    chasisNo: json["chasisNo"] ?? "",
    engineNo: json["engineNo"] ?? "",
    rcBookNo: json["rcBookNo"] ?? "",
    registrationDt: json["registrationDt"] ?? "",
    insuranceValDt: json["insuranceValDt"] ?? "",
    fitnessValDt: json["fitnessValDt"] ?? "",
    vehprmdt: json["vehprmdt"] ?? "",
    vehicle_Type: json["vehicle_Type"] ?? "",
    type_Name: json["type_Name"] ?? "",
    capacity: (json["capacity"] ?? 0).toDouble(),
    rate_Per_KM: (json["rate_Per_KM"] ?? 0).toDouble(),
    fuel_Type: json["fuel_Type"] ?? "",
    usedcapacity: (json["usedcapacity"] ?? 0).toDouble(),
    payload: (json["payload"] ?? 0).toDouble(),
    vehicle_Active: json["vehicle_Active"] ?? "",
    vehicle_Type_Active: json["vehicle_Type_Active"] ?? "",
    ftltyPe: json["ftltyPe"] ?? "",
    ftltypE_NAME: json["ftltypE_NAME"] ?? "",
    vendorCode: json["vendorCode"],
    startKM: (json["startKM"] ?? 0).toDouble(),
  );
}
