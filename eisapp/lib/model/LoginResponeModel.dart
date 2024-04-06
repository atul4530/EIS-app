import 'dart:convert';

class LoginResponseModel {
  String? result;
  List<Datum>? data;
  bool? status;
  String? message;

  LoginResponseModel({
    this.result,
    this.data,
    this.status,
    this.message,
  });

  factory LoginResponseModel.fromRawJson(String str) => LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    result: json["result"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    status: json["STATUS"],
    message: json["MESSAGE"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "STATUS": status,
    "MESSAGE": message,
  };
}

class Datum {
  int? empId;
  String? fullName;
  String? title;
  String? empCode;
  int? cscId;
  String? cscCode;
  String? cscName;
  int? ascId;
  String? ascCode;
  String? ascName;
  int? subareaId;
  String? emailId;
  int? isCrmUser;
  String? photoPath;
  int? encodedId;
  String? showReport;
  DateTime? startDt;
  String? currency;
  String? showprice;
  String? showageing;
  String? gp;
  String? target;
  int? customerSubareaId;
  String? accessPrivilege;
  String? isApprovalReq;
  String? digitalCatalogueReg;

  Datum({
    this.empId,
    this.fullName,
    this.title,
    this.empCode,
    this.cscId,
    this.cscCode,
    this.cscName,
    this.ascId,
    this.ascCode,
    this.ascName,
    this.subareaId,
    this.emailId,
    this.isCrmUser,
    this.photoPath,
    this.encodedId,
    this.showReport,
    this.startDt,
    this.currency,
    this.showprice,
    this.showageing,
    this.gp,
    this.target,
    this.customerSubareaId,
    this.accessPrivilege,
    this.isApprovalReq,
    this.digitalCatalogueReg,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    empId: json["EMP_ID"],
    fullName: json["FULL_NAME"],
    title: json["TITLE"],
    empCode: json["EMP_CODE"],
    cscId: json["CSC_ID"],
    cscCode: json["CSC_CODE"],
    cscName: json["CSC_NAME"],
    ascId: json["ASC_ID"],
    ascCode: json["ASC_CODE"],
    ascName: json["ASC_NAME"],
    subareaId: json["SUBAREA_ID"],
    emailId: json["EMAIL_ID"],
    isCrmUser: json["IS_CRM_USER"],
    photoPath: json["PHOTO_PATH"],
    encodedId: json["ENCODED_ID"],
    showReport: json["SHOW_REPORT"],
    startDt: json["START_DT"] == null ? null : DateTime.parse(json["START_DT"]),
    currency: json["CURRENCY"],
    showprice: json["SHOWPRICE"],
    showageing: json["SHOWAGEING"],
    gp: json["GP"],
    target: json["TARGET"],
    customerSubareaId: json["CUSTOMER_SUBAREA_ID"],
    accessPrivilege: json["ACCESS_PRIVILEGE"],
    isApprovalReq: json["IS_APPROVAL_REQ"],
    digitalCatalogueReg: json["DIGITAL_CATALOGUE_REG"],
  );

  Map<String, dynamic> toJson() => {
    "EMP_ID": empId,
    "FULL_NAME": fullName,
    "TITLE": title,
    "EMP_CODE": empCode,
    "CSC_ID": cscId,
    "CSC_CODE": cscCode,
    "CSC_NAME": cscName,
    "ASC_ID": ascId,
    "ASC_CODE": ascCode,
    "ASC_NAME": ascName,
    "SUBAREA_ID": subareaId,
    "EMAIL_ID": emailId,
    "IS_CRM_USER": isCrmUser,
    "PHOTO_PATH": photoPath,
    "ENCODED_ID": encodedId,
    "SHOW_REPORT": showReport,
    "START_DT": startDt?.toIso8601String(),
    "CURRENCY": currency,
    "SHOWPRICE": showprice,
    "SHOWAGEING": showageing,
    "GP": gp,
    "TARGET": target,
    "CUSTOMER_SUBAREA_ID": customerSubareaId,
    "ACCESS_PRIVILEGE": accessPrivilege,
    "IS_APPROVAL_REQ": isApprovalReq,
    "DIGITAL_CATALOGUE_REG": digitalCatalogueReg,
  };
}
