import 'dart:convert';

GetPodListReq getPodListReqFromJson(String str) => GetPodListReq.fromJson(json.decode(str));

String getPodListReqToJson(GetPodListReq data) => json.encode(data.toJson());

class GetPodListReq {
  final String brcd;
  final String userName;
  final String companyCode;
  final String fromDate;
  final String toDate;
  final String gcNo;

  GetPodListReq({
    required this.brcd,
    required this.userName,
    required this.companyCode,
    required this.fromDate,
    required this.toDate,
    required this.gcNo,
  });

  factory GetPodListReq.fromJson(Map<String, dynamic> json) => GetPodListReq(
    brcd: json["brcd"],
    userName: json["userName"],
    companyCode: json["companyCode"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    gcNo: json["gcNo"],
  );

  Map<String, dynamic> toJson() => {
    "brcd": brcd,
    "userName": userName,
    "companyCode": companyCode,
    "fromDate": fromDate,
    "toDate": toDate,
    "gcNo": gcNo,
  };
}
