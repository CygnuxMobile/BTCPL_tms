import 'dart:convert';

CheckValidSerialNoSend checkValidSerialNoSendFromJson(String str) => CheckValidSerialNoSend.fromJson(json.decode(str));

String checkValidSerialNoSendToJson(CheckValidSerialNoSend data) => json.encode(data.toJson());

class CheckValidSerialNoSend {
  CheckValidSerialNoSend({
    required this.bcserialNo,
    required this.brcd,
    required this.nextLocation,
  });

  final String bcserialNo;
  final String brcd;
  final String nextLocation;

  factory CheckValidSerialNoSend.fromJson(Map<String, dynamic> json) => CheckValidSerialNoSend(
    bcserialNo: json["bcserialNo"],
    brcd: json["brcd"],
    nextLocation: json["nextLocation"],
  );

  Map<String, dynamic> toJson() => {
    "bcserialNo": bcserialNo,
    "brcd": brcd,
    "nextLocation": nextLocation,
  };
}
