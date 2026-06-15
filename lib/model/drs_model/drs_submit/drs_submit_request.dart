import 'dart:convert';

DrsSubmitRequest drsSubmitRequestFromJson(String str) =>
    DrsSubmitRequest.fromJson(json.decode(str));

String drsSubmitRequestToJson(DrsSubmitRequest data) =>
    json.encode(data.toJson());

class DrsSubmitRequest {
  final DrsSummary drsSummary;
  final List<UpdateDrsLit> updateDrsLits;
  final int loadingCharge;
  final String baseUserName;

  DrsSubmitRequest({
    required this.drsSummary,
    required this.updateDrsLits,
    required this.loadingCharge,
    required this.baseUserName,
  });

  factory DrsSubmitRequest.fromJson(Map<String, dynamic> json) =>
      DrsSubmitRequest(
        drsSummary: DrsSummary.fromJson(json["drsSummary"]),
        updateDrsLits: List<UpdateDrsLit>.from(
            json["updateDRSLits"].map((x) => UpdateDrsLit.fromJson(x))),
        loadingCharge: json["loadingCharge"],
        baseUserName: json["baseUserName"],
      );

  Map<String, dynamic> toJson() => {
        "drsSummary": drsSummary.toJson(),
        "updateDRSLits":
            List<dynamic>.from(updateDrsLits.map((x) => x.toJson())),
        "loadingCharge": loadingCharge,
        "baseUserName": baseUserName,
      };
}

class DrsSummary {
  final String pdcno;
  final String pdCDt;
  final String deliveryBy;
  final String bAVendorCode;
  final String staff;
  final String driverName;
  final String vehno;
  final int startKm;
  final int totalDocketsInDrs;
  final int closeKm;
  final String pdCUpdated;
  final String fromDate;
  final String toDate;
  final String drsNoList;
  final String dockno;
  final String dockdt;
  final String drs;
  final String drSDt;
  final int autoNo;
  final String loadingBy;
  final String rateType;
  final int loadingCharge;
  final int rate;
  final int maxLimit;
  final String vendorCode;
  final String vendorName;
  final bool isMonthly;
  final int hdnRate;
  final bool isMathadi;
  final String mathadiSlipNo;
  final String mathadiDate;
  final int mathadiAmt;
  final int pkgsno;
  final int actuwt;
  final String drsDate;

  DrsSummary({
    required this.pdcno,
    required this.pdCDt,
    required this.deliveryBy,
    required this.bAVendorCode,
    required this.staff,
    required this.driverName,
    required this.vehno,
    required this.startKm,
    required this.totalDocketsInDrs,
    required this.closeKm,
    required this.pdCUpdated,
    required this.fromDate,
    required this.toDate,
    required this.drsNoList,
    required this.dockno,
    required this.dockdt,
    required this.drs,
    required this.drSDt,
    required this.autoNo,
    required this.loadingBy,
    required this.rateType,
    required this.loadingCharge,
    required this.rate,
    required this.maxLimit,
    required this.vendorCode,
    required this.vendorName,
    required this.isMonthly,
    required this.hdnRate,
    required this.isMathadi,
    required this.mathadiSlipNo,
    required this.mathadiDate,
    required this.mathadiAmt,
    required this.pkgsno,
    required this.actuwt,
    required this.drsDate,
  });

