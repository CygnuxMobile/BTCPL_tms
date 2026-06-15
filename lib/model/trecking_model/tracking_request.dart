import 'dart:convert';

TreckingRequest treckingRequestFromJson(String str) => TreckingRequest.fromJson(json.decode(str));

String treckingRequestToJson(TreckingRequest data) => json.encode(data.toJson());

class TreckingRequest {
  final String docketNo;

  TreckingRequest({
    required this.docketNo,
  });

  factory TreckingRequest.fromJson(Map<String, dynamic> json) => TreckingRequest(
    docketNo: json["docketNo"],
  );

  Map<String, dynamic> toJson() => {
    "docketNo": docketNo,
  };
}
