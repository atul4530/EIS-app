import 'dart:convert';

class GetCatelogListModelById {
  List<GetBarCodeCatalogListById>? getBarCodeCatalogListById;
  bool? result;
  String? message;

  GetCatelogListModelById({
    this.getBarCodeCatalogListById,
    this.result,
    this.message,
  });

  factory GetCatelogListModelById.fromRawJson(String str) => GetCatelogListModelById.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCatelogListModelById.fromJson(Map<String, dynamic> json) => GetCatelogListModelById(
    getBarCodeCatalogListById: json["getBarCodeCatalogListById"] == null ? [] : List<GetBarCodeCatalogListById>.from(json["getBarCodeCatalogListById"]!.map((x) => GetBarCodeCatalogListById.fromJson(x))),
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "getBarCodeCatalogListById": getBarCodeCatalogListById == null ? [] : List<dynamic>.from(getBarCodeCatalogListById!.map((x) => x.toJson())),
    "result": result,
    "message": message,
  };
}

class GetBarCodeCatalogListById {
  int? rn;
  int? contId;
  int? digitalCatalogueId;
  int? digitalCatalogueDetId;
  String? contTypeNo;
  String? collection1;
  String? businessCategoryName;
  String? stoneDesc;
  String? metalDesc;
  String? jewelleryTypeName;
  String? styleNo;
  String? customerCode;
  String? img;
  int? price;

  GetBarCodeCatalogListById({
    this.rn,
    this.contId,
    this.digitalCatalogueId,
    this.digitalCatalogueDetId,
    this.contTypeNo,
    this.collection1,
    this.businessCategoryName,
    this.stoneDesc,
    this.metalDesc,
    this.jewelleryTypeName,
    this.styleNo,
    this.customerCode,
    this.img,
    this.price,
  });

  factory GetBarCodeCatalogListById.fromRawJson(String str) => GetBarCodeCatalogListById.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBarCodeCatalogListById.fromJson(Map<String, dynamic> json) => GetBarCodeCatalogListById(
    rn: json["rn"],
    contId: json["cont_id"],
    digitalCatalogueId: json["digital_catalogue_id"],
    digitalCatalogueDetId: json["digital_catalogue_det_id"],
    contTypeNo: json["cont_type_no"],
    collection1: json["collection1"],
    businessCategoryName: json["business_category_name"],
    stoneDesc: json["stone_desc"],
    metalDesc: json["metal_desc"],
    jewelleryTypeName: json["jewellery_type_name"],
    styleNo: json["style_no"],
    customerCode: json["customer_code"],
    img: json["img"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "rn": rn,
    "cont_id": contId,
    "digital_catalogue_id": digitalCatalogueId,
    "digital_catalogue_det_id": digitalCatalogueDetId,
    "cont_type_no": contTypeNo,
    "collection1": collection1,
    "business_category_name": businessCategoryName,
    "stone_desc": stoneDesc,
    "metal_desc": metalDesc,
    "jewellery_type_name": jewelleryTypeName,
    "style_no": styleNo,
    "customer_code": customerCode,
    "img": img,
    "price": price,
  };
}
