import 'dart:convert';

UnloadingRequest unloadingRequestFromJson(String str) =>
    UnloadingRequest.fromJson(json.decode(str));

String unloadingRequestToJson(UnloadingRequest data) =>
    json.encode(data.toJson());

class UnloadingRequest {
  final String lodingSheetNo;

  UnloadingRequest({
    required this.lodingSheetNo,
  });

  factory UnloadingRequest.fromJson(Map<String, dynamic> json) =>
      UnloadingRequest(
        lodingSheetNo: json["lodingSheetNo"],
      );

  Map<String, dynamic> toJson() => {
        "lodingSheetNo": lodingSheetNo,
      };
}
