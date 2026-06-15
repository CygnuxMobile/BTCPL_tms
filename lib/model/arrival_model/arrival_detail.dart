import 'dart:convert';

ThcArrivalsListData thcArrivalsListDataFromJson(String str) => ThcArrivalsListData.fromJson(json.decode(str));

String thcArrivalsListDataToJson(ThcArrivalsListData data) => json.encode(data.toJson());

class ThcArrivalsListData {
  ThcArrivalsListData({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  final int statusCode;
  final int status;
  final List<ThcData> data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  factory ThcArrivalsListData.fromJson(Map<String, dynamic> json) => ThcArrivalsListData(
    statusCode: json["statusCode"],
    status: json["status"],
    data: List<ThcData>.from(json["data"].map((x) => ThcData.fromJson(x))),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "errors": errors,
    "metaData": metaData,
    "message": message,
  };
}

class ThcData {
  ThcData({
    required this.thcno,
    required this.thcDate,
    required this.previousBranch,
    required this.route,
    required this.vehicle,
    required this.ata,
    required this.atd,
    required this.status,
    required this.manualThcNo,
    required this.nextLocation,
    required this.routeCode,
    required this.thcdt,
    required this.openkm,
    required this.thcDateDdmmYyyy,
    required this.eta,
    required this.stoppageTimeMins,
    required this.chrgwt,
    required this.pkgsno,
    required this.runCat,
    required this.companyCode,
    required this.datumEtA,
    required this.etA,
    required this.atD,
    required this.docketBcSerials,
  });

  final String thcno;
  final String thcDate;
  final String previousBranch;
  final String route;
  final String vehicle;
  final dynamic ata;
  final String atd;
  final String status;
  final String manualThcNo;
  final String nextLocation;
  final String routeCode;
  final String thcdt;
  final dynamic openkm;
  final String thcDateDdmmYyyy;
  final String eta;
  final dynamic stoppageTimeMins;
  final dynamic chrgwt;
  final dynamic pkgsno;
  final String runCat;
  final String companyCode;
  final String datumEtA;
  final String etA;
  final String atD;
  final List<DocketBcSerial> docketBcSerials;

  factory ThcData.fromJson(Map<String, dynamic> json) => ThcData(
    thcno: json["thcno"],
    thcDate: json["thcDate"],
    previousBranch: json["previousBranch"],
    route: json["route"],
    vehicle: json["vehicle"],
    ata: json["ata"],
    atd: json["atd"],
    status: json["status"],
    manualThcNo: json["manualTHCNo"],
    nextLocation: json["nextLocation"],
    routeCode: json["routeCode"],
    thcdt: json["thcdt"],
    openkm: json["openkm"],
    thcDateDdmmYyyy: json["thcDate_ddmmYYYY"],
    eta: json["eta"],
    stoppageTimeMins: json["stoppage_Time_Mins"],
    chrgwt: json["chrgwt"],
    pkgsno: json["pkgsno"],
    runCat: json["run_cat"],
    companyCode: json["companyCode"],
    datumEtA: json["etA__"],
    etA: json["etA_"],
    atD: json["atD_"],
    docketBcSerials: List<DocketBcSerial>.from(json["docket_BCSerials"].map((x) => DocketBcSerial.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "thcno": thcno,
    "thcDate": thcDate,
    "previousBranch": previousBranch,
    "route": route,
    "vehicle": vehicle,
    "ata": ata,
    "atd": atd,
    "status": status,
    "manualTHCNo": manualThcNo,
    "nextLocation": nextLocation,
    "routeCode": routeCode,
    "thcdt": thcdt,
    "openkm": openkm,
    "thcDate_ddmmYYYY": thcDateDdmmYyyy,
    "eta": eta,
    "stoppage_Time_Mins": stoppageTimeMins,
    "chrgwt": chrgwt,
    "pkgsno": pkgsno,
    "run_cat": runCat,
    "companyCode": companyCode,
    "etA__": datumEtA,
    "etA_": etA,
    "atD_": atD,
    "docket_BCSerials": List<dynamic>.from(docketBcSerials.map((x) => x.toJson())),
  };
}

class DocketBcSerial {
  DocketBcSerial({
    required this.dockno,
    required this.docksf,
    required this.bcSerialNo,
    required this.mf,
    required this.thc,
  });

  final String dockno;
  final String docksf;
  final String bcSerialNo;
  final String mf;
  final String thc;

  factory DocketBcSerial.fromJson(Map<String, dynamic> json) => DocketBcSerial(
    dockno: json["dockno"],
    docksf: json["docksf"],
    bcSerialNo: json["bcSerialNo"],
    mf: json["mf"],
    thc: json["thc"],
  );

  Map<String, dynamic> toJson() => {
    "dockno": dockno,
    "docksf": docksf,
    "bcSerialNo": bcSerialNo,
    "mf": mf,
    "thc": thc,
  };
}