  factory DrsSummary.fromJson(Map<String, dynamic> json) => DrsSummary(
        pdcno: json["pdcno"],
        pdCDt: json["pdC_Dt"],
        deliveryBy: json["deliveryBy"],
        bAVendorCode: json["bA_Vendor_Code"],
        staff: json["staff"],
        driverName: json["driverName"],
        vehno: json["vehno"],
        startKm: json["start_KM"],
        totalDocketsInDrs: json["total_Dockets_In_DRS"],
        closeKm: json["closeKM"],
        pdCUpdated: json["pdC_Updated"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
        drsNoList: json["drsNoList"],
        dockno: json["dockno"],
        dockdt: json["dockdt"],
        drs: json["drs"],
        drSDt: json["drS_DT"],
        autoNo: json["autoNo"],
        loadingBy: json["loadingBy"],
        rateType: json["rateType"],
        loadingCharge: json["loadingCharge"],
        rate: json["rate"],
        maxLimit: json["maxLimit"],
        vendorCode: json["vendorCode"],
        vendorName: json["vendorName"],
        isMonthly: json["isMonthly"],
        hdnRate: json["hdnRate"],
        isMathadi: json["isMathadi"],
        mathadiSlipNo: json["mathadiSlipNo"],
        mathadiDate: json["mathadiDate"],
        mathadiAmt: json["mathadiAmt"],
        pkgsno: json["pkgsno"],
        actuwt: json["actuwt"],
        drsDate: json["drsDate"],
      );

  Map<String, dynamic> toJson() => {
        "pdcno": pdcno,
        "pdC_Dt": pdCDt,
        "deliveryBy": deliveryBy,
        "bA_Vendor_Code": bAVendorCode,
        "staff": staff,
        "driverName": driverName,
        "vehno": vehno,
        "start_KM": startKm,
        "total_Dockets_In_DRS": totalDocketsInDrs,
        "closeKM": closeKm,
        "pdC_Updated": pdCUpdated,
        "fromDate": fromDate,
        "toDate": toDate,
        "drsNoList": drsNoList,
        "dockno": dockno,
        "dockdt": dockdt,
        "drs": drs,
        "drS_DT": drSDt,
        "autoNo": autoNo,
        "loadingBy": loadingBy,
        "rateType": rateType,
        "loadingCharge": loadingCharge,
        "rate": rate,
        "maxLimit": maxLimit,
        "vendorCode": vendorCode,
        "vendorName": vendorName,
        "isMonthly": isMonthly,
        "hdnRate": hdnRate,
        "isMathadi": isMathadi,
        "mathadiSlipNo": mathadiSlipNo,
        "mathadiDate": mathadiDate,
        "mathadiAmt": mathadiAmt,
        "pkgsno": pkgsno,
        "actuwt": actuwt,
        "drsDate": drsDate,
      };
}

class UpdateDrsLit {
  final int autoNo;
  final String dockno;
  final String docksf;
  final String bookingDate;
  final String orgncd;
  final String destcd;
  final String payBasis;
  final String csgncd;
  final String csgnnm;
  final String csgecd;
  final String csgenm;
  final int pkgsArrived;
  final int pkgsBooked;
  final int pkgsPending;
  final int bookedWt;
  final double wtArrived;
  final String commDelyDt;
  final int freight;
  final int docketTotal;
  final int serviceTax;
  final String delyLocation;
  final String currLoc;
  final String payBasCode;
  final String dockDt;
  final String coDDod;
  final int coddodAmount;
  final String cdeldTDdmmyyyy;
  final String dockDtDdmmyyyy;
  final String dlypdcno;
  final bool coddod;
  final int pkgsdelivered;
  final String remark;
  final String otp;
  final String delydate;
  final String delytime;
  final String delyperson;
  final String cboReason;
  final String frontPOD;
  final String backPOD;
  final int coddodcollected;
  final int coddodno;
  final String cboLateReason;
  final String hDcboReason;
  final bool isChecked;
  final int pkgQty;
  final int actQty;
  final int rate;
  final int maxLimit;
  final int newRate;
  final String ratetype;
  final bool isEnabled;
  final bool isEnabledBadPodoption;

  UpdateDrsLit({
    required this.autoNo,
    required this.dockno,
    required this.docksf,
    required this.bookingDate,
    required this.orgncd,
    required this.destcd,
    required this.payBasis,
    required this.csgncd,
    required this.csgnnm,
    required this.csgecd,
    required this.csgenm,
    required this.pkgsArrived,
    required this.pkgsBooked,
    required this.pkgsPending,
    required this.bookedWt,
    required this.wtArrived,
    required this.commDelyDt,
    required this.freight,
    required this.docketTotal,
    required this.serviceTax,
    required this.delyLocation,
    required this.currLoc,
    required this.payBasCode,
    required this.dockDt,
    required this.coDDod,
    required this.coddodAmount,
    required this.cdeldTDdmmyyyy,
    required this.dockDtDdmmyyyy,
    required this.dlypdcno,
    required this.coddod,
    required this.pkgsdelivered,
    required this.remark,
    required this.otp,
    required this.delydate,
    required this.delytime,
    required this.delyperson,
    required this.cboReason,
    required this.coddodcollected,
    required this.coddodno,
    required this.cboLateReason,
    required this.hDcboReason,
    required this.isChecked,
    required this.pkgQty,
    required this.actQty,
    required this.rate,
    required this.maxLimit,
    required this.newRate,
    required this.ratetype,
    required this.isEnabled,
    required this.frontPOD,
    required this.backPOD,
    required this.isEnabledBadPodoption,
  });

