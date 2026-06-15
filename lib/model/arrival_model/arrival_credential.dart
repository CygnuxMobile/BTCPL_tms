import 'dart:convert';

ThcArrivalsList thcArrivalsListFromJson(String str) => ThcArrivalsList.fromJson(json.decode(str));

String thcArrivalsListToJson(ThcArrivalsList data) => json.encode(data.toJson());

class ThcArrivalsList {
  ThcArrivalsList({
    required this.thcNo,
    required this.fromDate,
    required this.toDate,
    required this.transportMode,
    required this.baseLocationCode,
    required this.baseComapnyCode,
    required this.baseusername,
  });

  final String thcNo;
  final String fromDate;
  final String toDate;
  final String transportMode;
  final String baseLocationCode;
  final String baseComapnyCode;
  final String baseusername;

  factory ThcArrivalsList.fromJson(Map<String, dynamic> json) => ThcArrivalsList(
    thcNo: json["thcNo"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    transportMode: json["transportMode"],
    baseLocationCode: json["baseLocationCode"],
    baseComapnyCode: json["baseComapnyCode"],
    baseusername: json['baseusername'],
  );

  Map<String, dynamic> toJson() => {
    "thcNo": thcNo,
    "fromDate": fromDate,
    "toDate": toDate,
    "transportMode": transportMode,
    "baseLocationCode": baseLocationCode,
    "baseComapnyCode": baseComapnyCode,
    "baseusername": baseusername,
  };
}
