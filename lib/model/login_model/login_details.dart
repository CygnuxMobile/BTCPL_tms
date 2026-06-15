import 'dart:convert';

LoginDetails loginDetailsFromJson(String str) => LoginDetails.fromJson(json.decode(str));

String loginDetailsToJson(LoginDetails data) => json.encode(data.toJson());

class LoginDetails {
  final int statusCode;
  final int status;
  final UserData data;
  final Errors errors;
  final String metaData;
  final String message;

  LoginDetails({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory LoginDetails.fromJson(Map<String, dynamic> json) => LoginDetails(
    statusCode: json["statusCode"]??0,
    status: json["status"]??0,
    data: UserData.fromJson(json["data"]),
    errors: Errors.fromJson(json["errors"]),
    metaData: json["metaData"]??"",
    message: json["message"]??"",
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "UserData": data.toJson(),
    "errors": errors.toJson(),
    "metaData": metaData,
    "message": message,
  };
}

class Errors {
  final int status;
  final String message;
  final String errors;
  final String timeStamp;

  Errors({
    required this.status,
    required this.message,
    required this.errors,
    required this.timeStamp,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    status: json["status"]??0,
    message: json["message"]??"",
    errors: json["errors"]??"",
    timeStamp: json["timeStamp"]??"",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "errors": errors,
    "timeStamp": timeStamp,
  };
}

class UserData {
  final String token;
  final String tokenExpireTime;
  final String userId;
  final String name;
  final String emailId;
  final String userImage;
  final String baseCompanyCode;
  final String branchCode;
  final String emptype;
  final String finYear;
  final String city;
  final List<MultiLocation> multiLocation;

  UserData({
    required this.token,
    required this.tokenExpireTime,
    required this.userId,
    required this.name,
    required this.emailId,
    required this.userImage,
    required this.baseCompanyCode,
    required this.branchCode,
    required this.emptype,
    required this.finYear,
    required this.city,
    required this.multiLocation,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    token: json["token"]??"",
    tokenExpireTime: json["tokenExpireTime"]??"",
    userId: json["userId"]??"",
    name: json["name"]??"",
    emailId: json["emailId"]??"",
    userImage: json["userImage"]??"",
    baseCompanyCode: json["baseCompanyCode"]??"",
    branchCode: json["branchCode"]??"",
    emptype: json["emptype"]??"",
    finYear: json["finYear"]??"",
    city: json["city"]??"",
    multiLocation:json["multiLocation"] == null ?[]: List<MultiLocation>.from(json["multiLocation"].map((x) => MultiLocation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "tokenExpireTime": tokenExpireTime,
    "userId": userId,
    "name": name,
    "emailId": emailId,
    "userImage": userImage,
    "baseCompanyCode": baseCompanyCode,
    "branchCode": branchCode,
    "emptype": emptype,
    "finYear": finYear,
    "city": city,
    "multiLocation": List<dynamic>.from(multiLocation.map((x) => x.toJson())),
  };
}

class MultiLocation {
  final String locCode;
  final String locName;

  MultiLocation({
    required this.locCode,
    required this.locName,
  });

  factory MultiLocation.fromJson(Map<String, dynamic> json) => MultiLocation(
    locCode: json["locCode"]??"",
    locName: json["locName"]??"",
  );

  Map<String, dynamic> toJson() => {
    "locCode": locCode,
    "locName": locName,
  };
}
