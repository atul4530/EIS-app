// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:eisapp/helper/pref_data.dart';
import 'package:eisapp/model/GetBarCodeContactColumnRequired.dart';
import 'package:eisapp/model/GetBarcodeCatelogListNameModel.dart';
import 'package:eisapp/view/ProductDetailsScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:eisapp/view/loader/loader.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../helper/SelectCatelogHelper.dart';
import '../model/GetBarCodeCatelogListModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';
import 'CatelogListScreen.dart';

class CreateCatelog extends StatefulWidget {
  const CreateCatelog({super.key});

  @override
  State<CreateCatelog> createState() => _CreateCatelogState();
}

class _CreateCatelogState extends State<CreateCatelog>
    with BackgroundDecoration {
  bool light = false;
  bool selectedContact = true;

  List<GetBarCodeCatalogNameList> selectedColumnData = [];
  List<GetCatalogReqColumn> selectedColumnDataContract = [];
  List<GetBarCodeCatalogNameList> selectedData = [];
  List<GetCatalogReqColumn> selectedDataContract = [];
  bool dataLoading = true;
  GetBarCodeCatalogListModel? getBarCodeCatalogListModel;
  GetBarCodeCatalogListModel? getBarCodeCatalogListModelSearch;

  String selected_catelog = "Select Catalog";
  String selected_catelog_id = "Select Catalog";
  SelectCatalogHelper selectCatalogHelper = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBarcodeCatelogListData();
    getData();
  }

  ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  int page = 1;

  getData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        print('scrolling');
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          setState(() {
            isScrolled = true;
          });
          getBarcodeCatelogListDataScroll();
        }
      });
    });
  }

  getBarcodeCatelogListDataScroll() async {
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        "rfid/TA/result/getBarCodeCatalogList/-1/${loginResponseModel.data!.first.cscId}/-1/-1/-1/${++page}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    GetBarCodeCatalogListModel data =
        GetBarCodeCatalogListModel.fromJson(jsonDecode(response.body));
    if (data.result ?? false) {
      if (data.getBarCodeCatalogList!.isNotEmpty) {
        getBarCodeCatalogListModel!.getBarCodeCatalogList!
            .addAll(data.getBarCodeCatalogList!);
        setState(() {
          isScrolled = false;
        });
      } else {
        setState(() {
          isScrolled = false;
        });
      }
    } else {
      setState(() {
        isScrolled = false;
      });
    }
  }

  getBarcodeCatelogListData() async {
    setState(() {
      dataLoading = true;
    });
    selectCatalogHelper.getSelectCatelogData();
    selectCatalogHelper.selected_value="Select Catalog";
    selectCatalogHelper.selected_catalog_id="Select Catalog";
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        "rfid/TA/result/getBarCodeCatalogList/-1/${loginResponseModel.data!.first.cscId}/-1/-1/-1/$page/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    GetBarCodeCatalogListModel data =
        GetBarCodeCatalogListModel.fromJson(jsonDecode(response.body));
    if (data.result ?? false) {
      setState(() {
        getBarCodeCatalogListModel = data;
        dataLoading = false;
      });
    } else {
      setState(() {
        dataLoading = false;
      });
    }
  }

  bool searchClick = false;

  TextEditingController searchController = TextEditingController();
  List<GetBarCodeCatalogList>? tempList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgDecoration(),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height /(userMobile(context)? 10:(dataTablet>700?10:7.8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<SelectCatalogHelper>(builder: (controller) {
                        return Padding(
                          padding:
                              EdgeInsets.all(userMobile(context) ? 8.0 : 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                             Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      height: 30,
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 20),
                                      child: DropdownButton<
                                          GetBarCodeCatalogNameList>(
                                        hint: Text(
                                          controller.selected_value,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: userMobile(context)
                                                  ? 12.sp
                                                  : 16.sp),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        padding: EdgeInsets.zero,
                                        underline: Container(),
                                        elevation: 0,
                                        icon: Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            child: const Icon(
                                                Icons.arrow_drop_down_sharp)),
                                        items:controller
                                            .getBarCodeCatelogNameList==null?[]: controller
                                            .getBarCodeCatelogNameList!
                                            .getBarCodeCatalogNameList!
                                            .map((GetBarCodeCatalogNameList
                                                value) {
                                          return DropdownMenuItem<
                                              GetBarCodeCatalogNameList>(
                                            value: value,
                                            child: Text(value.label!),
                                          );
                                        }).toList(),
                                        onChanged: (_) {
                                          controller.selected_value =
                                              _!.label ?? '';
                                          controller.selected_catalog_id =
                                              _.value.toString();
                                          controller.update();
                                        },
                                      ),
                                    )
                              // GestureDetector(
                              //   onTap: () async {
                              //     await getSelectCatelogData();
                              //     openOptions(context);
                              //   },
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 10, vertical: 5),
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.circular(35)),
                              //     child: Row(
                              //       children: [
                              //         Text(
                              //           selected_catelog,
                              //           style: TextStyle(
                              //               color: Colors.black,
                              //               fontSize: userMobile(context)
                              //                   ? 13.sp
                              //                   : 16.sp),
                              //         ),
                              //         const SizedBox(
                              //           width: 5,
                              //         ),
                              //         Icon(
                              //           Icons.arrow_drop_down,
                              //           color: Colors.black,
                              //           size: 15.sp,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        );
                      }),
                      Padding(
                        padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create Catalog",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      userMobile(context) ? 16.sp : 20.sp),
                            ),
                            Row(
                              children: [
                                searchClick
                                    ? Container(
                                        width: 45.w,
                                        //margin: EdgeInsets.symmetric(horizontal: 8),
                                        height: 25,
                                        child: TextField(
                                          style: TextStyle(color: Colors.white,fontSize: userMobile(context) ? 16.sp : 20.sp),
                                          controller: searchController,
                                          onChanged: (val){
                                            setState(() {
                                              if(val.trim().isNotEmpty) {
                                                tempList!.clear();
                                                tempList!.addAll(getBarCodeCatalogListModel!.getBarCodeCatalogList!.where((food) => food.toJson().toString().toLowerCase().contains(val.toLowerCase())).toList());
                                              }
                                             });
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Search here",
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: userMobile(context) ? 16.sp : 20.sp),
                                              contentPadding: const EdgeInsets.only(bottom: 8)),
                                        ))
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            searchClick = true;
                                          });
                                        },
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                          size: userMobile(context)
                                              ? 22.sp
                                              : 27.sp,
                                        ),
                                      ),
                                searchClick
                                    ? Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                      child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          searchController.clear();
                                          tempList!.clear();
                                          searchClick=false;
                                        });
                                      },
                                      child: const Icon(Icons.close,color: Colors.white,size: 18,)),
                                    )
                                    : const SizedBox(
                                        width: 10,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CatelogListScreen()));
                                      },
                                      child: Icon(
                                        Icons.list,
                                        color: Colors.white,
                                        size:
                                            userMobile(context) ? 22.sp : 27.sp,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: decorationCommon(),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 8.2,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedContact=!selectedContact;
                                // });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xff32B7C6))),
                                    child: Container(
                                      height: 14,
                                      width: 14,
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: selectedContact
                                              ? const Color(0xff32B7C6)
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: selectedContact
                                                  ? const Color(0xff32B7C6)
                                                  : Colors.transparent)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "CONTRACT",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: userMobile(context)
                                            ? 15.sp
                                            : 20.sp),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "In Stock",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          userMobile(context) ? 15.sp : 20.sp),
                                ),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: light,

                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      light = value;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),

                        dataLoading
                            ? Center(
                                child: Image.asset(
                                  "assets/images/loader.gif",
                                  height: userMobile(context) ? 50 : 80,
                                ),
                              )
                            : getBarCodeCatalogListModel == null
                                ?Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        )
                                : Expanded(
                                    child: GridView.builder(
                                      // physics: NeverScrollableScrollPhysics(),
                                      controller: scrollController,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  userMobile(context) ? 2 : 3,
                                              mainAxisSpacing:
                                                  userMobile(context) ? 2 : 4,
                                              childAspectRatio: userMobile(
                                                      context)
                                                  ? .82
                                                  : (dataTablet > 700
                                                      ? 0.55
                                                      : 0.41),
                                              
                                              crossAxisSpacing:
                                                  userMobile(context) ? 2 : 4),
                                      padding: const EdgeInsets.all(0),
                                      // padding around the grid
                                      itemCount: (searchClick && searchController.text.trim().isNotEmpty)?tempList!.length: getBarCodeCatalogListModel!
                                          .getBarCodeCatalogList!.length,
                                      // total number of items
                                      itemBuilder: (context, index) {
                                        var details =
                                        (searchClick && searchController.text.trim().isNotEmpty)?tempList![index]: getBarCodeCatalogListModel!
                                                .getBarCodeCatalogList![index];
                                        print("-----${details.stockQty}");
                                        if (light) {
                                          if (details.stockQty == 0) {
                                            return Container();
                                          } else {
                                            if(details.toJson().toString().toLowerCase().contains(searchController.text.trim().toLowerCase())){
                                              return userMobile(context)
                                                  ? gridItem(context, details)
                                                  : gridItemTab(context, details);
                                            }
                                            else
                                              {
                                                return Container();
                                              }

                                          }
                                        }
                                        if(details.toJson().toString().toLowerCase().contains(searchController.text.trim().toLowerCase())){
                                          return userMobile(context)
                                              ? gridItem(context, details)
                                              : gridItemTab(context, details);
                                        }
                                        else
                                          {
                                            return Container();
                                          }

                                      },
                                    ),
                                  ),
                        isScrolled
                            ? Center(
                                child: Image.asset(
                                  "assets/images/loader.gif",
                                  height: userMobile(context) ? 50 : 80,
                                ),
                              )
                            : Container()
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

  Widget gridItem(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) {
    print("----Stock : ${getBarCodeCatalogList.stockQty!}");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                    cont_id: getBarCodeCatalogList.contId.toString(),
                    data: getBarCodeCatalogList)));
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                          ),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: Image.network(
                                getBarCodeCatalogList.img!,
                                height: MediaQuery.of(context).size.width / 5.5,
                                width: MediaQuery.of(context).size.width / 6.5,
                                fit: BoxFit.cover,
                              ))),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(color: Color(0xFFD1C6FE)),
                        child: Text(
                          getBarCodeCatalogList.contTypeNo!,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: userMobile(context) ? 13.sp : 20.sp),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, bottom: 8, top: 3),
                    child: Column(
                      children: [
                        detailedWidget("${getBarCodeCatalogList.contId!}"),
                        detailedWidget(
                            getBarCodeCatalogList.jewelleryTypeName!),
                        detailedWidget(getBarCodeCatalogList.collection1!),
                        detailedWidget(
                            getBarCodeCatalogList.businessCategoryName!),
                        getBarCodeCatalogList.stoneDesc == null
                            ? Container()
                            : detailedWidget(
                                (getBarCodeCatalogList.stoneDesc ?? '').length >
                                        19
                                    ? getBarCodeCatalogList.stoneDesc!
                                        .substring(0, 20)
                                    : getBarCodeCatalogList.stoneDesc ?? ''),
                        detailedWidget(getBarCodeCatalogList.metalDesc!.length >
                                19
                            ? getBarCodeCatalogList.metalDesc!.substring(0, 20)
                            : getBarCodeCatalogList.metalDesc!),
                        // detailedWidget(getBarCodeCatalogList.metalDesc!),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  if (selectCatalogHelper.selected_value == "Select Catalog") {
                    setState(() {
                      selectedColumnValidate=false;
                      catalogNameValidate=false;
                    });
                    await getBarcodeCatelogNameListModel();
                    catelogNameController.clear();
                    remarksController.clear();
                    columnController.clear();
                    openDigitalCatelog(context, getBarCodeCatalogList);
                  } else {
                    submitData(context, getBarCodeCatalogList);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: const Color(0xff5338b4),
                    size: userMobile(context) ? 24.sp : 27.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var dataTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
      .size
      .shortestSide;

  Widget gridItemTab(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) {
    print("----Stock : ${getBarCodeCatalogList.stockQty!}");

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                    cont_id: getBarCodeCatalogList.contId.toString(),
                    data: getBarCodeCatalogList)));
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                          ),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: Image.network(
                                getBarCodeCatalogList.img!,
                                height: 15.h,
                                fit: BoxFit.cover,
                              ))),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(color: Color(0xFFD1C6FE)),
                        child: Text(
                          getBarCodeCatalogList.contTypeNo!,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.sp),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, bottom: 8, top: 3),
                    child: Column(
                      children: [
                        detailedWidget("${getBarCodeCatalogList.contId!}"),
                        detailedWidget(
                            getBarCodeCatalogList.jewelleryTypeName!),
                        detailedWidget(getBarCodeCatalogList.collection1!),
                        detailedWidget(
                            getBarCodeCatalogList.businessCategoryName!),
                        getBarCodeCatalogList.stoneDesc == null
                            ? Container()
                            : detailedWidget(
                                (getBarCodeCatalogList.stoneDesc ?? '').length >
                                        19
                                    ? getBarCodeCatalogList.stoneDesc!
                                        .substring(0, 20)
                                    : getBarCodeCatalogList.stoneDesc ?? ''),
                        detailedWidget(getBarCodeCatalogList.metalDesc!.length >
                                19
                            ? getBarCodeCatalogList.metalDesc!.substring(0, 20)
                            : getBarCodeCatalogList.metalDesc!),
                        // detailedWidget(getBarCodeCatalogList.metalDesc!),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  if (selectCatalogHelper.selected_value == "Select Catalog") {
                    setState(() {
                      selectedColumnValidate=false;
                      catalogNameValidate=false;
                    });
                    await getBarcodeCatelogNameListModel();
                    catelogNameController.clear();
                    remarksController.clear();
                    columnController.clear();
                    openDigitalCatelog(context, getBarCodeCatalogList);
                  } else {
                    submitData(context, getBarCodeCatalogList);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: const Color(0xff5338b4),
                    size: userMobile(context) ? 24.sp : 27.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submitData(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) async {
    showLoaderDialog(context);
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        'rfid/TA/kciSaveBarCodeScan/{"catalogId":"${selectCatalogHelper.selected_catalog_id}","catalogName":"${selectCatalogHelper.selected_value}","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"","contractNo":"${getBarCodeCatalogList.contTypeNo!.replaceAll("/", "-")}","contractId":"${getBarCodeCatalogList.contId}","userId":"${loginResponseModel.data!.first.empId}","remarks":""}');
    print("Response :  ${response.body}");
    Navigator.pop(context);
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Added Successfully ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      selectCatalogHelper.getSelectCatelogData();
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  submitFormData(BuildContext context, String url) async {
    showLoaderDialog(context);
    //LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(url);
    print("Response :  ${response.body}");
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Added Successfully ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await selectCatalogHelper.getSelectCatelogData();
      selectCatalogHelper.selected_value=selectCatalogHelper.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.last.label!;
      selectCatalogHelper.selected_catalog_id=selectCatalogHelper.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.last.value!.toString();
      selectCatalogHelper.update();
      Navigator.pop(context);
      Navigator.pop(context);

    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget detailedWidget(String name) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 3),
          child: Icon(
            Icons.circle_outlined,
            color: Colors.black,
            size: userMobile(context) ? 11.sp : 16.sp,
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Container(
         // alignment: Alignment.topLeft,
          width: userMobile(context) ? 40.w : 25.w,
          child: Text(
            name,
            style: TextStyle(
                fontSize: userMobile(context) ? 11.sp : 16.sp,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  TextEditingController catelogNameController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController columnController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(const Duration(days: 15));
  String expiry = "";

  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now().add(const Duration(days: 15)),
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

  bool selectedColumnValidate=false;
  bool catalogNameValidate=false;

  openDigitalCatelog(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) {
    selectedData.clear();
    final DateFormat formatter = DateFormat('dd-MMM-yyyy');
    expiry = formatter.format(DateTime.now().add(const Duration(days: 15)));

    showDialog<void>(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: userMobile(context)? 75.h:( dataTablet > 700?65.h:70.h),
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
                                "Digital Catalog",
                                style: TextStyle(
                                    color: const Color(0xff5338b4),
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // ignore: prefer_is_empty
                                  if(catelogNameController.text.trim().isEmpty){
                                      setState((){
                                        catalogNameValidate=true;
                                      });
                                  }
                                  else if(selectedDataContract.isEmpty){
                                    setState((){
                                      selectedColumnValidate=true;
                                    });
                                  }
                                  else
                                    {
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "Catelog Name*",
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp),
                                        textAlign: TextAlign.start,
                                      ),
                                      catalogNameValidate?  Text("    Catalog Name is required",style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w800,color: Colors.red),):Container()
                                    ],
                                  )),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    height: 30.sp,
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black.withOpacity(0.5),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: TextField(
                                      controller: catelogNameController,
                                      decoration: const InputDecoration(

                                          border: InputBorder.none),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Expiry Date",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                  textAlign: TextAlign.start,
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  _selectDate(context).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: SizedBox(
                                  height: 5.h,
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 3),
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
                                            expiry,
                                            style: TextStyle(
                                                fontSize: 13.5.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
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
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 13.sp),
                                    textAlign: TextAlign.start,
                                  )),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Container(
                                    height: 30.sp,
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black.withOpacity(0.5),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: TextField(
                                      controller: remarksController,
                                      decoration: const InputDecoration(

                                          border: InputBorder.none),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        selectedColumnValidate?  Text("     Select At-least 1 column",style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w800,color: Colors.red),):Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                height: 30.sp,
                                margin:
                                const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.5),
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 25),
                                child: TextField(
                                  controller: columnController,
                                  onChanged: (val){
                                    setState((){});
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Select Column Required',
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: dataTablet > 700?34.h:30.h,
                          child: ListView.builder(
                              itemCount: selectedContact
                                  ? selectedColumnDataContract.length
                                  : selectedColumnData.length,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8),
                              itemBuilder: (context, index) {
                                var data = selectedContact
                                    ? GetBarCodeCatalogNameList()
                                    : selectedColumnData[index];
                                var dataC = selectedContact
                                    ? selectedColumnDataContract[index]
                                    : GetCatalogReqColumn();
                                if(selectedContact? (dataC.label!.toLowerCase().contains(columnController.text.trim().toLowerCase())):data.label!.toLowerCase().contains(columnController.text.trim().toLowerCase())){
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
                                            ? const Color(0xffd1c6fe)
                                            : Colors.white)
                                            : (selectedData.contains(data)
                                            ? const Color(0xffd1c6fe)
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
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();

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
}

bool userMobile(BuildContext context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;
  return useMobileLayout;
}
