import 'dart:convert';

class GetFinishedProductMetalDetModel {
  List<GetFinishedProductMetalDet>? getFinishedProductMetalDet;
  bool? result;

  GetFinishedProductMetalDetModel({
    this.getFinishedProductMetalDet,
    this.result,
  });

  factory GetFinishedProductMetalDetModel.fromRawJson(String str) => GetFinishedProductMetalDetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetFinishedProductMetalDetModel.fromJson(Map<String, dynamic> json) => GetFinishedProductMetalDetModel(
    getFinishedProductMetalDet: json["getFinishedProductMetalDet"] == null ? [] : List<GetFinishedProductMetalDet>.from(json["getFinishedProductMetalDet"]!.map((x) => GetFinishedProductMetalDet.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "getFinishedProductMetalDet": getFinishedProductMetalDet == null ? [] : List<dynamic>.from(getFinishedProductMetalDet!.map((x) => x.toJson())),
    "result": result,
  };
}

class GetFinishedProductMetalDet {
  String? rawMaterial;
  String? commodity;
  String? weight;
  String? numberOfPieces;
  String? color;
  String? mmSize;

  GetFinishedProductMetalDet({
    this.rawMaterial,
    this.commodity,
    this.weight,
    this.numberOfPieces,
    this.color,
    this.mmSize,
  });

  factory GetFinishedProductMetalDet.fromRawJson(String str) => GetFinishedProductMetalDet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetFinishedProductMetalDet.fromJson(Map<String, dynamic> json) => GetFinishedProductMetalDet(
    rawMaterial: json["RAW MATERIAL"].toString(),
    commodity: json["COMMODITY"].toString(),
    weight: json["WEIGHT"]?.toDouble().toString(),
    numberOfPieces: json["NUMBER OF PIECES"].toString(),
    color: json["COLOR"].toString(),
    mmSize: json["MM Size"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "RAW MATERIAL": rawMaterial,
    "COMMODITY": commodity,
    "WEIGHT": weight,
    "NUMBER OF PIECES": numberOfPieces,
    "COLOR": color,
    "MM Size": mmSize,
  };
}
