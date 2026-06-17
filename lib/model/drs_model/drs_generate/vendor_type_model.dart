import 'dart:convert';

VendorTypeResponse vendorTypeResponseFromJson(String str) => VendorTypeResponse.fromJson(json.decode(str));

class VendorTypeResponse {
  int statusCode;
  int status;
  VendorTypeData data;
  dynamic errors;
  dynamic metaData;
  String message;

  VendorTypeResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory VendorTypeResponse.fromJson(Map<String, dynamic> json) => VendorTypeResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: VendorTypeData.fromJson(json["data"] ?? {}),
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class VendorTypeData {
  String vendorType_Code;
  String vendorType;
  List<VendorTypeItem> venders;

  VendorTypeData({
    required this.vendorType_Code,
    required this.vendorType,
    required this.venders,
  });

  factory VendorTypeData.fromJson(Map<String, dynamic> json) => VendorTypeData(
    vendorType_Code: json["vendor_Type_Code"] ?? "",
    vendorType: json["vendor_Type"] ?? "",
    venders: json["venders"] != null 
        ? List<VendorTypeItem>.from(json["venders"].map((x) => VendorTypeItem.fromJson(x)))
        : [],
  );
}

class VendorTypeItem {
  String vendorType_Code;
  String vendorType;

  VendorTypeItem({
    required this.vendorType_Code,
    required this.vendorType,
  });

  factory VendorTypeItem.fromJson(Map<String, dynamic> json) => VendorTypeItem(
    vendorType_Code: json["vendor_Type_Code"] ?? "",
    vendorType: json["vendor_Type"] ?? "",
  );
}
