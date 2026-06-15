import 'dart:convert';

PrepareManifest prepareManifestFromJson(String str) => PrepareManifest.fromJson(json.decode(str));

String prepareManifestToJson(PrepareManifest data) => json.encode(data.toJson());

class PrepareManifest {
  PrepareManifest({
    required this.nextloc,
    required this.baseUserName,
    required this.mFTransportMode,
    required this.vehno,
    required this.vehicleType,
    required this.lsDate,
    required this.baseLocationCode,
    required this.baseFinYear,
    required this.baseCompanyCode,
    required this.docketManifests,
    required this.serials,
  });

  final String nextloc;
  final String baseUserName;
  final String mFTransportMode;
  final String vehno;
  final String vehicleType;
  final String lsDate;
  final String baseLocationCode;
  final String baseFinYear;
  final String baseCompanyCode;
  final List<DocketManifest> docketManifests;
  final List<Serial> serials;

  factory PrepareManifest.fromJson(Map<String, dynamic> json) => PrepareManifest(
    nextloc: json["nextloc"],
    baseUserName: json["baseUserName"],
    mFTransportMode: json["mF_TransportMode"],
    vehno: json["vehno"],
    vehicleType: json["vehicleType"],
    lsDate: json["lsDate"],
    baseLocationCode: json["baseLocationCode"],
    baseFinYear: json["baseFinYear"],
    baseCompanyCode: json["baseCompanyCode"],
    docketManifests: List<DocketManifest>.from(json["docketManifests"].map((x) => DocketManifest.fromJson(x))),
    serials: List<Serial>.from(json["serials"].map((x) => Serial.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nextloc": nextloc,
    "baseUserName": baseUserName,
    "mF_TransportMode": mFTransportMode,
    "vehno": vehno,
    "vehicleType": vehicleType,
    "lsDate": lsDate,
    "baseLocationCode": baseLocationCode,
    "baseFinYear": baseFinYear,
    "baseCompanyCode": baseCompanyCode,
    "docketManifests": List<dynamic>.from(docketManifests.map((x) => x.toJson())),
    "serials": List<dynamic>.from(serials.map((x) => x.toJson())),
  };
}

class DocketManifest {
  DocketManifest({
    required this.dockno,
    required this.docksf,
    required this.packagesLb,
    required this.weightLb,
    required this.orgCode,
    required this.reDestCode,
    required this.docketDate,
    required this.pkgsno,
    required this.actuwt,
    required this.newRate,
    required this.ratetype,
  });

  final String dockno;
  final String docksf;
  final int packagesLb;
  final int weightLb;
  final String orgCode;
  final String reDestCode;
  final String docketDate;
  final int pkgsno;
  final int actuwt;
  final int newRate;
  final String ratetype;

  factory DocketManifest.fromJson(Map<String, dynamic> json) => DocketManifest(
    dockno: json["dockno"],
    docksf: json["docksf"],
    packagesLb: json["packagesLB"],
    weightLb: json["weightLB"],
    orgCode: json["orgCode"],
    reDestCode: json["reDestCode"],
    docketDate: json["docketDate"],
    pkgsno: json["pkgsno"],
    actuwt: json["actuwt"],
    newRate: json["newRate"],
    ratetype: json["ratetype"],
  );

  Map<String, dynamic> toJson() => {
    "dockno": dockno,
    "docksf": docksf,
    "packagesLB": packagesLb,
    "weightLB": weightLb,
    "orgCode": orgCode,
    "reDestCode": reDestCode,
    "docketDate": docketDate,
    "pkgsno": pkgsno,
    "actuwt": actuwt,
    "newRate": newRate,
    "ratetype": ratetype,
  };
}

class Serial {
  Serial({
    required this.bcserialNo,
    required this.docksf,
  });

  final String bcserialNo;
  final String docksf;

  factory Serial.fromJson(Map<String, dynamic> json) => Serial(
    bcserialNo: json["bcserialNo"],
    docksf: json["docksf"],
  );

  Map<String, dynamic> toJson() => {
    "bcserialNo": bcserialNo,
    "docksf": docksf,
  };
}
