import 'dart:convert';

String prepareDRSRequestToJson(PrepareDRSRequest data) => json.encode(data.toJson());

class PrepareDRSRequest {
  String drsNo;
  String drscDate;
  String vendorcode;
  String vendorname;
  String vehicleNo;
  String vendor_type;
  String tripsheetno;
  String baseUserName;
  String baseLocationCode;
  String baseCompanyCode;
  String baseFinYear;
  String doc_Type;
  String ismktVeh;
  String deliveryAgent;
  String crossingAgent;
  String rcBookNo;
  double usedcapacity;
  String insuranceValDt;
  String vehprmdt;
  double capacity;
  String registrationDt;
  String engineNo;
  String ftltyPe;
  String vehicle_Type;
  String chasisNo;
  String fitnessValDt;
  double wtloaded;
  double startKM;
  int driver_Id;
  String driver_Name;
  String mobileno;
  String license_No;
  String issue_By_RTO;
  String valdity_date;
  List<DrsGenerateItem> drsGenerateList;

  PrepareDRSRequest({
    required this.drsNo,
    required this.drscDate,
    required this.vendorcode,
    required this.vendorname,
    required this.vehicleNo,
    required this.vendor_type,
    required this.tripsheetno,
    required this.baseUserName,
    required this.baseLocationCode,
    required this.baseCompanyCode,
    required this.baseFinYear,
    required this.doc_Type,
    required this.ismktVeh,
    required this.deliveryAgent,
    required this.crossingAgent,
    required this.rcBookNo,
    required this.usedcapacity,
    required this.insuranceValDt,
    required this.vehprmdt,
    required this.capacity,
    required this.registrationDt,
    required this.engineNo,
    required this.ftltyPe,
    required this.vehicle_Type,
    required this.chasisNo,
    required this.fitnessValDt,
    required this.wtloaded,
    required this.startKM,
    required this.driver_Id,
    required this.driver_Name,
    required this.mobileno,
    required this.license_No,
    required this.issue_By_RTO,
    required this.valdity_date,
    required this.drsGenerateList,
  });

  Map<String, dynamic> toJson() => {
    "drsNo": drsNo,
    "drscDate": drscDate,
    "vendorcode": vendorcode,
    "vendorname": vendorname,
    "vehicleNo": vehicleNo,
    "vendor_type": vendor_type,
    "tripsheetno": tripsheetno,
    "baseUserName": baseUserName,
    "baseLocationCode": baseLocationCode,
    "baseCompanyCode": baseCompanyCode,
    "baseFinYear": baseFinYear,
    "doc_Type": doc_Type,
    "ismktVeh": ismktVeh,
    "deliveryAgent": deliveryAgent,
    "crossingAgent": crossingAgent,
    "rcBookNo": rcBookNo,
    "usedcapacity": usedcapacity,
    "insuranceValDt": insuranceValDt,
    "vehprmdt": vehprmdt,
    "capacity": capacity,
    "registrationDt": registrationDt,
    "engineNo": engineNo,
    "ftltyPe": ftltyPe,
    "vehicle_Type": vehicle_Type,
    "chasisNo": chasisNo,
    "fitnessValDt": fitnessValDt,
    "wtloaded": wtloaded,
    "startKM": startKM,
    "driver_Id": driver_Id,
    "driver_Name": driver_Name,
    "mobileno": mobileno,
    "license_No": license_No,
    "issue_By_RTO": issue_By_RTO,
    "valdity_date": valdity_date,
    "drsGenerateList": List<dynamic>.from(drsGenerateList.map((x) => x.toJson())),
  };
}

class DrsGenerateItem {
  String dockno;
  String docksf;
  String orgncd;
  int pkgsno;
  int arrPkgQty;
  int pendPkgQty;
  String payBas;
  double actuwt;
  double arrWeightQty;
  double chrgwt;
  String trN_MOD;
  int dkttot;
  String desT_CD;
  String pdcdt;
  String bkg_Date;
  double rate;
  int ratetype;

  DrsGenerateItem({
    required this.dockno,
    required this.docksf,
    required this.orgncd,
    required this.pkgsno,
    required this.arrPkgQty,
    required this.pendPkgQty,
    required this.payBas,
    required this.actuwt,
    required this.arrWeightQty,
    required this.chrgwt,
    required this.trN_MOD,
    required this.dkttot,
    required this.desT_CD,
    required this.pdcdt,
    required this.bkg_Date,
    required this.rate,
    required this.ratetype,
  });

  Map<String, dynamic> toJson() => {
    "dockno": dockno,
    "docksf": docksf,
    "orgncd": orgncd,
    "pkgsno": pkgsno,
    "arrPkgQty": arrPkgQty,
    "pendPkgQty": pendPkgQty,
    "payBas": payBas,
    "actuwt": actuwt,
    "arrWeightQty": arrWeightQty,
    "chrgwt": chrgwt,
    "trN_MOD": trN_MOD,
    "dkttot": dkttot,
    "desT_CD": desT_CD,
    "pdcdt": pdcdt,
    "bkg_Date": bkg_Date,
    "rate": rate,
    "ratetype": ratetype,
  };
}
