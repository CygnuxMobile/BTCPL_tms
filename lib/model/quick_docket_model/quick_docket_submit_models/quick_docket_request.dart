import 'dart:convert';

QuickDocketSubmitRequest quickDocketSubmitRequestFromJson(String str) =>
    QuickDocketSubmitRequest.fromJson(json.decode(str));

String quickDocketRequestToJson(QuickDocketSubmitRequest data) => json.encode(data.toJson());

class QuickDocketSubmitRequest {
  final String dockdt;
  final String partYCode;
  final String partyName;
  final String orgncd;
  final String paybas;
  final String currFinYear;
  final String baseCompanyCode;
  final String destcd;
  final String dockno;
  final String baseUserName;
  final String transPortModel;
  final String pincode;
  final String toCity;
  final String volYn;
  final String csgncd;
  final String csgnm;
  final String csgnAdd;
  final String csgecd;
  final String csgenm;
  final String csgeAdd;
  final String fromCity;
  final String toPincode;
  final String pkgCode;
  final List<DocketInvoice> docketInvoiceList;

  QuickDocketSubmitRequest({
    required this.dockdt,
    required this.partYCode,
    required this.partyName,
    required this.orgncd,
    required this.paybas,
    required this.currFinYear,
    required this.baseCompanyCode,
    required this.destcd,
    required this.dockno,
    required this.baseUserName,
    required this.transPortModel,
    required this.pincode,
    required this.toCity,
    required this.volYn,
    required this.csgncd,
    required this.csgnm,
    required this.csgnAdd,
    required this.csgecd,
    required this.csgenm,
    required this.csgeAdd,
    required this.fromCity,
    required this.toPincode,
    required this.pkgCode,
    required this.docketInvoiceList,
  });

  factory QuickDocketSubmitRequest.fromJson(Map<String, dynamic> json) => QuickDocketSubmitRequest(
        dockdt: json["dockdt"],
        partYCode: json["partY_CODE"],
        partyName: json["party_name"],
        orgncd: json["orgncd"],
        paybas: json["paybas"],
        currFinYear: json["currFinYear"],
        baseCompanyCode: json["baseCompanyCode"],
        destcd: json["destcd"],
        dockno: json["dockno"],
        baseUserName: json["baseUserName"],
        transPortModel: json["transPortModel"],
        pincode: json["pincode"],
        toCity: json["toCity"],
        volYn: json["vol_yn"],
        csgncd: json["csgncd"],
        csgnm: json["csgnm"],
        csgnAdd: json["csgnAdd"],
        csgecd: json["csgecd"],
        csgenm: json["csgenm"],
        csgeAdd: json["csgeAdd"],
        fromCity: json["fromCity"],
        toPincode: json["toPincode"],
        pkgCode: json["pkgCode"],
        docketInvoiceList: List<DocketInvoice>.from(
            json["docketInvoiceList"].map((x) => DocketInvoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dockdt": dockdt,
        "partY_CODE": partYCode,
        "party_name": partyName,
        "orgncd": orgncd,
        "paybas": paybas,
        "currFinYear": currFinYear,
        "baseCompanyCode": baseCompanyCode,
        "destcd": destcd,
        "dockno": dockno,
        "baseUserName": baseUserName,
        "transPortModel": transPortModel,
        "pincode": pincode,
        "toCity": toCity,
        "vol_yn": volYn,
        "csgncd": csgncd,
        "csgnm": csgnm,
        "csgnAdd": csgnAdd,
        "csgecd": csgecd,
        "csgenm": csgenm,
        "csgeAdd": csgeAdd,
        "fromCity": fromCity,
        "toPincode": toPincode,
        "pkgCode": pkgCode,
        "docketInvoiceList": List<dynamic>.from(docketInvoiceList.map((x) => x.toJson())),
      };
}

class DocketInvoice {
  final String invno;
  final String prodcd;
  final String pkgsty;
  final int pkgs;
  final int decval;
  final int actuwt;
  final int chrgwt;
  final String ewbno;
  final int volL;
  final int volB;
  final int volH;
  final int totCft;
  final String eWayBillExpiredDate;
  final String eWayBillInvoiceDate;
  final String image;

  DocketInvoice({
    required this.invno,
    required this.prodcd,
    required this.pkgsty,
    required this.pkgs,
    required this.decval,
    required this.actuwt,
    required this.chrgwt,
    required this.ewbno,
    required this.volL,
    required this.volB,
    required this.volH,
    required this.totCft,
    required this.eWayBillExpiredDate,
    required this.eWayBillInvoiceDate,
    required this.image,
  });

  factory DocketInvoice.fromJson(Map<String, dynamic> json) => DocketInvoice(
        invno: json["invno"],
        prodcd: json["prodcd"],
        pkgsty: json["pkgsty"],
        pkgs: json["pkgs"],
        decval: json["decval"],
        actuwt: json["actuwt"],
        chrgwt: json["chrgwt"],
        ewbno: json["ewbno"],
        volL: json["voL_L"],
        volB: json["voL_B"],
        volH: json["voL_H"],
        totCft: json["toT_CFT"],
        eWayBillExpiredDate: json["eWayBillExpiredDate"],
        eWayBillInvoiceDate: json["eWayBillInvoiceDate"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "invno": invno,
        "prodcd": prodcd,
        "pkgsty": pkgsty,
        "pkgs": pkgs,
        "decval": decval,
        "actuwt": actuwt,
        "chrgwt": chrgwt,
        "ewbno": ewbno,
        "voL_L": volL,
        "voL_B": volB,
        "voL_H": volH,
        "toT_CFT": totCft,
        "eWayBillExpiredDate": eWayBillExpiredDate,
        "eWayBillInvoiceDate": eWayBillInvoiceDate,
        "image": image,
      };
}
