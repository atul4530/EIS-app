import 'dart:convert';

class PpToJcpModel {
  List<Result>? result;
  bool? status;
  String? message;

  PpToJcpModel({
    this.result,
    this.status,
    this.message,
  });

  factory PpToJcpModel.fromRawJson(String str) => PpToJcpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PpToJcpModel.fromJson(Map<String, dynamic> json) => PpToJcpModel(
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
  int? vfId;
  int? invId;
  String? invNo;
  String? invDt;
  String? curCode;
  String? lotCode;
  String? locationName;
  double? ppRate;
  int? jcpRate;
  int? ppJcpPct;
  double? margin;

  Result({
    this.vfId,
    this.invId,
    this.invNo,
    this.invDt,
    this.curCode,
    this.lotCode,
    this.locationName,
    this.ppRate,
    this.jcpRate,
    this.ppJcpPct,
    this.margin,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vfId: json["VF_ID"],
    invId: json["INV_ID"],
    invNo: json["INV_NO"],
    invDt: json["INV_DT"],
    curCode: json["CUR_CODE"],
    lotCode: json["LOT_CODE"],
    locationName: json["LOCATION_NAME"],
    ppRate: json["PP_RATE"]?.toDouble(),
    jcpRate: json["JCP_RATE"],
    ppJcpPct: json["PP_JCP_PCT"],
    margin: json["MARGIN"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "VF_ID": vfId,
    "INV_ID": invId,
    "INV_NO": invNo,
    "INV_DT": invDt,
    "CUR_CODE": curCode,
    "LOT_CODE": lotCode,
    "LOCATION_NAME": locationName,
    "PP_RATE": ppRate,
    "JCP_RATE": jcpRate,
    "PP_JCP_PCT": ppJcpPct,
    "MARGIN": margin,
  };
}
