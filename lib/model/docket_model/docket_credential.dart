import 'dart:convert';

DocketNo docketNoFromJson(String str) => DocketNo.fromJson(json.decode(str));

String docketNoToJson(DocketNo data) => json.encode(data.toJson());

class DocketNo {
  DocketNo({
    required this.dockno,
  });

  final String dockno;

  factory DocketNo.fromJson(Map<String, dynamic> json) => DocketNo(
    dockno: json["dockno"],
  );

  Map<String, dynamic> toJson() => {
    "dockno": dockno,
  };
}
