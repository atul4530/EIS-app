import 'dart:convert';

class MemoAgeignLockModel {
  List<Result>? result;
  bool? status;
  String? message;

  MemoAgeignLockModel({
    this.result,
    this.status,
    this.message,
  });

  factory MemoAgeignLockModel.fromRawJson(String str) => MemoAgeignLockModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemoAgeignLockModel.fromJson(Map<String, dynamic> json) => MemoAgeignLockModel(
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
  String? invPartyName;
  String? curCode;
  String? memoInvNo;
  String? memoInvDt;
  int? memoMemoDays;
  int? pendingQty;
  double? pendingAmount;

  Result({
    this.vfId,
    this.invId,
    this.invNo,
    this.invDt,
    this.invPartyName,
    this.curCode,
    this.memoInvNo,
    this.memoInvDt,
    this.memoMemoDays,
    this.pendingQty,
    this.pendingAmount,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vfId: json["VF_ID"],
    invId: json["INV_ID"],
    invNo: json["INV_NO"],
    invDt: json["INV_DT"],
    invPartyName: json["INV_PARTY_NAME"],
    curCode: json["CUR_CODE"],
    memoInvNo: json["MEMO_INV_NO"],
    memoInvDt: json["MEMO_INV_DT"],
    memoMemoDays: json["MEMO_MEMO_DAYS"],
    pendingQty: json["PENDING_QTY"],
    pendingAmount: json["PENDING_AMOUNT"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "VF_ID": vfId,
    "INV_ID": invId,
    // "INV_NO": invNoValues.reverse[invNo],
    // "INV_DT": invDtValues.reverse[invDt],
    // "INV_PARTY_NAME": invPartyNameValues.reverse[invPartyName],
    // "CUR_CODE": curCodeValues.reverse[curCode],
    "MEMO_INV_NO": memoInvNo,
    "MEMO_INV_DT": memoInvDt,
    "MEMO_MEMO_DAYS": memoMemoDays,
    "PENDING_QTY": pendingQty,
    "PENDING_AMOUNT": pendingAmount,
  };
}
