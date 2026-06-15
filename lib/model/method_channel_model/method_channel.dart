import 'dart:convert';


List<SchedulerModel> schedulerModelListFromJson(String str) =>
    List<SchedulerModel>.from(
        json.decode(str)!.map((x) => SchedulerModel.fromJson(x)));

String schedulerModelListToJson(List<SchedulerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

SchedulerModel schedulerModelFromJson(String str) =>
    SchedulerModel.fromJson(json.decode(str));

String schedulerModelToJson(SchedulerModel? data) =>
    json.encode(data!.toJson());

class SchedulerModel {
  SchedulerModel({
    this.id,
    this.from,
    this.to,
    this.frequency,
    this.config,
    this.testType,
    this.version,
    this.label,
    this.templateName,
  });

  int? id;
  DateTime? from;
  DateTime? to;
  int? frequency;
  String? config;
  String? testType;
  String? version;
  String? label;
  String? templateName;

  SchedulerModel copyWith({
    int? id,
    DateTime? from,
    DateTime? to,
    int? frequency,
    String? config,
    String? testType,
    String? version,
    String? label,
    String? templateName,
  }) =>
      SchedulerModel(
        id: id ?? this.id,
        from: from ?? this.from,
        to: to ?? this.to,
        frequency: frequency ?? this.frequency,
        config: config ?? this.config,
        testType: testType ?? this.testType,
        version: version ?? this.version,
        label: label ?? this.label,
        templateName: templateName ?? this.templateName,
      );

  factory SchedulerModel.fromJson(Map<String, dynamic> json) => SchedulerModel(
    id: json["_id"],
    from: DateTime.fromMillisecondsSinceEpoch(int.parse(json["_from"]),
        isUtc: true),
    to: DateTime.fromMillisecondsSinceEpoch(int.parse(json["_to"]),
        isUtc: true),
    frequency: json["frequency"],
    config: json["config"],
    testType: json["testType"],
    version: json["version"],
    label: json["label"],
    templateName: json["template_name"],
  );

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "_from": from?.toUtc().millisecondsSinceEpoch,
      "_to": to?.toUtc().millisecondsSinceEpoch,
      "frequency": frequency,
      "config": config,
      "testType": testType,
      "version": version,
      "label": label,
      "template_name": templateName,
    };
  }

  Map<String, dynamic> toJsonWithoutID() => {
    "_from": from?.toUtc().millisecondsSinceEpoch,
    "_to": to?.toUtc().millisecondsSinceEpoch,
    "frequency": frequency,
    "config": config,
    "testType": testType,
    "version": version,
    "label": label,
    "template_name": templateName,
  };

  Map<String, dynamic> toJsonWithOutConfig() => {
    "_id": id,
    "_from": from?.toUtc().millisecondsSinceEpoch,
    "_to": to?.toUtc().millisecondsSinceEpoch,
    "frequency": frequency,
    "testType": testType,
    "version": version,
    "label": label,
    "template_name": templateName,
  };
}
