import 'dart:convert';

StockUpdateDetails stockUpdateDetailsFromJson(String str) =>
    StockUpdateDetails.fromJson(json.decode(str));

String stockUpdateDetailsToJson(StockUpdateDetails data) =>
    json.encode(data.toJson());

String stockUpdateDetailToJson(StockUpdateDetail data) =>
    json.encode(data.toJson());

class StockUpdateDetails {
  static StockUpdateDetails? _instance;

  final String updateDate;
  final String baseUserName;
  final String baseLocationCode;
  final List<StockUpdateDetail> stockUpdateDetails;
  final List<BsSerial> bsSerials;

  StockUpdateDetails({
    required this.updateDate,
    required this.baseUserName,
    required this.baseLocationCode,
    required this.stockUpdateDetails,
    required this.bsSerials,
  });

  factory StockUpdateDetails.fromJson(Map<String, dynamic> json) {
    _instance ??= StockUpdateDetails._initializeFromJson(json);
    return _instance!;
  }

  StockUpdateDetails._initializeFromJson(Map<String, dynamic> json)
      : updateDate = json["updateDate"],
        baseUserName = json["baseUserName"],
        baseLocationCode = json["baseLocationCode"],
        stockUpdateDetails = List<StockUpdateDetail>.from(json["stockUpdateDetails"].map((detailJson) => StockUpdateDetail.fromJson(detailJson))),
        bsSerials = List<BsSerial>.from(json["bsSerials"].map((x) => BsSerial.fromJson(x)));

  Map<String, dynamic> toJson() => {
    "updateDate": updateDate,
    "baseUserName": baseUserName,
    "baseLocationCode": baseLocationCode,
    "stockUpdateDetails": List<dynamic>.from(stockUpdateDetails.map((detail) => detail.toJson())),
    "bsSerials": List<dynamic>.from(bsSerials.map((x) => x.toJson())),
  };
}


class BsSerial {
  final String dockno;
  final String docksf;
  final String bcSerialNo;
  final String mf;
  final String thc;

  BsSerial({
    required this.dockno,
    required this.docksf,
    required this.bcSerialNo,
    required this.mf,
    required this.thc,
  });

  factory BsSerial.fromJson(Map<String, dynamic> json) => BsSerial(
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

class StockUpdateDetail {
  final String tcno;
  final String dockNo;
  final String dockSf;
  final int bkGPkgsno;
  final int pkgsno;
  final int bkGActuwt;
  final int actuwt;
  final String ac;
  final String wi;
  final String cdelydt;
  final String delyreason;
  final String dp;
  final int coddodAmount;
  final int coddodcollected;
  final String coddod;
  final bool isCounterDelivery;
  final int shortageQty;
  final int shortageWeight;
  final String shortageReason;
  final String shortageRemarks;
  final int pilferageQty;
  final int pilferageWeight;
  final String pilferageReason;
  final String pilferageRemarks;
  final int damageQry;
  final int damageWeight;
  final String damageReason;
  final String damageRemarks;
  final String isCoddodChar;
  final String delyperson;
  final List<AgeFileName> pilferageFileName;
  final List<AgeFileName> damageFileName;

  StockUpdateDetail({
    required this.tcno,
    required this.dockNo,
    required this.dockSf,
    required this.bkGPkgsno,
    required this.pkgsno,
    required this.bkGActuwt,
    required this.actuwt,
    required this.ac,
    required this.wi,
    required this.cdelydt,
    required this.delyreason,
    required this.dp,
    required this.coddodAmount,
    required this.coddodcollected,
    required this.coddod,
    required this.isCounterDelivery,
    required this.shortageQty,
    required this.shortageWeight,
    required this.shortageReason,
    required this.shortageRemarks,
    required this.pilferageQty,
    required this.pilferageWeight,
    required this.pilferageReason,
    required this.pilferageRemarks,
    required this.damageQry,
    required this.damageWeight,
    required this.damageReason,
    required this.damageRemarks,
    required this.isCoddodChar,
    required this.delyperson,
    required this.pilferageFileName,
    required this.damageFileName,
  });

  factory StockUpdateDetail.fromJson(Map<String, dynamic> json) =>
      StockUpdateDetail(
        tcno: json["tcno"],
        dockNo: json["dockNo"],
        dockSf: json["dockSF"],
        bkGPkgsno: json["bkG_PKGSNO"],
        pkgsno: json["pkgsno"],
        bkGActuwt: json["bkG_ACTUWT"],
        actuwt: json["actuwt"],
        ac: json["ac"],
        wi: json["wi"],
        cdelydt: json["cdelydt"],
        delyreason: json["delyreason"],
        dp: json["dp"],
        coddodAmount: json["coddodAmount"],
        coddodcollected: json["coddodcollected"],
        coddod: json["coddod"],
        isCounterDelivery: json["isCounterDelivery"],
        shortageQty: json["shortageQty"],
        shortageWeight: json["shortageWeight"],
        shortageReason: json["shortageReason"],
        shortageRemarks: json["shortageRemarks"],
        pilferageQty: json["pilferageQty"],
        pilferageWeight: json["pilferageWeight"],
        pilferageReason: json["pilferageReason"],
        pilferageRemarks: json["pilferageRemarks"],
        damageQry: json["damageQry"],
        damageWeight: json["damageWeight"],
        damageReason: json["damageReason"],
        damageRemarks: json["damageRemarks"],
        isCoddodChar: json["isCODDODChar"],
        delyperson: json["delyperson"],
        pilferageFileName: List<AgeFileName>.from(
            json["pilferageFileName"].map((x) => AgeFileName.fromJson(x))),
        damageFileName: List<AgeFileName>.from(
            json["damageFileName"].map((x) => AgeFileName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tcno": tcno,
        "dockNo": dockNo,
        "dockSF": dockSf,
        "bkG_PKGSNO": bkGPkgsno,
        "pkgsno": pkgsno,
        "bkG_ACTUWT": bkGActuwt,
        "actuwt": actuwt,
        "ac": ac,
        "wi": wi,
        "cdelydt": cdelydt,
        "delyreason": delyreason,
        "dp": dp,
        "coddodAmount": coddodAmount,
        "coddodcollected": coddodcollected,
        "coddod": coddod,
        "isCounterDelivery": isCounterDelivery,
        "shortageQty": shortageQty,
        "shortageWeight": shortageWeight,
        "shortageReason": shortageReason,
        "shortageRemarks": shortageRemarks,
        "pilferageQty": pilferageQty,
        "pilferageWeight": pilferageWeight,
        "pilferageReason": pilferageReason,
        "pilferageRemarks": pilferageRemarks,
        "damageQry": damageQry,
        "damageWeight": damageWeight,
        "damageReason": damageReason,
        "damageRemarks": damageRemarks,
        "isCODDODChar": isCoddodChar,
        "delyperson": delyperson,
        "pilferageFileName":
            List<dynamic>.from(pilferageFileName.map((x) => x.toJson())),
        "damageFileName":
            List<dynamic>.from(damageFileName.map((x) => x.toJson())),
      };
}

class AgeFileName {
  final String image;
  final String mf;

  AgeFileName({
    required this.image,
    required this.mf,
  });

  factory AgeFileName.fromJson(Map<String, dynamic> json) => AgeFileName(
        image: json["image"],
        mf: json["mf"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "mf": mf,
      };
}
