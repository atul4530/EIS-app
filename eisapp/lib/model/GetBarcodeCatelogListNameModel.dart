import 'dart:convert';

class GetBarCodeCatelogNameListModel {
  List<GetBarCodeCatalogNameList>? getBarCodeCatalogNameList;
  bool? result;

  GetBarCodeCatelogNameListModel({
    this.getBarCodeCatalogNameList,
    this.result,
  });

  factory GetBarCodeCatelogNameListModel.fromRawJson(String str) => GetBarCodeCatelogNameListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBarCodeCatelogNameListModel.fromJson(Map<String, dynamic> json) => GetBarCodeCatelogNameListModel(
    getBarCodeCatalogNameList: json["getBarCodeCatalogNameList"] == null ? [] : List<GetBarCodeCatalogNameList>.from(json["getBarCodeCatalogNameList"]!.map((x) => GetBarCodeCatalogNameList.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "getBarCodeCatalogNameList": getBarCodeCatalogNameList == null ? [] : List<dynamic>.from(getBarCodeCatalogNameList!.map((x) => x.toJson())),
    "result": result,
  };
}

class GetBarCodeCatalogNameList {
  int? value;
  String? label;
  int? catCount;

  GetBarCodeCatalogNameList({
    this.value,
    this.label,
    this.catCount,
  });

  factory GetBarCodeCatalogNameList.fromRawJson(String str) => GetBarCodeCatalogNameList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBarCodeCatalogNameList.fromJson(Map<String, dynamic> json) => GetBarCodeCatalogNameList(
    value: json["VALUE"],
    label: json["LABEL"],
    catCount: json["cat_count"],
  );

  Map<String, dynamic> toJson() => {
    "VALUE": value,
    "LABEL": label,
    "cat_count": catCount,
  };
}
