import 'dart:convert';

DrsUpdateDetailsResponse drsUpdateDetailsResponseFromJson(String str) =>
    DrsUpdateDetailsResponse.fromJson(json.decode(str));

String drsUpdateDetailsResponseToJson(DrsUpdateDetailsResponse data) =>
    json.encode(data.toJson());

class DrsUpdateDetailsResponse {
  final int statusCode;
  final int status;
  final DrsDetailData drsDetailData;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  DrsUpdateDetailsResponse({
    required this.statusCode,
    required this.status,
    required this.drsDetailData,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory DrsUpdateDetailsResponse.fromJson(Map<String, dynamic> json) =>
      DrsUpdateDetailsResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        drsDetailData: DrsDetailData.fromJson(json["data"]),
        errors: json["errors"] ?? '',
        metaData: json["metaData"] ?? '',
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": drsDetailData.toJson(),
        "errors": errors,
        "metaData": metaData,
        "message": message,
      };
}

class DrsDetailData {
  final String pdcno;
  final String pdCDt;
  final String deliveryBy;
  final String bAVendorCode;
  final String staff;
  final dynamic driverName;
  final String vehno;
  final int startKm;
  final int totalDocketsInDrs;
  final int closeKm;
  final String pdCUpdated;
  final String drsDate;
  final List<DrsDetailList> drsDetailList;

  DrsDetailData({
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
    required this.drsDate,
    required this.drsDetailList,
  });

  factory DrsDetailData.fromJson(Map<String, dynamic> json) => DrsDetailData(
        pdcno: json["pdcno"],
        pdCDt: json["pdC_Dt"],
        deliveryBy: json["deliveryBy"],
        bAVendorCode: json["bA_Vendor_Code"],
        staff: json["staff"],
        driverName: json["driverName"] ?? '',
        vehno: json["vehno"],
        startKm: json["start_KM"],
        totalDocketsInDrs: json["total_Dockets_In_DRS"],
        closeKm: json["closeKM"],
        pdCUpdated: json["pdC_Updated"],
        drsDate: json["drsDate"],
        drsDetailList: List<DrsDetailList>.from(
            json["drsDetail"].map((x) => DrsDetailList.fromJson(x))),
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
        "drsDate": drsDate,
        "drsDetail": List<dynamic>.from(drsDetailList.map((x) => x.toJson())),
      };
}

class DrsDetailList {
  final int autoNo;
  final double rate;
  final double maxLimit;
  final double newRate;
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
  final double bookedWt;
  final double wtArrived;
  final String commDelyDt;
  final dynamic freight;
  final dynamic docketTotal;
  final dynamic serviceTax;
  final double pkgQty;
  final double actQty;
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
  final dynamic pkgsdelivered;
  final dynamic remark;
  final dynamic otp;
  final String delydate;
  final String delytime;
  final dynamic delyperson;
  final dynamic cboReason;
  final int coddodcollected;
  final int coddodno;
  final dynamic cboLateReason;
  final dynamic hDcboReason;
  final bool isChecked;
  final dynamic ratetype;
  final bool isEnabled;
  final bool isEnabledBadPodoption;

  DrsDetailList({
    required this.autoNo,
    required this.rate,
    required this.maxLimit,
    required this.newRate,
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
    required this.pkgQty,
    required this.actQty,
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
    required this.ratetype,
    required this.isEnabled,
    required this.isEnabledBadPodoption,
  });

  factory DrsDetailList.fromJson(Map<String, dynamic> json) => DrsDetailList(
        autoNo: json["autoNo"] ?? 0,
        rate: json["rate"] ?? 0.0,
        maxLimit: json["maxLimit"] ?? 0.0,
        newRate: json["newRate"] ?? 0.0,
        dockno: json["dockno"] ?? "",
        docksf: json["docksf"] ?? "",
        bookingDate: json["booking_Date"] ?? "",
        orgncd: json["orgncd"] ?? "",
        destcd: json["destcd"] ?? "",
        payBasis: json["payBasis"] ?? "",
        csgncd: json["csgncd"] ?? "",
        csgnnm: json["csgnnm"] ?? "",
        csgecd: json["csgecd"] ?? "",
        csgenm: json["csgenm"] ?? "",
        pkgsArrived: json["pkgs_Arrived"] ?? 0,
        pkgsBooked: json["pkgs_Booked"] ?? 0,
        pkgsPending: json["pkgs_Pending"] ?? 0,
        bookedWt: json["booked_Wt"] ?? 0.0,
        wtArrived: json["wt_Arrived"] ?? 0.0,
        commDelyDt: json["comm_Dely_Dt"] ?? "",
        freight: json["freight"],
        docketTotal: json["docket_Total"],
        serviceTax: json["service_Tax"],
        pkgQty: json["pkgQty"],
        actQty: json["actQty"],
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
        ratetype: json["ratetype"],
        isEnabled: json["isEnabled"],
        isEnabledBadPodoption: json["isEnabledBadPodoption"],
      );

  Map<String, dynamic> toJson() => {
        "autoNo": autoNo,
        "rate": rate,
        "maxLimit": maxLimit,
        "newRate": newRate,
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
        "pkgQty": pkgQty,
        "actQty": actQty,
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
        "ratetype": ratetype,
        "isEnabled": isEnabled,
        "isEnabledBadPodoption": isEnabledBadPodoption,
      };
}
