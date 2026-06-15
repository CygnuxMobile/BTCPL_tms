// To parse this JSON data, do
//
//     final cityResponse = cityResponseFromJson(jsonString);

import 'dart:convert';

CityResponse cityResponseFromJson(String str) => CityResponse.fromJson(json.decode(str));

String cityResponseToJson(CityResponse data) => json.encode(data.toJson());

class CityResponse {
  int statusCode;
  int status;
  Data data;
  dynamic errors;
  dynamic metaData;
  String message;

  CityResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
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
  List<CityList> cityList;

  Data({
    required this.cityList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cityList: List<CityList>.from(json["cityList"].map((x) => CityList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cityList": List<dynamic>.from(cityList.map((x) => x.toJson())),
      };
}

class CityList {
  String location;
  int cityCode;

  CityList({
    required this.location,
    required this.cityCode,
  });

  factory CityList.fromJson(Map<String, dynamic> json) => CityList(
        location: json["location"] ?? '',
        cityCode: json["city_code"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "city_code": cityCode,
      };
}
