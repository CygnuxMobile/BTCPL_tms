import 'dart:convert';

VendorListResponse vendorListResponseFromJson(String str) => VendorListResponse.fromJson(json.decode(str));

class VendorListResponse {
  int statusCode;
  int status;
  VendorListData data;
  dynamic errors;
  dynamic metaData;
  String message;

  VendorListResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory VendorListResponse.fromJson(Map<String, dynamic> json) => VendorListResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: VendorListData.fromJson(json["data"] ?? {}),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class VendorListData {
  List<VendorItem> venderscodes;

  VendorListData({
    required this.venderscodes,
  });

  factory VendorListData.fromJson(Map<String, dynamic> json) => VendorListData(
    venderscodes: json["venderscodes"] != null 
        ? List<VendorItem>.from(json["venderscodes"].map((x) => VendorItem.fromJson(x)))
        : [],
  );
}

class VendorItem {
  String vendor_Code;
  String vendor_Name;

  VendorItem({
    required this.vendor_Code,
    required this.vendor_Name,
  });

  factory VendorItem.fromJson(Map<String, dynamic> json) => VendorItem(
    vendor_Code: json["vendor_Code"] ?? "",
    vendor_Name: json["vendor_Name"] ?? "",
  );
}
