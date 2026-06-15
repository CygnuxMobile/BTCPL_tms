import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../moduls/pod_page/pod_controller.dart';

PodListResponse podListResponseFromJson(String str) => PodListResponse.fromJson(json.decode(str));

String podListResponseToJson(PodListResponse data) => json.encode(data.toJson());

class PodListResponse {
  final int statusCode;
  final int status;
  final Data data;
  final dynamic errors;
  final dynamic metaData;
  final String message;

  PodListResponse({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
    required this.metaData,
    required this.message,
  });

  factory PodListResponse.fromJson(Map<String, dynamic> json) => PodListResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
        errors: json["errors"],
        metaData: json["metaData"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "data": data.toJson(),
        "errors": errors,
        "metaData": metaData,
        "message": message,
      };
}

class Data {
  final List<Pod> pod;

  Data({required this.pod});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(pod: List<Pod>.from(json["pod"].map((x) => Pod.fromJson(x))));

  Map<String, dynamic> toJson() => {"pod": List<dynamic>.from(pod.map((x) => x.toJson()))};
}

class Pod {
  final String dockno;
  final String dockdt;
  final String tripSheetNo;
  final RxList<String> podImage;
  final List<String> podImagePaths;
  final RxString status;
  final RxString buttonName;
  final Rx<ApiStatus> apiStatus;

  Pod({
    required this.dockno,
    required this.dockdt,
    required this.tripSheetNo,
    required this.podImagePaths,
    required this.podImage,
    required this.status,
    required this.buttonName,
    required this.apiStatus,
  });

  factory Pod.fromJson(Map<String, dynamic> json) => Pod(
        dockno: json["dockno"],
        dockdt: json["dockdt"],
        tripSheetNo: json["tripSheetNo"] ?? '',
        podImagePaths: json['podImagePaths'] ?? <String>[],
        podImage: RxList(json["podImage"] ?? <String>[]),
        status: RxString(json["status"] ?? 'No images uploaded'),
        buttonName: RxString(json['buttonName'] ?? "Upload Pod"),
        apiStatus: Rx(json["ApiStatus"] ?? ApiStatus.none),
      );

  Map<String, dynamic> toJson() => {"dockno": dockno, "dockdt": dockdt};
}
