import 'dart:convert';

class GetFinishedProductMainInfoModel {
  List<GetFinishedProductMainInfo>? getFinishedProductMainInfo;
  bool? result;

  GetFinishedProductMainInfoModel({
    this.getFinishedProductMainInfo,
    this.result,
  });

  factory GetFinishedProductMainInfoModel.fromRawJson(String str) => GetFinishedProductMainInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetFinishedProductMainInfoModel.fromJson(Map<String, dynamic> json) => GetFinishedProductMainInfoModel(
    getFinishedProductMainInfo: json["getFinishedProductMainInfo"] == null ? [] : List<GetFinishedProductMainInfo>.from(json["getFinishedProductMainInfo"]!.map((x) => GetFinishedProductMainInfo.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "getFinishedProductMainInfo": getFinishedProductMainInfo == null ? [] : List<dynamic>.from(getFinishedProductMainInfo!.map((x) => x.toJson())),
    "result": result,
  };
}

class GetFinishedProductMainInfo {
  int? contId;
  String? contTypeNo;
  String? styleNo;
  String? jewellerTypeName;
  String? collection1;
  String? collection2;
  double? price;
  String? imageUrl;
  String? highRes1;
  String? highRes2;
  String? highRes3;
  String? highRes4;

  GetFinishedProductMainInfo({
    this.contId,
    this.contTypeNo,
    this.styleNo,
    this.jewellerTypeName,
    this.collection1,
    this.collection2,
    this.price,
    this.imageUrl,
    this.highRes1,
    this.highRes2,
    this.highRes3,
    this.highRes4,
  });

  factory GetFinishedProductMainInfo.fromRawJson(String str) => GetFinishedProductMainInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetFinishedProductMainInfo.fromJson(Map<String, dynamic> json) => GetFinishedProductMainInfo(
    contId: json["CONT_ID"],
    contTypeNo: json["CONT_TYPE_NO"],
    styleNo: json["STYLE_NO"],
    jewellerTypeName: json["JEWELLER_TYPE_NAME"],
    collection1: json["COLLECTION1"],
    collection2: json["COLLECTION2"],
    price: json["PRICE"]?.toDouble(),
    imageUrl: json["IMAGE_URL"],
    highRes1: json["HIGH_RES1"],
    highRes2: json["HIGH_RES2"],
    highRes3: json["HIGH_RES3"],
    highRes4: json["HIGH_RES4"],
  );

  Map<String, dynamic> toJson() => {
    "CONT_ID": contId,
    "CONT_TYPE_NO": contTypeNo,
    "STYLE_NO": styleNo,
    "JEWELLER_TYPE_NAME": jewellerTypeName,
    "COLLECTION1": collection1,
    "COLLECTION2": collection2,
    "PRICE": price,
    "IMAGE_URL": imageUrl,
    "HIGH_RES1": highRes1,
    "HIGH_RES2": highRes2,
    "HIGH_RES3": highRes3,
    "HIGH_RES4": highRes4,
  };
}
