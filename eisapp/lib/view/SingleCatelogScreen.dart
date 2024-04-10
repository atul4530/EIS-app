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
        'rfid/TA/getBarCodeCatalogListById/{"catalogId":"${widget.catelog.value}","catalogDetId":"${widget.catelog.catCount}"}');
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height / 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
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
                        padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.catelog.label!,
                              style: TextStyle(
                                  color: Colors.white,
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
                dataLoading?const Center(child: CircularProgressIndicator(),):   Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFF9F9AAF).withOpacity(0.7),
                            const Color(0xFFFFFFFF),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 0.9),
                          stops: const [
                            0.0,
                            0.35,
                          ],
                          tileMode: TileMode.clamp),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 5.8,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: userMobile(context) ? 2 : 10,
                        childAspectRatio: userMobile(context) ? .84 : 1,
                        crossAxisSpacing: userMobile(context) ? 2 : 10),
                    padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
                    // padding around the grid
                    itemCount: getCatelogListModelById!.getBarCodeCatalogListById!.length,
                    // total number of items
                    itemBuilder: (context, index) {
                      var data = getCatelogListModelById!.getBarCodeCatalogListById![index];
                      return gridItem(context,data);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridItem(BuildContext context,GetBarCodeCatalogListById getBarCodeCatalogListById) {
    return GestureDetector(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen()));
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
                                getBarCodeCatalogListById.img ?? '',
                                height: MediaQuery.of(context).size.width / 5.5,
                                width: MediaQuery.of(context).size.width / 6.5,
                                fit: BoxFit.cover,
                              ))),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: const Color(0xff8953a8).withOpacity(0.5)),
                        child: Text(
                          getBarCodeCatalogListById.contTypeNo!,
                          style: TextStyle(
                              fontSize: userMobile(context) ? 13.sp : 18.sp),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, bottom: 8, top: 3),
                    child: Column(
                      children: [
                        detailedWidget("${getBarCodeCatalogListById.contId!}"),
                        detailedWidget(getBarCodeCatalogListById.jewelleryTypeName!),
                        detailedWidget(getBarCodeCatalogListById.collection1!),
                        detailedWidget(getBarCodeCatalogListById.businessCategoryName!),
                        detailedWidget(getBarCodeCatalogListById.stoneDesc!.length>19?getBarCodeCatalogListById.stoneDesc!.substring(0,20):getBarCodeCatalogListById.stoneDesc!),
                        detailedWidget(getBarCodeCatalogListById.metalDesc!),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  //openDigitalCatelog(context);
                  deleteData(context,getBarCodeCatalogListById);
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
    var response = await delete(Uri.parse('http://10.20.1.41:2910/kgkapi/rfid/TA/getBarCodeCatalogListById/{"catalogId":"${widget.catelog.value}","catalogDetId":"${widget.catelog.catCount}"}'));
    print("Response  : ${response.body}");

  }

  Widget detailedWidget(String name) {
    return Row(
      children: [
        const Icon(
          Icons.circle_outlined,
          color: Colors.black,
          size: 12,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          name,
          style: TextStyle(
              fontSize: userMobile(context) ? 11.sp : 18.sp,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
