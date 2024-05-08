import 'dart:convert';

import 'package:eisapp/model/GetCtelogListByIdModel.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:eisapp/view/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../helper/pref_data.dart';
import '../model/GetBarcodeCatelogListNameModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';
import 'CreateCatelog.dart';

class SingleCatelogScreen extends StatefulWidget {
  final GetBarCodeCatalogNameList catelog;

  SingleCatelogScreen({super.key, required this.catelog});

  @override
  State<SingleCatelogScreen> createState() => _SingleCatelogScreenState();
}

class _SingleCatelogScreenState extends State<SingleCatelogScreen>
    with BackgroundDecoration {
  bool dataLoading = true;
  GetCatelogListModelById? getCatelogListModelById;

  getBarcodeCatelogListData() async {
    setState(() {
      dataLoading = true;
    });
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        'rfid/TA/getBarCodeCatalogListById/{"catalogId":"${widget.catelog.value}","catalogDetId":"-1"}');
    print("Response  : ${response.body}");
    GetCatelogListModelById data =
        GetCatelogListModelById.fromJson(jsonDecode(response.body));
    if (data.result ?? false) {
      setState(() {
        getCatelogListModelById = data;
        dataLoading = false;
      });
    } else {
      setState(() {
        dataLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBarcodeCatelogListData();
  }

  var dataTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgDecoration(),
          child: Column(
            children: [
              SizedBox(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height /(userMobile(context)? 10:(dataTablet>700?10:7.8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(userMobile(context) ? 8.0 : 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: userMobile(context) ? 22.sp : 27.sp,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: userMobile(context)?EdgeInsets.all(userMobile(context) ? 8.0 : 12):EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.catelog.label!.split("(").first,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    userMobile(context) ? 16.sp : 25.sp),
                          ),
                          Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
             Container(
                decoration: decorationCommon(),
               //height: MediaQuery.of(context).size.height- MediaQuery.of(context).size.height /(userMobile(context)? 10:dataTablet>700?10:9),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / (userMobile(context)? 8:(dataTablet>700? 10:6.4)),
                width: MediaQuery.of(context).size.width,
                child:   dataLoading? Center(child:  Image.asset("assets/images/loader.gif",height:userMobile(context)?50:80,),):getCatelogListModelById==null?Center(child: Text("No Data Found"),): getCatelogListModelById!.getBarCodeCatalogListById!.isEmpty?Center(child: Text("No Data Found"),): Container(
                  margin: EdgeInsets.only(top: userMobile(context)? 20:5),
                  child: GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: userMobile(context) ? 2 :3,
                        mainAxisSpacing:
                        userMobile(context) ? 2 : 10,
                        childAspectRatio:
                        userMobile(context) ? .82 :(dataTablet>700?0.55: 0.41),
                        crossAxisSpacing:
                        userMobile(context) ? 2 : 10),
                    padding: const EdgeInsets.only(top: 30, left: 4, right: 4,bottom: 30),
                    // padding around the grid
                    itemCount: getCatelogListModelById!.getBarCodeCatalogListById!.length,
                    // total number of items
                    itemBuilder: (context, index) {
                      var data = getCatelogListModelById!.getBarCodeCatalogListById![index];
                      return userMobile(context)? gridItem(context,data):gridItemTab(context, data);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget gridItemTab(
      BuildContext context, GetBarCodeCatalogListById getBarCodeCatalogList) {
   // print("----Stock : ${getBarCodeCatalogList.stockQty!}");
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ProductDetailsScreen(
        //             cont_id: getBarCodeCatalogList.contId.toString(),
        //             data:getBarCodeCatalogList)));
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
                        decoration: BoxDecoration(
                            color:Color(0xFFD1C6FE)),
                        child: Text(
                          getBarCodeCatalogList.contTypeNo!,
                          style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 18.sp),
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
                        getBarCodeCatalogList.stoneDesc ==null?Container(): detailedWidget((getBarCodeCatalogList.stoneDesc ?? '').length >
                            19
                            ? getBarCodeCatalogList.stoneDesc!.substring(0, 20)
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
                onTap: () {
                  //openDigitalCatelog(context);
                  deleteData(context,getBarCodeCatalogList);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete,
                    color: const Color(0xffc93828),
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

  Widget gridItem(
      BuildContext context, GetBarCodeCatalogListById getBarCodeCatalogList) {
  //  print("----Stock : ${getBarCodeCatalogList.stockQty!}");
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ProductDetailsScreen(
        //             cont_id: getBarCodeCatalogList.contId.toString(),
        //             data:getBarCodeCatalogList)));
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
                        decoration: BoxDecoration(
                            color:Color(0xFFD1C6FE)),
                        child: Text(
                          getBarCodeCatalogList.contTypeNo!,
                          style: TextStyle(fontWeight: FontWeight.w600,
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
                        getBarCodeCatalogList.stoneDesc ==null?Container(): detailedWidget((getBarCodeCatalogList.stoneDesc ?? '').length >
                            19
                            ? getBarCodeCatalogList.stoneDesc!.substring(0, 20)
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
                onTap: () {
                  //openDigitalCatelog(context);
                  deleteData(context,getBarCodeCatalogList);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete,
                    color: const Color(0xffc93828),
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


  deleteData(BuildContext context,GetBarCodeCatalogListById getBarCodeCatalogListById) async {
    showLoaderDialog(context);
    var response = await get(Uri.parse('http://10.20.1.41:2910/kgkapi/rfid/TA/getBarCodeCatalogListById/{"catalogId":"-1","catalogDetId":"${getBarCodeCatalogListById.digitalCatalogueDetId}"}'));
    print("Response  : ${response.body}");
    Navigator.pop(context);
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Deleted Successfully"),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      getBarcodeCatelogListData();
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
        Icon(
          Icons.circle_outlined,
          color: Colors.black,
          size:userMobile(context)? 12:16,
        ),
        const SizedBox(
          width: 3,
        ),
        SizedBox(
          width: userMobile(context) ?40.w:25.w,
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
}
