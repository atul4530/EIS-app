import 'dart:convert';

import 'package:eisapp/view/CatelogListScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:eisapp/view/vf_stage/debtor_aging_lock.dart';

import 'package:flutter/material.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../helper/SelectCatelogHelper.dart';
import '../helper/pref_data.dart';

import '../model/GetBarCodeCatelogListModel.dart';
import '../model/GetBarCodeContactColumnRequired.dart';
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

class _ScanContactState extends State<ScanContact> with BackgroundDecoration {
  bool allowMultiple = false;
  List<String> listBarcode = [];
  String result = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(selectCatalogHelper.getBarCodeCatelogNameList!=null){
      if(selectCatalogHelper.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.length>1){
        selectCatalogHelper.selected_value="Select Catalog";
        selectCatalogHelper.selected_catalog_id="Select Catalog";
        selectCatalogHelper.update();
      }
    }
  }

  SelectCatalogHelper selectCatalogHelper = Get.find();
  var dataTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;


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
                  height: MediaQuery.of(context).size.height /(userMobile(context)? 8:dataTablet>700?10:7.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<SelectCatalogHelper>(builder: (controller) {
                        return Padding(
                          padding: userMobile(context) ? EdgeInsets.all(userMobile(context) ? 8.0 : 8):EdgeInsets.symmetric(horizontal: 12,vertical: 8),
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
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: DropdownButton<
                                          GetBarCodeCatalogNameList>(
                                        underline: Container(),
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

                                        elevation: 0,
                                        icon: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Icon(
                                                Icons.arrow_drop_down_sharp)),
                                        items: controller
                                            .getBarCodeCatelogNameList==null?[]:controller
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
                        padding: userMobile(context) ? EdgeInsets.all(userMobile(context) ? 8.0 : 8):EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Scan Contact",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      userMobile(context) ? 16.sp : 22.sp),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    setState(() {

                                      if(listBarcode.isNotEmpty){
                                        openAlertBox(context);
                                      }
                                      else
                                        {
                                          allowMultiple = !allowMultiple;
                                        }

                                    });
                                  }, icon: Icon(allowMultiple?Icons.check_box:Icons.check_box_outline_blank,color: Colors.white,)),
                                  Text(
                                    "Allow Duplicate",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: userMobile(context)
                                            ? 12.sp
                                            : 17.sp),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
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
                                            userMobile(context) ? 22.sp : 25.sp,
                                      )),
                                   SizedBox(
                                    width:  userMobile(context) ?0:8,
                                  ),
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
                  decoration: decorationCommon(),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / (userMobile(context)? 8:dataTablet>700?10:7),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            listBarcode.isEmpty
                                ? Container()
                                : GestureDetector(
                                    onTap: () async {
                                      ///Save Catelog
                                      LoginResponseModel loginResponseModel =
                                          LoginResponseModel.fromJson(
                                              jsonDecode(
                                                  (await PreferenceHelper()
                                                          .getStringValuesSF(
                                                              "data"))
                                                      .toString()));

                                      if(selectCatalogHelper.selected_value=="Select Catalog"){
                                        ///Create and save catelog with contract
                                        setState(() {
                                          selectedColumnValidate=false;
                                          catalogNameValidate=false;
                                        });
                                        await getBarcodeCatelogNameListModel();
                                        catelogNameController.clear();
                                        remarksController.clear();
                                        columnController.clear();
                                        controller.clear();
                                        openDigitalCatelog(context,);
                                      }
                                      else{
                                        var url =  'rfid/TA/kciSaveBarCodeScan/{"catalogId":"${selectCatalogHelper.selected_catalog_id}","catalogName":"${selectCatalogHelper.selected_value}","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"","contractNo":"${listBarcode.toString().replaceAll("[", "").replaceAll("]", "").replaceAll("/", "-")}","contractId":"","userId":"${loginResponseModel.data!.first.empId}","remarks":""}';
                                        submitFormData(context, url,false);
                                      }


                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF562162),
                                              Color(0xFF553BDF),
                                            ],
                                            begin: FractionalOffset(1.0, 0.0),
                                            end: FractionalOffset(0.0, 0.5),
                                            stops: [
                                              0.0,
                                              1.0,
                                            ],
                                            tileMode: TileMode.mirror),
                                      ),
                                      child: Text(
                                        "SAVE AS CATALOG",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: userMobile(context)
                                                ? 12.sp
                                                : 18.sp),
                                      ),
                                    ),
                                  ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    setState(() {
                                      controller.clear();
                                      manualValidate=false;
                                    });
                                    openDialogue(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF562162),
                                            Color(0xFF553BDF),
                                          ],
                                          begin: FractionalOffset(1.0, 0.0),
                                          end: FractionalOffset(0.0, 0.5),
                                          stops: [
                                            0.0,
                                            1.0,
                                          ],
                                          tileMode: TileMode.mirror),
                                    ),
                                    child: Text(
                                      "MANUAL",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: userMobile(context)
                                              ? 12.sp
                                              : 18.sp),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SimpleBarcodeScannerPage(),
                                        ));
                                    setState(() {
                                      if (res is String) {
                                        result = res;
                                        if(result=="-1"){

                                        }
                                        else{
                                          listBarcode.add(result);
                                        }

                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF562162),
                                            Color(0xFF553BDF),
                                          ],
                                          begin: FractionalOffset(1.0, 0.0),
                                          end: FractionalOffset(0.0, 0.5),
                                          stops: [
                                            0.0,
                                            1.0,
                                          ],
                                          tileMode: TileMode.mirror),
                                    ),
                                    child: Text(
                                      "BARCODE SCAN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: userMobile(context)
                                              ? 12.sp
                                              : 18.sp),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      listBarcode.isEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Text(
                                "Scan Barcode of Contact number\n to Create Catalog",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        userMobile(context) ? 15.sp : 20.sp),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: listBarcode.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 6,
                                    margin: const EdgeInsets.only(
                                        bottom: 8, left: 8, right: 8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                          "  "+  listBarcode[index]
                                                .trim()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: userMobile(context)
                                                    ? 15.sp
                                                    : 20.sp),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                listBarcode.removeAt(index);
                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                size: 25.sp,
                                                color: const Color(0xff74219f),
                                              ))
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
        ),
      ),
    );
  }


  openAlertBox(BuildContext context){
    Dialog errorDialog = Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //this right here
      child: Container(
        height: userMobile(context)? 25.w:15.w,
        width: userMobile(context)? 95.w:75.w,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text("To change setting means scanned barcode wil be removed?",style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.w600),),
              SizedBox(height: userMobile(context)? 0:4.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL",style: TextStyle(fontSize: 15.sp,color: label_color,fontWeight: FontWeight.w600)),),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        allowMultiple = !allowMultiple;
                        listBarcode.clear();

                      });
                        Navigator.pop(context);


                    },
                    child: Text("OK",style: TextStyle(fontSize: 15.sp,color: label_color,fontWeight: FontWeight.w600)),),
                  SizedBox(width: 10,),
                ],
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }



  submitFormData(BuildContext context, String url,bool fromDigital) async {
    showLoaderDialog(context);
    //LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(url);
    print("Response :  ${response.body}");
    //Navigator.pop(context);


    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Barcode Added Successfully in ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await selectCatalogHelper.getSelectCatelogData();
      if(fromDigital){
        print("----Now Created and Selected is ${selectCatalogHelper.selected_value}");
        selectCatalogHelper.selected_value=selectCatalogHelper.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.last.label!;
        selectCatalogHelper.selected_catalog_id=selectCatalogHelper.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.last.value!.toString();
        print("=====Now Updation and Selected is ${selectCatalogHelper.selected_value}");
        selectCatalogHelper.update();
      }
     // selectCatalogHelper.selected_value=catelogNameController.text.trim();
      selectCatalogHelper.update();
      listBarcode.clear();
      if(fromDigital){
        Navigator.pop(context);
      }
      Navigator.pop(context);
      setState(() {

      });

    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  TextEditingController controller = TextEditingController();
  bool manualValidate = false;


  openDialogue(BuildContext context) {

    showDialog<void>(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: (userMobile(context) ? manualValidate?80.w: 75.w : dataTablet>700?(manualValidate?58.w:55.w): (manualValidate?65.w: 60.w)),
              width: 85.w,
              color: Colors.white,
              child: Padding(
                padding:  EdgeInsets.all(userMobile(context) ?8.0:15),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Manual Entry",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: userMobile(context) ? 18.sp : 24.sp),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                size: 25.sp,
                              ))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),child: Row(
                      children: [
                        manualValidate?  Text("Enter Valid Data",style: TextStyle(color: Colors.red,fontSize: userMobile(context)?13.sp: 16.sp),):Container(),
                      ],
                    ),),
                    Container(
                      height: userMobile(context)?40.w: 30.w,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color(0xffdcdcdc), width: 2)),
                      child: TextField(
                        controller: controller,
                        maxLines: null,
                        expands: true,
                        style: TextStyle(fontSize: userMobile(context)?15.sp:22.sp),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10,right: 10,top: 4),
                            border: InputBorder.none, fillColor: Colors.transparent),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(controller.text.trim().isEmpty){
                                setState(() {
                                  manualValidate=true;
                                });
                            //    Get.snackbar("Error!!", "Enter Valid Data",colorText: label_color,backgroundColor: Colors.white);
                              }
                              else
                              {

                                if(checkValidation() ?? false){
                                  print("List----${controller.text.trim().split("\n")}");
                                  if(allowMultiple){
                                    listBarcode
                                        .addAll(controller.text.trim().split("\n").toList());
                                  }
                                  else
                                  {
                                    listBarcode
                                        .addAll(controller.text.trim().split("\n").toList().toSet().toList());
                                    listBarcode=listBarcode.toSet().toList();
                                  }
                                  controller.clear();
                                  Navigator.pop(context);
                                  setState(() {});
                                }
                                else
                                {
                                  setState(() {
                                    manualValidate=true;
                                  });
                               //   var snackBar = const SnackBar(content: Text('Please enter valid Contract no'));
                                //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }


                              }

                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: userMobile(context) ? 16.sp : 25.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        })).then((value) {
      //   Navigator.pop(context);
    });
  }

  ///Create Catelog
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
          selectedDate=picked;
          final DateFormat formatter = DateFormat('dd-MMM-yyyy');
          final String formatted = formatter.format(selectedDate);
          expiry = formatted;

          print("DATA\n\n\n\n\n\n ${formatted}");
        });

        setState(() {

        });
      }
    });
  }


  bool selectedColumnValidate=false;
  bool catalogNameValidate=false;

  openDigitalCatelog(
      BuildContext context) {
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
              height: 75.h,
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
                                    'rfid/TA/kciSaveBarCodeScan/{"catalogId":"-1","catalogName":"${catelogNameController.text.trim()}","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"${columnData.toString().replaceAll("[", "").replaceAll("]", "")}","contractNo":"${listBarcode.toString().replaceAll("[", "").replaceAll("]", "").replaceAll("/", "-")}","contractId":"","userId":"${await loginResponseModel.data!.first.empId}","remarks":"${remarksController.text.trim()}","expirydate":"$expiry"}';
                                submitFormData(context, url,true);
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
                                  contentPadding: EdgeInsets.only(left: 12,bottom: 15),
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
                                  contentPadding: EdgeInsets.only(left: 12,bottom: 15),
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    selectedColumnValidate?  Text("     Select atleast 11column",style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w800,color: Colors.red),):Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30.sp,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                                width: 0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: columnController,
                          onChanged: (val){
                            setState((){});
                          },
                          decoration: const InputDecoration(
                              hintText: 'Select Column Required',
                              contentPadding: EdgeInsets.only(left: 12,bottom: 10),

                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
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
                                        ? Color(0xffd1c6fe)
                                        : Colors.white)
                                        : (selectedData.contains(data)
                                        ? Color(0xffd1c6fe)
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


  bool selectedContact=true;
  List<GetBarCodeCatalogNameList> selectedColumnData = [];
  List<GetCatalogReqColumn> selectedColumnDataContract = [];
  List<GetBarCodeCatalogNameList> selectedData = [];
  List<GetCatalogReqColumn> selectedDataContract = [];

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

  submitCatalogData(BuildContext context, String url) async {
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
      selectCatalogHelper.getBarCodeCatelogNameList = GetBarCodeCatelogNameListModel(getBarCodeCatalogNameList: [GetBarCodeCatalogNameList(label: (jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"],value: int.parse((jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_id"].toString()))]);
      selectCatalogHelper.update();
      await selectCatalogHelper.getSelectCatelogData();
      selectCatalogHelper.selected_value=selectCatalogHelper.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.last.label!;
      selectCatalogHelper.selected_catalog_id=selectCatalogHelper.getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.last.value!.toString();
      selectCatalogHelper.update();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }




  bool? checkValidation() {

    for(int i=0;i<controller.text.trim().split("\n").toList().length;i++){
      if(controller.text.trim().split("\n").toList()[i].contains("/")){
        String s = controller.text.trim().split("\n").toList()[i].split("/").last;
        if(s.trim().length!=6){
          var snackBar = const SnackBar(content: Text('Please enter Contract no'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
        else
          {
            if(i==controller.text.trim().split("\n").toList().length-1){
              return true;
            }
            else
              {
               i=i;
              }
          }
      }
      else
        {
          return false;
        }
    }

  }
}
