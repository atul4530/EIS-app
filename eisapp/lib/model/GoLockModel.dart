import 'dart:convert';

class GpLockModel {
  List<Result>? result;
  bool? status;
  String? message;

  GpLockModel({
    this.result,
    this.status,
    this.message,
  });

  factory GpLockModel.fromRawJson(String str) => GpLockModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GpLockModel.fromJson(Map<String, dynamic> json) => GpLockModel(
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
  String? pricingNo;
  String? pricingDate;
  String? customer;
  String? headSalesman;
  String? market;
  int? contId;
  String? contNo;
  String? ocpgm;
  String? spAmt;
  String? chargeAmt;
  int? markup;

  Result({
    this.pricingNo,
    this.pricingDate,
    this.customer,
    this.headSalesman,
    this.market,
    this.contId,
    this.contNo,
    this.ocpgm,
    this.spAmt,
    this.chargeAmt,
    this.markup,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    pricingNo: json["PRICING_NO"],
    pricingDate: json["PRICING_DATE"],
    customer: json["CUSTOMER"],
    headSalesman: json["HEAD_SALESMAN"],
    market: json["MARKET"],
    contId: json["CONT_ID"],
    contNo: json["CONT_NO"],
    ocpgm: json["OCPGM"],
    spAmt: json["SP_AMT"],
    chargeAmt: json["CHARGE_AMT"],
    markup: json["MARKUP"],
  );

  Map<String, dynamic> toJson() => {
    "PRICING_NO": pricingNo,
    "PRICING_DATE": pricingDate,
    "CUSTOMER": customer,
    "HEAD_SALESMAN": headSalesman,
    "MARKET": market,
    "CONT_ID": contId,
    "CONT_NO": contNo,
    "OCPGM": ocpgm,
    "SP_AMT": spAmt,
    "CHARGE_AMT": chargeAmt,
    "MARKUP": markup,
  };
}
