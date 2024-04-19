import 'dart:convert';

class ShareModel {
  List<GetBarCodeCatalogShare>? getBarCodeCatalogShare;
  bool? result;

  ShareModel({
    this.getBarCodeCatalogShare,
    this.result,
  });

  factory ShareModel.fromRawJson(String str) => ShareModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShareModel.fromJson(Map<String, dynamic> json) => ShareModel(
    getBarCodeCatalogShare: json["getBarCodeCatalogShare"] == null ? [] : List<GetBarCodeCatalogShare>.from(json["getBarCodeCatalogShare"]!.map((x) => GetBarCodeCatalogShare.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "getBarCodeCatalogShare": getBarCodeCatalogShare == null ? [] : List<dynamic>.from(getBarCodeCatalogShare!.map((x) => x.toJson())),
    "result": result,
  };
}

class GetBarCodeCatalogShare {
  int? digitalCatalogueId;
  String? subject;
  String? linkUrl;
  String? msg;

  GetBarCodeCatalogShare({
    this.digitalCatalogueId,
    this.subject,
    this.linkUrl,
    this.msg,
  });

  factory GetBarCodeCatalogShare.fromRawJson(String str) => GetBarCodeCatalogShare.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBarCodeCatalogShare.fromJson(Map<String, dynamic> json) => GetBarCodeCatalogShare(
    digitalCatalogueId: json["DIGITAL_CATALOGUE_ID"],
    subject: json["SUBJECT"],
    linkUrl: json["LINK_URL"],
    msg: json["MSG"],
  );

  Map<String, dynamic> toJson() => {
    "DIGITAL_CATALOGUE_ID": digitalCatalogueId,
    "SUBJECT": subject,
    "LINK_URL": linkUrl,
    "MSG": msg,
  };
}
