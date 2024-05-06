import 'dart:convert';

import 'package:eisapp/helper/pref_data.dart';
import 'package:get/get.dart';

import '../model/GetBarcodeCatelogListNameModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';

class SelectCatalogHelper extends GetxController{
  GetBarCodeCatelogNameListModel? getBarCodeCatelogNameList;
  bool catalog_loading=false;
  String selected_value="Select Catalog";
  String selected_catalog_id="Select Catalog";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSelectCatelogData();
  }

  getSelectCatelogData() async {
    catalog_loading=true;
    update();
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        "rfid/TA/result/getBarCodeCatalogNameList/-1/${loginResponseModel.data!.first.cscId!}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    getBarCodeCatelogNameList =
        GetBarCodeCatelogNameListModel.fromJson(jsonDecode(response.body));
    getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.add(GetBarCodeCatalogNameList(label: "Select Catalog"));
    getBarCodeCatelogNameList!.getBarCodeCatalogNameList = getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.reversed.toList();
    catalog_loading=false;
    for(int i=0;i<getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.length;i++){
      if(getBarCodeCatelogNameList!.getBarCodeCatalogNameList![i].value.toString() == selected_catalog_id) {
        selected_value =
        getBarCodeCatelogNameList!.getBarCodeCatalogNameList![i].label!;
        i=getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.length;
      }
    }
    update();
  }
}