  factory UpdateDrsLit.fromJson(Map<String, dynamic> json) => UpdateDrsLit(
        autoNo: json["autoNo"],
        dockno: json["dockno"],
        docksf: json["docksf"],
        bookingDate: json["booking_Date"],
        orgncd: json["orgncd"],
        destcd: json["destcd"],
        payBasis: json["payBasis"],
        csgncd: json["csgncd"],
        csgnnm: json["csgnnm"],
        csgecd: json["csgecd"],
        csgenm: json["csgenm"],
        pkgsArrived: json["pkgs_Arrived"],
        pkgsBooked: json["pkgs_Booked"],
        pkgsPending: json["pkgs_Pending"],
        bookedWt: json["booked_Wt"],
        wtArrived: json["wt_Arrived"],
        commDelyDt: json["comm_Dely_Dt"],
        freight: json["freight"],
        docketTotal: json["docket_Total"],
        serviceTax: json["service_Tax"],
        delyLocation: json["delyLocation"],
        currLoc: json["curr_loc"],
        payBasCode: json["payBasCode"],
        dockDt: json["dockDt"],
        coDDod: json["coD_DOD"],
        coddodAmount: json["coddodAmount"],
        cdeldTDdmmyyyy: json["cdeldT_ddmmyyyy"],
        dockDtDdmmyyyy: json["dockDt_ddmmyyyy"],
        dlypdcno: json["dlypdcno"],
        coddod: json["coddod"],
        pkgsdelivered: json["pkgsdelivered"],
        remark: json["remark"],
        otp: json["otp"],
        delydate: json["delydate"],
        delytime: json["delytime"],
        delyperson: json["delyperson"],
        cboReason: json["cboReason"],
        coddodcollected: json["coddodcollected"],
        coddodno: json["coddodno"],
        cboLateReason: json["cboLateReason"],
        hDcboReason: json["hDcboReason"],
        isChecked: json["isChecked"],
        pkgQty: json["pkgQty"],
        actQty: json["actQty"],
        rate: json["rate"],
        maxLimit: json["maxLimit"],
        newRate: json["newRate"],
        ratetype: json["ratetype"],
        isEnabled: json["isEnabled"],
        frontPOD: json['frontPOD'],
        backPOD: json['backPOD'],
        isEnabledBadPodoption: json["isEnabledBadPodoption"],
      );

  Map<String, dynamic> toJson() => {
        "autoNo": autoNo,
        "dockno": dockno,
        "docksf": docksf,
        "booking_Date": bookingDate,
        "orgncd": orgncd,
        "destcd": destcd,
        "payBasis": payBasis,
        "csgncd": csgncd,
        "csgnnm": csgnnm,
        "csgecd": csgecd,
        "csgenm": csgenm,
        "pkgs_Arrived": pkgsArrived,
        "pkgs_Booked": pkgsBooked,
        "pkgs_Pending": pkgsPending,
        "booked_Wt": bookedWt,
        "wt_Arrived": wtArrived,
        "comm_Dely_Dt": commDelyDt,
        "freight": freight,
        "docket_Total": docketTotal,
        "service_Tax": serviceTax,
        "delyLocation": delyLocation,
        "curr_loc": currLoc,
        "payBasCode": payBasCode,
        "dockDt": dockDt,
        "coD_DOD": coDDod,
        "coddodAmount": coddodAmount,
        "cdeldT_ddmmyyyy": cdeldTDdmmyyyy,
        "dockDt_ddmmyyyy": dockDtDdmmyyyy,
        "dlypdcno": dlypdcno,
        "coddod": coddod,
        "pkgsdelivered": pkgsdelivered,
        "remark": remark,
        "otp": otp,
        "delydate": delydate,
        "delytime": delytime,
        "delyperson": delyperson,
        "cboReason": cboReason,
        "coddodcollected": coddodcollected,
        "coddodno": coddodno,
        "cboLateReason": cboLateReason,
        "hDcboReason": hDcboReason,
        "isChecked": isChecked,
        "pkgQty": pkgQty,
        "actQty": actQty,
        "rate": rate,
        "maxLimit": maxLimit,
        "newRate": newRate,
        "ratetype": ratetype,
        "frontPOD": frontPOD,
        "backPOD": backPOD,
        "isEnabled": isEnabled,
        "isEnabledBadPodoption": isEnabledBadPodoption,
      };
}
