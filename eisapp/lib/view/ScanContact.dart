
import 'dart:convert';

import 'package:eisapp/view/CatelogListScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';

import 'package:flutter/material.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../helper/SelectCatelogHelper.dart';
import '../helper/pref_data.dart';

import '../model/GetBarcodeCatelogListNameModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';
import 'CreateCatelog.dart';
import 'loader/loader.dart';

class ScanContact extends StatefulWidget {
  const ScanContact({super.key});

  @override
  State<ScanContact> createState() => _ScanContactState();
}

class _ScanContactState extends State<ScanContact>  with BackgroundDecoration {
  bool allowMultiple =false;
  List<String> listBarcode = [

  ];
  String result = "";
  String selected_catelog = "Select Catalog";
  String selected_catelog_id = "Select Catalog";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getSelectCatelogData();
  }

  SelectCatalogHelper selectCatalogHelper = Get.put(SelectCatalogHelper());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(body: Container(
        decoration: bgDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height/7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<SelectCatalogHelper>(
                        builder: (controller) {
                          return Padding(
                            padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
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
                                controller.catalog_loading?Center(child:  Image.asset("assets/images/loader.gif",height:userMobile(context)?50:80,),):    Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  height: 30,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: DropdownButton<GetBarCodeCatalogNameList>(
                                    hint: Text(controller.selected_value,style: TextStyle(color: Colors.black,fontSize: userMobile(context)?12.sp:16.sp),),
                                    borderRadius: BorderRadius.circular(12),
                                    padding: EdgeInsets.zero,
                                    elevation: 0,
                                    icon: Container(margin: EdgeInsets.only(left: 10),child: Icon(Icons.arrow_drop_down_sharp)),
                                    items: controller.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.map((GetBarCodeCatalogNameList value) {
                                      return DropdownMenuItem<GetBarCodeCatalogNameList>(
                                        value: value,
                                        child: Text(value.label!),
                                      );
                                    }).toList(),
                                    onChanged: (_) {
                                      controller.selected_value = _!.label ?? '';
                                      controller.selected_catalog_id = _.value.toString();
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
                        }
                    ),
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Scan Contact",style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?16.sp:22.sp),),
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: const Color(0xff5F1E80FF),
                                  activeColor: const Color(0xffFFFFFF),
                                  focusColor: Colors.black,
                                  side: const BorderSide(color: Colors.white),
                                  value: allowMultiple,
                                  splashRadius: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      allowMultiple = value!;
                                    });
                                  },
                                ),
                                Text("Allow Duplicate",style: TextStyle(color: Colors.white,fontSize:userMobile(context)? 12.sp:16.sp),),
                                const SizedBox(width: 8,),
                                GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const CatelogListScreen()));
                                    },
                                    child: Icon(Icons.list,color: Colors.white,size: userMobile(context)? 22.sp:25.sp,))

                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFF9F9AAF).withOpacity(0.7),
                          const Color(0xFFFFFFFF),
                        ],

                        begin:  const FractionalOffset(0.0, 0.0),
                        end:  const FractionalOffset(0.0, 0.9),
                        stops: const [0.0, 0.35,],
                        tileMode: TileMode.clamp),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight:  Radius.circular(20))
                ),
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/8,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          listBarcode.isEmpty?Container():   GestureDetector(
                            onTap: () async {
                                ///Save Catelog
                              LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));

                                var url = 'rfid/TA/kciSaveBarCodeScan/{"catalogId":"$selected_catelog_id","catalogName":"$selected_catelog","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"","contractNo":"${listBarcode.toString().replaceAll("[", "").replaceAll("]", "")}","contractId":"","userId":"${loginResponseModel.data!.first.empId}","remarks":""}';
                              submitFormData(context,url);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF562162),
                                      Color(0xFF553BDF),
                                    ],

                                    begin:  FractionalOffset(1.0, 0.0),
                                    end:  FractionalOffset(0.0, 0.5),
                                    stops: [0.0, 1.0,],
                                    tileMode: TileMode.mirror),
                              ),
                              child: Text("SAVE AS CATELOG",style: TextStyle(color: Colors.white,fontSize:userMobile(context)?  12.sp:18.sp),),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                    openDialogue(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF562162),
                                          Color(0xFF553BDF),
                                        ],

                                        begin:  FractionalOffset(1.0, 0.0),
                                        end:  FractionalOffset(0.0, 0.5),
                                        stops: [0.0, 1.0,],
                                        tileMode: TileMode.mirror),
                                  ),
                                  child: Text("MANUAL",style: TextStyle(color: Colors.white,fontSize: userMobile(context)?  12.sp:18.sp),),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              GestureDetector(
                                onTap: () async {
                                  var res = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SimpleBarcodeScannerPage(),
                                      ));
                                  setState(() {
                                    if (res is String) {
                                      result = res;
                                      listBarcode.add(result);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF562162),
                                          Color(0xFF553BDF),
                                        ],

                                        begin:  FractionalOffset(1.0, 0.0),
                                        end:  FractionalOffset(0.0, 0.5),
                                        stops: [0.0, 1.0,],
                                        tileMode: TileMode.mirror),
                                  ),
                                  child: Text("BARCODE SCAN",style: TextStyle(color: Colors.white,fontSize:userMobile(context)?  12.sp:18.sp),),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    listBarcode.isEmpty? Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text("Scan Barcode of Contact number\n to Create Catalog",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  15.sp:20.sp),),):  Expanded(
                      child: ListView.builder(
                        itemCount: listBarcode.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 6,
                            margin: const EdgeInsets.only(bottom: 8,left: 8,right: 8),

                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(listBarcode[index].trim().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: userMobile(context)?  15.sp:20.sp),),
                                  GestureDetector(
                                      onTap: (){
                                        listBarcode.removeAt(index);
                                        setState(() {

                                        });
                                      },
                                      child: Icon(Icons.delete,size: 25.sp,color: const Color( 0xff74219f),))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )

                  ],
                ),
              )

            ],
          ),
        ),
      ),),
    );
  }

  submitFormData(BuildContext context, String url) async {
    showLoaderDialog(context);
    //LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(url);
    print("Response :  ${response.body}");
    //Navigator.pop(context);
    Navigator.pop(context);
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Barcode Added Successfully in ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  TextEditingController controller = TextEditingController();

  openDialogue(BuildContext context){
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), //this right here
      child: Container(
        height: userMobile(context)?  75.w:60.w,
        width: 85.w,

        child: Column(

          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Manual Entry",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: userMobile(context)? 18.sp:24.sp),),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close,size: 25.sp,))
                    ],
                  ),
                ),
      Container(
        height: 40.w,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
        ),
        child: TextField(
          controller: controller,
          maxLines: null,
          expands: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.transparent
          ),
          keyboardType: TextInputType.multiline,
        ),
      ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      print("List----${controller.text.trim().split("\n")}");
                      listBarcode.addAll(controller.text.trim().split("\n").toList());
                      controller.clear();
                      Navigator.pop(context);
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text("ADD",style: TextStyle(color: Colors.white,fontSize: userMobile(context)?  16.sp:25.sp),),
                    ),
                  ),
                ],
              ),
            )
            ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);}


  GetBarCodeCatelogNameListModel? getBarCodeCatelogNameList;

  openOptions(BuildContext context){
    //selectedData.clear();
    showDialog<void>(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 50.h,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 5.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.close,color: Colors.red,),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: (){

                            setState(() {
                              selected_catelog="Select Catelog";
                              selected_catelog_id="Select Catelog";
                              Navigator.pop(context);
                            });

                          },
                          child: SizedBox(
                            height: 5.h,
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
                              color:Colors.white,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  height: 30.sp,
                                  width: 100.w,
                                  //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                  alignment: Alignment.centerLeft,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Select Catelog",style: TextStyle(fontSize: 13.5.sp,color: Colors.black.withOpacity(0.5)),),
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
                            itemCount: getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.length,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            itemBuilder: (context,index){

                              var dataC = getBarCodeCatelogNameList!.getBarCodeCatalogNameList![index];
                              return GestureDetector(
                                onTap: (){

                                  setState(() {
                                    selected_catelog=dataC.label!;
                                    selected_catelog_id=dataC.value!.toString();
                                    Navigator.pop(context);
                                  });
                                },
                                child: SizedBox(
                                  height: 5.h,
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
                                    color:Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        height: 30.sp,
                                        width: 100.w,
                                        alignment: Alignment.centerLeft,
                                        child:  Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(dataC.label!,style: TextStyle(fontSize: 13.5.sp,color: Colors.black.withOpacity(0.5)),),
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
            }
        )).then((value) {
      setState(() {

      });
    });
  }

  getSelectCatelogData() async {
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    showLoaderDialog(context);
    var response = await ApiService.getData("rfid/TA/result/getBarCodeCatalogNameList/-1/${loginResponseModel.data!.first.cscId!}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    getBarCodeCatelogNameList = GetBarCodeCatelogNameListModel.fromJson(jsonDecode(response.body));
    if(getBarCodeCatelogNameList==null){
      Navigator.pop(context);
    }
    else
      {
        if(getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.isNotEmpty){
          selected_catelog= getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.first.label!;
          selected_catelog_id=getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.first.value!.toString();
          Navigator.pop(context);
          setState(() {

          });
        }
      }



  }

  }

