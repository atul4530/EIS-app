import 'dart:convert';

class ExpenseBudgetModel {
  List<Result>? result;
  bool? status;
  String? message;

  ExpenseBudgetModel({
    this.result,
    this.status,
    this.message,
  });

  factory ExpenseBudgetModel.fromRawJson(String str) => ExpenseBudgetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExpenseBudgetModel.fromJson(Map<String, dynamic> json) => ExpenseBudgetModel(
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
  String? invNo;
  String? invDt;
  String? narration;
  String? accountName;
  String? gssgName;
  String? debitCredit;
  int? amount;

  Result({
    this.invNo,
    this.invDt,
    this.narration,
    this.accountName,
    this.gssgName,
    this.debitCredit,
    this.amount,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    invNo: json["INV_NO"],
    invDt: json["INV_DT"],
    narration: json["NARRATION"],
    accountName: json["ACCOUNT_NAME"],
    gssgName: json["GSSG_NAME"],
    debitCredit: json["DEBIT_CREDIT"],
    amount: json["AMOUNT"],
  );

  Map<String, dynamic> toJson() => {
    "INV_NO": invNo,
    "INV_DT": invDt,
    "NARRATION": narration,
    "ACCOUNT_NAME": accountName,
    "GSSG_NAME": gssgName,
    "DEBIT_CREDIT": debitCredit,
    "AMOUNT": amount,
  };
}
