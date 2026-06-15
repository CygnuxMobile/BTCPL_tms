import 'dart:convert';

CheckValidSerialNoresponse checkValidSerialNoresponseFromJson(String str) => CheckValidSerialNoresponse.fromJson(json.decode(str));

String checkValidSerialNoresponseToJson(CheckValidSerialNoresponse data) => json.encode(data.toJson());

class CheckValidSerialNoresponse {
  CheckValidSerialNoresponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  final int statusCode;
  final int status;
  final Data data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  factory CheckValidSerialNoresponse.fromJson(Map<String, dynamic> json) => CheckValidSerialNoresponse(
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
  Data({
    required this.bcSerialNo,
    required this.dockno,
    required this.docksf,
    required this.status,
    required this.loadPkg,
    required this.loadWt,
    required this.actuwt,
    required this.totalPkg,
    required this.orgCode,
    required this.reDestCode,
    required this.docketDate,
    required this.bcserials,
  });

  final String? bcSerialNo;
  final String? dockno;
  final String? docksf;
  final int? status;
  final int ? loadPkg ;
  final dynamic loadWt;
  final int? actuwt;
  final int? totalPkg;
  final String? orgCode;
  final String? reDestCode;
  final String? docketDate;
  final List<Bcserial>? bcserials;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bcSerialNo: json["bcSerialNo"],
    dockno: json["dockno"],
    docksf: json["docksf"],
    status: json["status"],
    loadPkg: json["loadPkg"],
    loadWt: json["loadWt"],
    actuwt: json["actuwt"],
    totalPkg: json["totalPkg"],
    orgCode: json["orgCode"],
    reDestCode: json["reDestCode"],
    docketDate: json["docketDate"],
    bcserials: List<Bcserial>.from(json["bcserials"].map((x) => Bcserial.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bcSerialNo": bcSerialNo,
    "dockno": dockno,
    "docksf": docksf,
    "status": status,
    "loadPkg": loadPkg,
    "loadWt": loadWt,
    "actuwt": actuwt,
    "totalPkg": totalPkg,
    "orgCode": orgCode,
    "reDestCode": reDestCode,
    "docketDate": docketDate,
    "bcserials": List<dynamic>.from(bcserials!.map((x) => x.toJson())),
  };
}

class Bcserial {
  Bcserial({
    required this.dockNo,
    required this.bcSerialNo,
    this.isScanPkg = false,
  });

  final String dockNo;
  final String bcSerialNo;
  bool? isScanPkg;

  factory Bcserial.fromJson(Map<String, dynamic> json) => Bcserial(
    dockNo: json["dockNo"],
    bcSerialNo: json["bcSerialNo"],
  );

  Map<String, dynamic> toJson() => {"dockNo": dockNo, "bcSerialNo": bcSerialNo};
}
