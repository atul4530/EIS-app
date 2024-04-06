import 'dart:convert';

class GetBarCodeCatalogListModel {
  List<GetBarCodeCatalogList>? getBarCodeCatalogList;
  bool? result;

  GetBarCodeCatalogListModel({
    this.getBarCodeCatalogList,
    this.result,
  });

  factory GetBarCodeCatalogListModel.fromRawJson(String str) => GetBarCodeCatalogListModel.fromJson(json.decode(str));

 // String toRawJson() => json.encode(toJson());

  factory GetBarCodeCatalogListModel.fromJson(Map<String, dynamic> json) => GetBarCodeCatalogListModel(
    getBarCodeCatalogList: json["getBarCodeCatalogList"] == null ? [] : List<GetBarCodeCatalogList>.from(json["getBarCodeCatalogList"]!.map((x) => GetBarCodeCatalogList.fromJson(x))),
    result: json["result"],
  );


}

class GetBarCodeCatalogList {
  int? page;
  int? noOfPages;
  int? totalRecords;
  int? rn;
  int? contId;
  String? contTypeNo;
  String? collection1;
  String? businessCategoryName;
  String? stoneDesc;
  String? metalDesc;
  String? jewelleryTypeName;
  String? styleNo;
  String? customerCode;
  String? img;
  int? stockQty;

  GetBarCodeCatalogList({
    this.page,
    this.noOfPages,
    this.totalRecords,
    this.rn,
    this.contId,
    this.contTypeNo,
    this.collection1,
    this.businessCategoryName,
    this.stoneDesc,
    this.metalDesc,
    this.jewelleryTypeName,
    this.styleNo,
    this.customerCode,
    this.img,
    this.stockQty,
  });

  factory GetBarCodeCatalogList.fromRawJson(String str) => GetBarCodeCatalogList.fromJson(json.decode(str));



  factory GetBarCodeCatalogList.fromJson(Map<String, dynamic> json) => GetBarCodeCatalogList(
    page: json["PAGE"],
    noOfPages: json["NO_OF_PAGES"],
    totalRecords: json["TOTAL_RECORDS"],
    rn: json["RN"],
    contId: json["CONT_ID"],
    contTypeNo: json["CONT_TYPE_NO"],
    collection1: json["COLLECTION1"],
    businessCategoryName: json["BUSINESS_CATEGORY_NAME"],
    stoneDesc: json["STONE_DESC"],
    metalDesc: json["METAL_DESC"],
    jewelleryTypeName: json["JEWELLERY_TYPE_NAME"],
    styleNo: json["STYLE_NO"],
    customerCode: json["CUSTOMER_CODE"],
    img: json["IMG"],
    stockQty: json["STOCK_QTY"],
  );


}
