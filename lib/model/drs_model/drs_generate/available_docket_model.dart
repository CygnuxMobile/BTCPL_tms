import 'dart:convert';

AvailableDocketResponse availableDocketResponseFromJson(String str) => AvailableDocketResponse.fromJson(json.decode(str));

class AvailableDocketResponse {
  int statusCode;
  int status;
  List<AvailableDocketItem> data;
  dynamic errors;
  dynamic metaData;
  String message;

  AvailableDocketResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory AvailableDocketResponse.fromJson(Map<String, dynamic> json) => AvailableDocketResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: json["data"] != null 
        ? List<AvailableDocketItem>.from(json["data"].map((x) => AvailableDocketItem.fromJson(x)))
        : [],
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class AvailableDocketItem {
  String dockno;
  String docksf;
  String manual_dockno;
  String docket_Mode;
  String bkg_Date;
  String commited_Dely_Date;
  String orgncd;
  String desT_CD;
  String curr_Loc;
  int pendPkgQty;
  int arrPkgQty;
  int pkgsno;
  String payBas;
  String paybaS_Str;
  String cdeldt;
  String businesstype;
  String trN_MOD;
  double actuwt;
  double arrWeightQty;
  double chrgwt;
  double svctax;
  int cnd;
  int cnt;
  String eWayBillNo;
  String message;
  dynamic staff_BA;
  bool isEnabled;
  int pkgsnO_Load;
  double chrgwT_Load;
  double contractAmount;
  dynamic bcSerialNo;

  AvailableDocketItem({
    required this.dockno,
    required this.docksf,
    required this.manual_dockno,
    required this.docket_Mode,
    required this.bkg_Date,
    required this.commited_Dely_Date,
    required this.orgncd,
    required this.desT_CD,
    required this.curr_Loc,
    required this.pendPkgQty,
    required this.arrPkgQty,
    required this.pkgsno,
    required this.payBas,
    required this.paybaS_Str,
    required this.cdeldt,
    required this.businesstype,
    required this.trN_MOD,
    required this.actuwt,
    required this.arrWeightQty,
    required this.chrgwt,
    required this.svctax,
    required this.cnd,
    required this.cnt,
    required this.eWayBillNo,
    required this.message,
    this.staff_BA,
    required this.isEnabled,
    required this.pkgsnO_Load,
    required this.chrgwT_Load,
    required this.contractAmount,
    this.bcSerialNo,
  });

  factory AvailableDocketItem.fromJson(Map<String, dynamic> json) => AvailableDocketItem(
    dockno: json["dockno"] ?? "",
    docksf: json["docksf"] ?? "",
    manual_dockno: json["manual_dockno"] ?? "",
    docket_Mode: json["docket_Mode"] ?? "",
    bkg_Date: json["bkg_Date"] ?? "",
    commited_Dely_Date: json["commited_Dely_Date"] ?? "",
    orgncd: json["orgncd"] ?? "",
    desT_CD: json["desT_CD"] ?? "",
    curr_Loc: json["curr_Loc"] ?? "",
    pendPkgQty: json["pendPkgQty"] ?? 0,
    arrPkgQty: json["arrPkgQty"] ?? 0,
    pkgsno: json["pkgsno"] ?? 0,
    payBas: json["payBas"] ?? "",
    paybaS_Str: json["paybaS_Str"] ?? "",
    cdeldt: json["cdeldt"] ?? "",
    businesstype: json["businesstype"] ?? "",
    trN_MOD: json["trN_MOD"] ?? "",
    actuwt: (json["actuwt"] ?? 0).toDouble(),
    arrWeightQty: (json["arrWeightQty"] ?? 0).toDouble(),
    chrgwt: (json["chrgwt"] ?? 0).toDouble(),
    svctax: (json["svctax"] ?? 0).toDouble(),
    cnd: json["cnd"] ?? 0,
    cnt: json["cnt"] ?? 0,
    eWayBillNo: json["eWayBillNo"] ?? "",
    message: json["message"] ?? "",
    staff_BA: json["staff_BA"],
    isEnabled: json["isEnabled"] ?? false,
    pkgsnO_Load: json["pkgsnO_Load"] ?? 0,
    chrgwT_Load: (json["chrgwT_Load"] ?? 0).toDouble(),
    contractAmount: (json["contractAmount"] ?? 0).toDouble(),
    bcSerialNo: json["bcSerialNo"],
  );
}
