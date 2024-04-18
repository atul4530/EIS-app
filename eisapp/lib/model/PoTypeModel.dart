import 'dart:convert';

class PoTypeModel {
  List<Result>? result;
  bool? status;
  String? message;

  PoTypeModel({
    this.result,
    this.status,
    this.message,
  });

  factory PoTypeModel.fromRawJson(String str) => PoTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PoTypeModel.fromJson(Map<String, dynamic> json) => PoTypeModel(
    result: json["RESULT"] == null ? [] : List<Result>.from(json["RESULT"]!.map((x) => Result.fromJson(x))),
    status: json["STATUS"],
    message: json["MESSAGE"],
  );

  Map<String, dynamic> toJson() => {
    "RESULT": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "STATUS": status,
    "MESSAGE": message,
  };
}

class Result {
  String? poNo;
  String? partyGroupName;
  String? poType;
  String? stockType;
  String? locationName;
  String? metalKt;
  int? qty;

  Result({
    this.poNo,
    this.partyGroupName,
    this.poType,
    this.stockType,
    this.locationName,
    this.metalKt,
    this.qty,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    poNo: json["PO_NO"],
    partyGroupName: json["PARTY_GROUP_NAME"],
    poType: json["PO_TYPE"],
    stockType: json["STOCK_TYPE"],
    locationName: json["LOCATION_NAME"],
    metalKt: json["METAL_KT"],
    qty: json["QTY"],
  );

  Map<String, dynamic> toJson() => {
    "PO_NO": poNo,
    "PARTY_GROUP_NAME": partyGroupName,
    "PO_TYPE": poType,
    "STOCK_TYPE": stockType,
    "LOCATION_NAME": locationName,
    "METAL_KT": metalKt,
    "QTY": qty,
  };
}
