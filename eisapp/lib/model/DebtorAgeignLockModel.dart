import 'dart:convert';

class DebtorAgeignLockModel {
  List<Result>? result;
  bool? status;
  String? message;

  DebtorAgeignLockModel({
    this.result,
    this.status,
    this.message,
  });

  factory DebtorAgeignLockModel.fromRawJson(String str) => DebtorAgeignLockModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DebtorAgeignLockModel.fromJson(Map<String, dynamic> json) => DebtorAgeignLockModel(
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
  String? partyName;
  String? notDue;
  String? days30;
  String? days60;
  String? days90;
  dynamic days120;
  String? above120;
  String? totalDue;

  Result({
    this.vfId,
    this.invId,
    this.invNo,
    this.invDt,
    this.curCode,
    this.partyName,
    this.notDue,
    this.days30,
    this.days60,
    this.days90,
    this.days120,
    this.above120,
    this.totalDue,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vfId: json["VF_ID"],
    invId: json["INV_ID"],
    invNo: json["INV_NO"],
    invDt: json["INV_DT"],
    curCode: json["CUR_CODE"],
    partyName: json["PARTY_NAME"],
    notDue: json["NOT_DUE"],
    days30: json["DAYS_30"],
    days60: json["DAYS_60"],
    days90: json["DAYS_90"],
    days120: json["DAYS_120"],
    above120: json["ABOVE_120"],
    totalDue: json["TOTAL_DUE"],
  );

  Map<String, dynamic> toJson() => {
    "VF_ID": vfId,
    "INV_ID": invId,
    "INV_NO": invNo,
    "INV_DT": invDt,
    "CUR_CODE": curCode,
    "PARTY_NAME": partyName,
    "NOT_DUE": notDue,
    "DAYS_30": days30,
    "DAYS_60": days60,
    "DAYS_90": days90,
    "DAYS_120": days120,
    "ABOVE_120": above120,
    "TOTAL_DUE": totalDue,
  };
}
