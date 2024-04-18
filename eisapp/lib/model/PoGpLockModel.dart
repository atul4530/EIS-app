import 'dart:convert';

class PoGpLockModel {
  List<Result>? result;
  bool? status;
  String? message;

  PoGpLockModel({
    this.result,
    this.status,
    this.message,
  });

  factory PoGpLockModel.fromRawJson(String str) => PoGpLockModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PoGpLockModel.fromJson(Map<String, dynamic> json) => PoGpLockModel(
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
  int? poId;
  String? poNo;
  String? poDt;
  String? poType;
  String? customerCode;
  String? customerAliasName;
  String? shipmentDt;
  String? headSalesman;
  String? market;
  String? lotCode;
  double? totalQty1;
  double? lotMcp;
  double? lotSp;
  double? lotMargin;

  Result({
    this.poId,
    this.poNo,
    this.poDt,
    this.poType,
    this.customerCode,
    this.customerAliasName,
    this.shipmentDt,
    this.headSalesman,
    this.market,
    this.lotCode,
    this.totalQty1,
    this.lotMcp,
    this.lotSp,
    this.lotMargin,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    poId: json["PO_ID"],
    poNo: json["PO_NO"],
    poDt: json["PO_DT"],
    poType: json["PO_TYPE"],
    customerCode: json["CUSTOMER_CODE"],
    customerAliasName: json["CUSTOMER_ALIAS_NAME"],
    shipmentDt: json["SHIPMENT_DT"],
    headSalesman:json["HEAD_SALESMAN"],
    market: json["MARKET"],
    lotCode: json["LOT_CODE"],
    totalQty1: json["TOTAL_QTY1"]?.toDouble(),
    lotMcp: json["LOT_MCP"]?.toDouble(),
    lotSp: json["LOT_SP"]?.toDouble(),
    lotMargin: json["LOT_MARGIN"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "PO_ID": poId,

    "LOT_CODE": lotCode,
    "TOTAL_QTY1": totalQty1,
    "LOT_MCP": lotMcp,
    "LOT_SP": lotSp,
    "LOT_MARGIN": lotMargin,
  };
}
