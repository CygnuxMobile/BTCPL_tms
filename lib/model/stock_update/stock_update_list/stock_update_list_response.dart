import 'dart:convert';

import 'package:get/get.dart';

StockUpdateListResponse stockUpdateListResponseFromJson(String str) =>
    StockUpdateListResponse.fromJson(json.decode(str));

String stockUpdateListResponseToJson(StockUpdateListResponse data) =>
    json.encode(data.toJson());

class StockUpdateListResponse {
  final String statusCode;
  final int status;
  final List<StockUpdateDataList> stockUpdateDataList;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  StockUpdateListResponse({
    required this.statusCode,
    required this.status,
    required this.stockUpdateDataList,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory StockUpdateListResponse.fromJson(Map<String, dynamic> json) =>
      StockUpdateListResponse(
        statusCode: json["statusCode"].toString(),
        status: json["status"],
        stockUpdateDataList: List<StockUpdateDataList>.from(
            json["data"].map((x) => StockUpdateDataList.fromJson(x))),
        errors: json["errors"].toString(),
        metaData: json["metaData"].toString(),
        message: json["message"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": List<dynamic>.from(stockUpdateDataList.map((x) => x.toJson())),
        "errors": errors,
        "metaData": metaData,
        "message": message,
      };
}

class StockUpdateDataList {
  final String thcno;
  final String thcbr;
  final String thCDate;
  final String vehicleNo;
  final String arrivalDate;
  final String manifestKount;
  final String docketKount;
  final String tctobHCode;
  final String thcdt;
  final String actarrvDt;
  final String routecd;
  final String routename;
  final String bkgPkgsno;
  final String bkgActuwt;
  final List<DocketBcSerialList> docketBcSerialsList;

  StockUpdateDataList({
    required this.thcno,
    required this.thcbr,
    required this.thCDate,
    required this.vehicleNo,
    required this.arrivalDate,
    required this.manifestKount,
    required this.docketKount,
    required this.tctobHCode,
    required this.thcdt,
    required this.actarrvDt,
    required this.routecd,
    required this.routename,
    required this.bkgPkgsno,
    required this.bkgActuwt,
    required this.docketBcSerialsList,
  });

  factory StockUpdateDataList.fromJson(Map<String, dynamic> json) =>
      StockUpdateDataList(
        thcno: json["thcno"].toString(),
        thcbr: json["thcbr"].toString(),
        thCDate: json["thC_Date"].toString(),
        vehicleNo: json["vehicle_No"].toString(),
        arrivalDate: json["arrival_Date"].toString(),
        manifestKount: json["manifestKount"].toString(),
        docketKount: json["docketKount"].toString(),
        tctobHCode: json["tctobH_Code"].toString(),
        thcdt: json["thcdt"].toString().toString(),
        actarrvDt: json["actarrv_dt"].toString(),
        routecd: json["routecd"].toString(),
        routename: json["routename"].toString(),
        bkgPkgsno: json['bkG_PKGSNO'].toString(),
        bkgActuwt: json['bkG_ACTUWT'].toString(),
        docketBcSerialsList: List<DocketBcSerialList>.from(
            json["docket_BCSerials"]
                .map((x) => DocketBcSerialList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "thcno": thcno,
        "thcbr": thcbr,
        "thC_Date": thCDate,
        "vehicle_No": vehicleNo,
        "arrival_Date": arrivalDate,
        "manifestKount": manifestKount,
        "docketKount": docketKount,
        "tctobH_Code": tctobHCode,
        "thcdt": thcdt,
        "actarrv_dt": actarrvDt,
        "routecd": routecd,
        "routename": routename,
        "docket_BCSerials":
            List<dynamic>.from(docketBcSerialsList.map((x) => x.toJson())),
      };
}

class DocketBcSerialList {
  final String dockno;
  final String docksf;
  final String bcSerialNo;
  final String mf;
  final String thc;
  RxBool isScan;
  RxBool isDamage;
  RxBool isAccess;
  RxBool isPillFill;
  RxBool isShortage;
  int? pillFillAgeCount;
  int? damageAgeCount;
  List<String>? damageImages = [];
  List<String>? pillFillImages = [];

  DocketBcSerialList({
    required this.dockno,
    required this.docksf,
    required this.bcSerialNo,
    required this.mf,
    required this.thc,
    required this.isScan,
    required this.isAccess,
    required this.isDamage,
    required this.isPillFill,
    required this.isShortage,
    this.pillFillAgeCount = 0,
    this.damageAgeCount = 0,
    this.damageImages,
    this.pillFillImages,

  });

  // converterFromRX({required bool? intialvalue}) {
  //   return (intialvalue ?? false);
  // }

  factory DocketBcSerialList.fromJson(Map<String, dynamic> json) =>
      DocketBcSerialList(
        dockno: json["dockno"].toString(),
        docksf: json["docksf"].toString(),
        bcSerialNo: json["bcSerialNo"].toString(),
        mf: json["mf"].toString(),
        thc: json["thc"].toString(),
        isScan: RxBool(json["isScan"] ?? false),
        isAccess: RxBool(json["isAccess"] ?? false),
        isDamage: RxBool(json["isDamage"] ?? false),
        isPillFill: RxBool(json["isPillFill"] ?? false),
        isShortage: RxBool(json["isShortage"] ?? false),
      );

  Map<String, dynamic> toJson() => {
        "dockno": dockno,
        "docksf": docksf,
        "bcSerialNo": bcSerialNo,
        "mf": mf,
        "thc": thc,
      };
}
