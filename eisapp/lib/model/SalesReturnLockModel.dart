import 'dart:convert';

class SalesReturnLockModel {
  List<Result>? result;
  bool? status;
  String? message;

  SalesReturnLockModel({
    this.result,
    this.status,
    this.message,
  });

  factory SalesReturnLockModel.fromRawJson(String str) => SalesReturnLockModel.fromJson(json.decode(str));



  factory SalesReturnLockModel.fromJson(Map<String, dynamic> json) => SalesReturnLockModel(
    result: json["RESULT"] == null ? [] : List<Result>.from(json["RESULT"]!.map((x) => Result.fromJson(x))),
    status: json["STATUS"],
    message: json["MESSAGE"],
  );


}

class Result {
  int? vfId;
  int? invId;
  String? invNo;
  String? invDt;
  String? invPartyName;
  String? shipmentTypeName;
  dynamic cySalesAmtIntl;
  dynamic pySalesAmtIntl;
  dynamic cySalesReturnAmtIntl;
  dynamic pySalesReturnAmtIntl;
  String? productCode;
  String? locationName;
  int? invQty1;
  double? mcpRateIntl;
  double? mcpAmtIntl;

  Result({
    this.vfId,
    this.invId,
    this.invNo,
    this.invDt,
    this.invPartyName,
    this.shipmentTypeName,
    this.cySalesAmtIntl,
    this.pySalesAmtIntl,
    this.cySalesReturnAmtIntl,
    this.pySalesReturnAmtIntl,
    this.productCode,
    this.locationName,
    this.invQty1,
    this.mcpRateIntl,
    this.mcpAmtIntl,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));


  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vfId: json["VF_ID"],
    invId: json["INV_ID"],
    invNo: json["INV_NO"].toString(),
    invDt: json["INV_DT"].toString(),
    invPartyName: json["INV_PARTY_NAME"].toString(),
    shipmentTypeName: json["SHIPMENT_TYPE_NAME"].toString(),
    cySalesAmtIntl: json["CY_SALES_AMT_INTL"],
    pySalesAmtIntl: json["PY_SALES_AMT_INTL"],
    cySalesReturnAmtIntl: json["CY_SALES_RETURN_AMT_INTL"],
    pySalesReturnAmtIntl: json["PY_SALES_RETURN_AMT_INTL"],
    productCode: json["PRODUCT_CODE"],
    locationName: json["LOCATION_NAME"].toString(),
    invQty1: json["INV_QTY1"],
    mcpRateIntl: json["MCP_RATE_INTL"]?.toDouble(),
    mcpAmtIntl: json["MCP_AMT_INTL"]?.toDouble(),
  );

}
