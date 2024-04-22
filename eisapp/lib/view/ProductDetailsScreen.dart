import 'dart:convert';

import 'package:eisapp/model/GetFinishedProductMainInfoModel.dart';
import 'package:eisapp/model/GetFinishedProductMetalDetModel.dart';
import 'package:eisapp/view/ViewImageScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';

import 'package:flutter/material.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

import '../helper/pref_data.dart';
import '../model/GetBarCodeCatelogListModel.dart';
import '../model/GetBarCodeContactColumnRequired.dart';
import '../model/GetBarcodeCatelogListNameModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';
import 'CreateCatelog.dart';
import 'loader/loader.dart';

class ProductDetailsScreen extends StatefulWidget {
  String cont_id;
  GetBarCodeCatalogList data;

  ProductDetailsScreen(
      {super.key,
      required this.cont_id,
      required this.data});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with BackgroundDecoration {
  bool dataLoading = true;
  bool selectedContact = true;
  GetFinishedProductMainInfoModel? getFinishedProductMainInfoModel;
  GetFinishedProductMainInfo? getFinishedProductMainInfo;
  GetFinishedProductMetalDetModel? getFinishedProductMetalDetModel;
  GetFinishedProductMetalDet? getFinishedProductMetalDet;

  DateTime selectedDate = DateTime.now();
  String expiry = "";
  String selected_catelog = "Select Catalog";
  String selected_catelog_id = "Select Catalog";

  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2030))
        .then((picked) {
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          final DateFormat formatter = DateFormat('dd-MMM-yyyy');
          final String formatted = formatter.format(selectedDate);
          expiry = formatted;

          print("DATA\n\n\n\n\n\n ${formatted}");
        });
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBarcodeCatelogListData();
  }

  getBarcodeCatelogListData() async {
    setState(() {
      dataLoading = true;
    });
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        "rfid/TA/result/getFinishedProductMainInfo/-1/${loginResponseModel.data!.first.cscId}/-1/-1/${widget.cont_id}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    GetFinishedProductMainInfoModel data =
        GetFinishedProductMainInfoModel.fromJson(jsonDecode(response.body));
    if (data.result ?? false) {
      var responseMet = await ApiService.getData(
          "rfid/TA/result/getFinishedProductMetalDet/-1/${loginResponseModel.data!.first.cscId}/-1/-1/${widget.cont_id}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
      GetFinishedProductMetalDetModel dataMet =
          GetFinishedProductMetalDetModel.fromJson(
              jsonDecode(responseMet.body));
      setState(() {
        getFinishedProductMainInfoModel = data;
        getFinishedProductMetalDetModel = dataMet;
        getFinishedProductMetalDet = dataMet.getFinishedProductMetalDet!.first;
        getFinishedProductMainInfo = data.getFinishedProductMainInfo!.first;
        selected_image = data.getFinishedProductMainInfo!.first.imageUrl!;
        dataLoading = false;
      });
    } else {
      setState(() {
        dataLoading = false;
      });
    }
  }

  String selected_image = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgDecoration(),
          child: SingleChildScrollView(
            child: dataLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : getFinishedProductMainInfoModel!.result == false
                    ? const Center(
                        child: Text("No Data"),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            //color: Colors.black,
                            height: MediaQuery.of(context).size.height / 9,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                      userMobile(context) ? 8.0 : 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          )),
                                      GestureDetector(
                                        onTap: () async {
                                          await getSelectCatelogData();
                                          openOptions(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          child: Row(
                                            children: [
                                              Text(
                                                selected_catelog,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        userMobile(context)
                                                            ? 13.sp
                                                            : 16.sp),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                                size: 15.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      userMobile(context) ? 8.0 : 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getFinishedProductMainInfo!.contTypeNo!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: userMobile(context)
                                                ? userMobile(context)
                                                    ? 16.sp
                                                    : 20.sp
                                                : 18.sp),
                                      ),
                                      Container()
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration:decorationCommon(),
                            height: MediaQuery.of(context).size.height -
                                MediaQuery.of(context).size.height / 8,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewImageScreen(
                                                            image:
                                                                selected_image)));
                                          },
                                          child: Image.network(
                                            selected_image,
                                            height: 26.h,
                                            width: 26.h,
                                          )),
                                      Container(
                                        height: 1,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                      Container(
                                        height: 8.h,
                                        width: 65.w,
                                        alignment: Alignment.center,
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected_image =
                                                      getFinishedProductMainInfo!
                                                          .highRes1!;
                                                });
                                              },
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    getFinishedProductMainInfo!
                                                        .highRes1!,
                                                    height: 7.h,
                                                    width: 7.h,
                                                  )),
                                            ),
                                            SizedBox(width: 5,),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected_image =
                                                      getFinishedProductMainInfo!
                                                          .highRes2!;
                                                });
                                              },
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    getFinishedProductMainInfo!
                                                        .highRes2!,
                                                    height: 7.h,
                                                    width: 7.h,
                                                  )),
                                            ),
                                            SizedBox(width: 5,),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected_image =
                                                      getFinishedProductMainInfo!
                                                          .highRes3!;
                                                });
                                              },
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    getFinishedProductMainInfo!
                                                        .highRes3!,
                                                    height: 7.h,
                                                    width: 7.h,
                                                  )),
                                            ),
                                            SizedBox(width: 5,),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected_image =
                                                      getFinishedProductMainInfo!
                                                          .highRes4!;
                                                });
                                              },
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    getFinishedProductMainInfo!
                                                        .highRes4!,
                                                    height: 7.h,
                                                    width: 7.h,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8, top: 4, bottom: 4),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffB3B1AB)
                                                    .withOpacity(0.5)),
                                            child: Text(
                                              "Product Information",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: userMobile(context)
                                                      ? 16.sp
                                                      : 20.sp),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Style Number",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  getFinishedProductMainInfo!
                                                      .styleNo!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Contact Number",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  getFinishedProductMainInfo!
                                                      .contTypeNo!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "KGK Collection",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  getFinishedProductMainInfo!
                                                      .collection1!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Customer Collection",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  getFinishedProductMainInfo!
                                                      .collection2!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Jewellery Type",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  getFinishedProductMainInfo!
                                                      .jewellerTypeName!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8, top: 4, bottom: 4),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffB3B1AB)
                                                    .withOpacity(0.5)),
                                            child: Text(
                                              "Certified Diamond",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: userMobile(context)
                                                      ? 16.sp
                                                      : 20.sp),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Weight",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  "${getFinishedProductMetalDet!.weight}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "No of Place",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  "${getFinishedProductMetalDet!.numberOfPieces}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.7))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Color",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  "${getFinishedProductMetalDet!.color}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                top: 4,
                                                bottom: 4,
                                                right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "MM Size",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 16.sp
                                                              : 20.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  "${getFinishedProductMetalDet!.mmSize}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 8, top: 4, bottom: 4),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffB3B1AB)
                                                    .withOpacity(0.5)),
                                            child: Text(
                                              "${getFinishedProductMetalDet!.commodity}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: userMobile(context)
                                                      ? 16.sp
                                                      : 20.sp),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (selected_catelog ==
                                          "Select Catelog") {
                                        await getBarcodeCatelogNameListModel();
                                        openDigitalCatelog(
                                            context, widget.data);
                                      } else {
                                        submitData(context, widget.data);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.add_shopping_cart_outlined,
                                        color: const Color(0xff6a208f),
                                        size:
                                            userMobile(context) ? 24.sp : 27.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  ///If Catelog is not selected
  List<GetBarCodeCatalogNameList> selectedColumnData = [];
  List<GetCatalogReqColumn> selectedColumnDataContract = [];
  List<GetBarCodeCatalogNameList> selectedData = [];
  List<GetCatalogReqColumn> selectedDataContract = [];

  TextEditingController catelogNameController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  submitFormData(BuildContext context, String url) async {
    showLoaderDialog(context);
    //LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(url);
    print("Response :  ${response.body}");
    Navigator.pop(context);
    Navigator.pop(context);
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Added Successfully ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  getBarcodeCatelogNameListModel() async {
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    showLoaderDialog(context);
    selectedColumnDataContract.clear();
    var response = await ApiService.getData(selectedContact
        ? "rfid/TA/result/getCatalogReqColumns/-1/${loginResponseModel.data!.first.cscId}/-1/-1/'CONTRACT'/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1"
        : "rfid/TA/result/getBarCodeCatalogNameList/-1/${loginResponseModel.data!.first.cscId!}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    if (selectedContact) {
      GetBarCodeCatelogRequriedColumnListModel
      getBarCodeCatelogRequriedColumnListModel =
      GetBarCodeCatelogRequriedColumnListModel.fromJson(
          jsonDecode(response.body));
      if (getBarCodeCatelogRequriedColumnListModel.result ?? false) {
        Navigator.pop(context);
        setState(() {
          selectedColumnDataContract.addAll(
              getBarCodeCatelogRequriedColumnListModel.getCatalogReqColumns!);
        });
      } else {}
    } else {
      GetBarCodeCatelogNameListModel getBarCodeCatelogNameListModel =
      GetBarCodeCatelogNameListModel.fromJson(jsonDecode(response.body));
      if (getBarCodeCatelogNameListModel.result ?? false) {
        Navigator.pop(context);
        setState(() {
          selectedColumnData.addAll(
              getBarCodeCatelogNameListModel.getBarCodeCatalogNameList!);
        });
      } else {}
    }
  }

  openDigitalCatelog(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) {
    selectedData.clear();
    showDialog<void>(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 70.h,
              width: 98.w,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Digital Catelog",
                            style: TextStyle(
                                color: const Color(0xff6a208f),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // ignore: prefer_is_empty
                              if (catelogNameController.text.trim().length >
                                  0 &&
                                  remarksController.text.trim().length >
                                      0 &&
                                  selectedDataContract.length > 0 &&
                                  expiry != "") {
                                LoginResponseModel loginResponseModel =
                                LoginResponseModel.fromJson(jsonDecode(
                                    (await PreferenceHelper()
                                        .getStringValuesSF("data"))
                                        .toString()));
                                List columnData = [];
                                for (int i = 0;
                                i < selectedDataContract.length;
                                i++) {
                                  columnData
                                      .add(selectedDataContract[i].value!);
                                }
                                String url =
                                    'rfid/TA/kciSaveBarCodeScan/{"catalogId":"-1","catalogName":"${catelogNameController.text.trim()}","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"${columnData.toString().replaceAll("[", "").replaceAll("]", "")}","contractNo":"${getBarCodeCatalogList.contTypeNo!.replaceAll("/", "-")}","contractId":"${getBarCodeCatalogList.contId}","userId":"${await loginResponseModel.data!.first.empId}","remarks":"${remarksController.text.trim()}","expirydate":"$expiry"}';
                                submitFormData(context, url);
                              } else {
                                var snackBar = const SnackBar(
                                    content: Text('"Enter Value!!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "SAVE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              child: Text(
                                "Catelog Name*",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 13.sp),
                                textAlign: TextAlign.start,
                              )),
                          Container(
                            height: 30.sp,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5),
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: catelogNameController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Expiry Date",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 13.sp),
                              textAlign: TextAlign.start,
                            )),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context).then((value) {
                              setState((){});
                            });
                          },
                          child: SizedBox(
                            height: 5.h,
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  height: 30.sp,
                                  width: 100.w,
                                  //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      expiry == "" ? "DD-MM-YYYY" : expiry,
                                      style: TextStyle(
                                          fontSize: 13.5.sp,
                                          color: Colors.black
                                              .withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              child: Text(
                                "Remarks",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 13.sp),
                                textAlign: TextAlign.start,
                              )),
                          Container(
                            height: 30.sp,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5),
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: remarksController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                width: 1,
                                color: Colors.black.withOpacity(0.5))),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 3),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 30.sp,
                            width: 100.w,
                            //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Select Column Required*",
                                style: TextStyle(
                                    fontSize: 13.5.sp,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
                      child: ListView.builder(
                          itemCount: selectedContact
                              ? selectedColumnDataContract.length
                              : selectedColumnData.length,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          itemBuilder: (context, index) {
                            var data = selectedContact
                                ? GetBarCodeCatalogNameList()
                                : selectedColumnData[index];
                            var dataC = selectedContact
                                ? selectedColumnDataContract[index]
                                : GetCatalogReqColumn();
                            return GestureDetector(
                              onTap: () {
                                if (selectedDataContract.contains(dataC)) {
                                  selectedDataContract.remove(dataC);
                                } else {
                                  selectedDataContract.add(dataC);
                                }

                                print("------- $selectedDataContract");
                                setState(() {});
                              },
                              child: SizedBox(
                                height: 5.h,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 3),
                                  color: selectedContact
                                      ? (selectedDataContract
                                      .contains(dataC)
                                      ? Colors.deepPurple
                                      .withOpacity(0.5)
                                      : Colors.white)
                                      : (selectedData.contains(data)
                                      ? Colors.deepPurple
                                      .withOpacity(0.5)
                                      : Colors.white),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      height: 30.sp,
                                      width: 100.w,
                                      //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0),
                                        child: Text(
                                          selectedContact
                                              ? dataC.label!
                                              : data.label!,
                                          style: TextStyle(
                                              fontSize: 13.5.sp,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        })).then((value) {
      //   Navigator.pop(context);
    });
  }


  ///Is Catelog is selected

  GetBarCodeCatelogNameListModel? getBarCodeCatelogNameList;

  openOptions(BuildContext context) {
    //selectedData.clear();
    showDialog<void>(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 50.h,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected_catelog = "Select Catelog";
                              selected_catelog_id = "Select Catelog";
                              Navigator.pop(context);
                            });
                          },
                          child: SizedBox(
                            height: 5.h,
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  height: 30.sp,
                                  width: 100.w,
                                  //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Select Catelog",
                                      style: TextStyle(
                                          fontSize: 13.5.sp,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 98.w,
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: getBarCodeCatelogNameList!
                                .getBarCodeCatalogNameList!.length,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            itemBuilder: (context, index) {
                              var dataC = getBarCodeCatelogNameList!
                                  .getBarCodeCatalogNameList![index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected_catelog = dataC.label!;
                                    selected_catelog_id =
                                        dataC.value!.toString();
                                    Navigator.pop(context);
                                  });
                                },
                                child: SizedBox(
                                  height: 5.h,
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 3),
                                    color: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        height: 30.sp,
                                        width: 100.w,
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            dataC.label!,
                                            style: TextStyle(
                                                fontSize: 13.5.sp,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            })).then((value) {
      setState(() {});
    });
  }

  submitData(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) async {
    showLoaderDialog(context);
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        'rfid/TA/kciSaveBarCodeScan/{"catalogId":"$selected_catelog_id","catalogName":"$selected_catelog","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"","contractNo":"${getBarCodeCatalogList.contTypeNo!.replaceAll("/", "-")}","contractId":"${getBarCodeCatalogList.contId}","userId":"${loginResponseModel.data!.first.empId}","remarks":""}');
    print("Response :  ${response.body}");
    Navigator.pop(context);
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Added Successfully ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  getSelectCatelogData() async {
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    showLoaderDialog(context);
    var response = await ApiService.getData(
        "rfid/TA/result/getBarCodeCatalogNameList/-1/${loginResponseModel.data!.first.cscId!}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    getBarCodeCatelogNameList =
        GetBarCodeCatelogNameListModel.fromJson(jsonDecode(response.body));
    Navigator.pop(context);
  }
}
