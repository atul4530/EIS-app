import 'dart:convert';

class MeltingLockModel {
  List<Result>? result;
  bool? status;
  String? message;

  MeltingLockModel({
    this.result,
    this.status,
    this.message,
  });

  factory MeltingLockModel.fromRawJson(String str) => MeltingLockModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MeltingLockModel.fromJson(Map<String, dynamic> json) => MeltingLockModel(
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
  String? prodOrderNo;
  int? orderQty;
  String? metalType;
  String? metalWt;

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
    this.prodOrderNo,
    this.orderQty,
    this.metalType,
    this.metalWt,
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
    headSalesman: json["HEAD_SALESMAN"],
    market: json["MARKET"],
    prodOrderNo: json["PROD_ORDER_NO"],
    orderQty: json["ORDER_QTY"],
    metalType: json["METAL_TYPE"],
    metalWt: json["METAL_WT"],
  );

  Map<String, dynamic> toJson() => {
    "PO_ID": poId,
    "PO_NO": poNo,
    "PO_DT": poDt,
    "PO_TYPE": poType,
    "CUSTOMER_CODE": customerCode,
    "CUSTOMER_ALIAS_NAME": customerAliasName,
    "SHIPMENT_DT": shipmentDt,
    "HEAD_SALESMAN": headSalesman,
    "MARKET": market,
    "PROD_ORDER_NO": prodOrderNo,
    "ORDER_QTY": orderQty,
    "METAL_TYPE": metalType,
    "METAL_WT": metalWt,
  };
}
