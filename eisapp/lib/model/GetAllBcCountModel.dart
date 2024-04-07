import 'dart:convert';

class GetAllBcAccountModel {
  List<Result>? result;
  bool? status;
  String? message;

  GetAllBcAccountModel({
    this.result,
    this.status,
    this.message,
  });

  factory GetAllBcAccountModel.fromRawJson(String str) => GetAllBcAccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllBcAccountModel.fromJson(Map<String, dynamic> json) => GetAllBcAccountModel(
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
  int? vfStageId;
  String? vfCode;
  int? bcCount;

  Result({
    this.vfStageId,
    this.vfCode,
    this.bcCount,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vfStageId: json["VF_STAGE_ID"],
    vfCode: json["VF_CODE"],
    bcCount: json["BC_COUNT"],
  );

  Map<String, dynamic> toJson() => {
    "VF_STAGE_ID": vfStageId,
    "VF_CODE": vfCode,
    "BC_COUNT": bcCount,
  };
}
