import 'dart:convert';

DeliveryAgentResponse deliveryAgentResponseFromJson(String str) => DeliveryAgentResponse.fromJson(json.decode(str));

class DeliveryAgentResponse {
  int statusCode;
  int status;
  List<DeliveryAgentItem> data;
  dynamic errors;
  dynamic metaData;
  String message;

  DeliveryAgentResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    this.errors,
    this.metaData,
    required this.message,
  });

  factory DeliveryAgentResponse.fromJson(Map<String, dynamic> json) => DeliveryAgentResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? 0,
    data: json["data"] != null 
        ? List<DeliveryAgentItem>.from(json["data"].map((x) => DeliveryAgentItem.fromJson(x)))
        : [],
    errors: json["errors"],
    metaData: json["metaData"],
    message: json["message"] ?? "",
  );
}

class DeliveryAgentItem {
  String userId;
  String name;

  DeliveryAgentItem({
    required this.userId,
    required this.name,
  });

  factory DeliveryAgentItem.fromJson(Map<String, dynamic> json) => DeliveryAgentItem(
    userId: json["userId"] ?? "",
    name: json["name"] ?? "",
  );
}
