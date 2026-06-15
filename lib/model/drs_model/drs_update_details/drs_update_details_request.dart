// To parse this JSON data, do
//
//     final drsUpdateDetailsRequest = drsUpdateDetailsRequestFromJson(jsonString);

import 'dart:convert';

DrsUpdateDetailsRequest drsUpdateDetailsRequestFromJson(String str) =>
    DrsUpdateDetailsRequest.fromJson(json.decode(str));

String drsUpdateDetailsRequestToJson(DrsUpdateDetailsRequest data) =>
    json.encode(data.toJson());

class DrsUpdateDetailsRequest {
  final String drsId;
  final String baseLocationCode;

  DrsUpdateDetailsRequest({
    required this.drsId,
    required this.baseLocationCode,
  });

  factory DrsUpdateDetailsRequest.fromJson(Map<String, dynamic> json) =>
      DrsUpdateDetailsRequest(
        drsId: json["drsId"],
        baseLocationCode: json["baseLocationCode"],
      );

  Map<String, dynamic> toJson() => {
        "drsId": drsId,
        "baseLocationCode": baseLocationCode,
      };
}
