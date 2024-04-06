import 'dart:convert';

class GetBarCodeCatelogRequriedColumnListModel {
  List<GetCatalogReqColumn>? getCatalogReqColumns;
  bool? result;

  GetBarCodeCatelogRequriedColumnListModel({
    this.getCatalogReqColumns,
    this.result,
  });

  factory GetBarCodeCatelogRequriedColumnListModel.fromRawJson(String str) => GetBarCodeCatelogRequriedColumnListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBarCodeCatelogRequriedColumnListModel.fromJson(Map<String, dynamic> json) => GetBarCodeCatelogRequriedColumnListModel(
    getCatalogReqColumns: json["getCatalogReqColumns"] == null ? [] : List<GetCatalogReqColumn>.from(json["getCatalogReqColumns"]!.map((x) => GetCatalogReqColumn.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "getCatalogReqColumns": getCatalogReqColumns == null ? [] : List<dynamic>.from(getCatalogReqColumns!.map((x) => x.toJson())),
    "result": result,
  };
}

class GetCatalogReqColumn {
  String? value;
  String? label;

  GetCatalogReqColumn({
    this.value,
    this.label,
  });

  factory GetCatalogReqColumn.fromRawJson(String str) => GetCatalogReqColumn.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCatalogReqColumn.fromJson(Map<String, dynamic> json) => GetCatalogReqColumn(
    value: json["VALUE"],
    label: json["LABEL"],
  );

  Map<String, dynamic> toJson() => {
    "VALUE": value,
    "LABEL": label,
  };
}
