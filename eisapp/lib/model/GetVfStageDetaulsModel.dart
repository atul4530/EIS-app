import 'dart:convert';

class GetVfStageDetailsModel {
  List<Result>? result;
  bool? status;
  String? message;

  GetVfStageDetailsModel({
    this.result,
    this.status,
    this.message,
  });

  factory GetVfStageDetailsModel.fromRawJson(String str) => GetVfStageDetailsModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory GetVfStageDetailsModel.fromJson(Map<String, dynamic> json) => GetVfStageDetailsModel(
    result: json["RESULT"] == null ? [] : List<Result>.from(json["RESULT"]!.map((x) => Result.fromJson(x))),
    status: json["STATUS"],
    message: json["MESSAGE"],
  );

}

class Result {
  String? vfId;
  String? vfInvId;
  String? vfInvType;
  String? vfInvNo;
  String? actionBy;
  String? vfStageId;
  String? vfCode;
  String? isRequired;
  String? isVerified;
  String? isPassedToMail;
  String? subject;
  String? approverEisId;
  String? approverEmailOff;
  String? approverMobileNo;
  String? ccMailIds;
  String? bccMailIds;
  String? remarks;
  String? vfAction;
  String? isAppMobile;
  String? userComments;
  String? isLocked;
  String? systemRemarks;
  String? createdBy;
  String? createdDt;
  String? updatedBy;
  String? updatedDt;
  String? isDeleted;
  String? cscId;
  String? cscCode;
  String? customerAliasName;
  String? approverName;
  String? keyValue;

  Result({
    this.vfId,
    this.vfInvId,
    this.vfInvType,
    this.vfInvNo,
    this.actionBy,
    this.vfStageId,
    this.vfCode,
    this.isRequired,
    this.isVerified,
    this.isPassedToMail,
    this.subject,
    this.approverEisId,
    this.approverEmailOff,
    this.approverMobileNo,
    this.ccMailIds,
    this.bccMailIds,
    this.remarks,
    this.vfAction,
    this.isAppMobile,
    this.userComments,
    this.isLocked,
    this.systemRemarks,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
    this.isDeleted,
    this.cscId,
    this.cscCode,
    this.customerAliasName,
    this.approverName,
    this.keyValue,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) =>
      Result(
        vfId: json["VF_ID"].toString(),
        vfInvId: json["VF_INV_ID"].toString(),
        vfInvType: json["VF_INV_TYPE"].toString(),
        vfInvNo: json["VF_INV_NO"].toString(),
        actionBy: json["ACTION_BY"].toString(),
        vfStageId: json["VF_STAGE_ID"].toString(),
        vfCode: json["VF_CODE"].toString(),
        isRequired: json["IS_REQUIRED"].toString(),
        isVerified: json["IS_VERIFIED"].toString(),
        isPassedToMail: json["IS_PASSED_TO_MAIL"].toString(),
        subject: json["SUBJECT"].toString(),
        approverEisId: json["APPROVER_EIS_ID"].toString(),
        approverEmailOff: json["APPROVER_EMAIL_OFF"].toString(),
        approverMobileNo: json["APPROVER_MOBILE_NO"].toString(),
        ccMailIds: json["CC_MAIL_IDS"].toString(),
        bccMailIds: json["BCC_MAIL_IDS"].toString(),
        remarks: json["REMARKS"].toString(),
        vfAction: json["VF_ACTION"].toString(),
        isAppMobile: json["IS_APP_MOBILE"].toString(),
        userComments: json["USER_COMMENTS"].toString(),
        isLocked: json["IS_LOCKED"].toString(),
        systemRemarks: json["SYSTEM_REMARKS"].toString(),
        createdBy: json["CREATED_BY"].toString(),
        createdDt: json["CREATED_DT"].toString(),
        updatedBy: json["UPDATED_BY"].toString(),
        updatedDt: json["UPDATED_DT"].toString(),
        isDeleted: json["IS_DELETED"].toString(),
        cscId: json["CSC_ID"].toString(),
        cscCode: json["CSC_CODE"].toString(),
        customerAliasName: json["CUSTOMER_ALIAS_NAME"].toString(),
        approverName: json["APPROVER_NAME"].toString(),
        keyValue: json["KEY_VALUE"].toString(),
      );

  Map<String, dynamic> toJson() => {
    "VF_ID": vfId,
    "VF_INV_ID": vfInvId,
    "VF_INV_TYPE": vfInvType,
    "VF_INV_NO": vfInvNo,
    "ACTION_BY": actionBy,
    "VF_STAGE_ID": vfStageId,
    "VF_CODE": vfInvType,
    "IS_REQUIRED": isRequired,
    "IS_VERIFIED": isVerified,
    "IS_PASSED_TO_MAIL": isPassedToMail,
    "SUBJECT": subject,
    "APPROVER_EIS_ID": approverEisId,
    "APPROVER_EMAIL_OFF": approverEmailOff,
    "APPROVER_MOBILE_NO": approverMobileNo,
    "CC_MAIL_IDS": ccMailIds,
    "BCC_MAIL_IDS": bccMailIds,
    "REMARKS": remarks,
    "VF_ACTION": vfAction,
    "IS_APP_MOBILE": isAppMobile,
    "USER_COMMENTS": userComments,
    "IS_LOCKED": isLocked,
    "SYSTEM_REMARKS": systemRemarks,
    "IS_DELETED": isDeleted,
    "CSC_ID": cscId,
    "CSC_CODE": cscCode,
    "CUSTOMER_ALIAS_NAME": customerAliasName,
    "APPROVER_NAME": approverName,
    "KEY_VALUE": keyValue,
  };

}
