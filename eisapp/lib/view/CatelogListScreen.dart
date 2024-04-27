import 'dart:convert';
import 'dart:io';

import 'package:eisapp/model/ShareModel.dart';
import 'package:eisapp/view/loader/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';


import '../helper/SelectCatelogHelper.dart';
import '../helper/pref_data.dart';
import '../model/GetBarCodeContactColumnRequired.dart';

import '../model/GetBarcodeCatelogListNameModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';
import '../network/api_consts.dart';
import 'CreateCatelog.dart';
import 'SingleCatelogScreen.dart';
import 'design_consts/DecorationMixin.dart';
import 'download_progress_dialog.dart';


class CatelogListScreen extends StatefulWidget {
  const CatelogListScreen({super.key});

  @override
  State<CatelogListScreen> createState() => _CatelogListScreenState();
}

class _CatelogListScreenState extends State<CatelogListScreen>  with BackgroundDecoration {


  bool dataLoading=true;
  GetBarCodeCatelogNameListModel? getBarCodeCatelogNameList;

  SelectCatalogHelper selectCatalogHelper = Get.find();

  getSelectCatelogData() async {
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    setState(() {
      dataLoading=true;
    });
    var response = await ApiService.getData("rfid/TA/result/getBarCodeCatalogNameList/-1/${loginResponseModel.data!.first.cscId!}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    getBarCodeCatelogNameList = GetBarCodeCatelogNameListModel.fromJson(jsonDecode(response.body));
    setState(() {
      dataLoading=false;
      selectCatalogHelper.getSelectCatelogData();
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectCatelogData();
    setPermission();
  }

  setPermission() async {
    _permissionRequest();
  }

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
                height: MediaQuery.of(context).size.height /(userMobile(context)? 10:7.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:  Icon(Icons.arrow_back,color: Colors.white,size:  userMobile(context)?22.sp:27.sp,)),

                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Catelog List",style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?16.sp:22.sp,fontWeight: FontWeight.w600),),
                          Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: decorationCommon(),
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/(userMobile(context)?4: 6),
                width: MediaQuery.of(context).size.width,
                child: dataLoading?Center(child:  Image.asset("assets/images/loader.gif",height:userMobile(context)?50:80,),):Column(
                  children: [
                    SizedBox(height: 10,),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/(userMobile(context)?4: 6))-10,
                      child: ListView.builder(
                        itemCount: getBarCodeCatelogNameList!.getBarCodeCatalogNameList!.length,
                        padding: const EdgeInsets.only(top: 20),
                        itemBuilder: (BuildContext context, int index) {
                          var data = getBarCodeCatelogNameList!.getBarCodeCatalogNameList![index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleCatelogScreen(catelog: data,))).then((value) {
                                getSelectCatelogData();
                              });
                            },
                            child: Card(
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
                                    Text("   "+data.label!,style: TextStyle(color: Colors.black,fontSize: userMobile(context)? 15.sp:20.sp,fontWeight: FontWeight.w600),),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            controller.clear();
                                            controller.text = data.label!.split(" ").first;

                                            openUpdateCatelog(context,data);
                                          },
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 2.5.sp),
                                            child: Icon(Icons.edit_note_sharp,color: const Color(0xff5f1e80),size: userMobile(context)?20.sp:30.sp,),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            shareDetails(context,data);
                                           // Share.share('check out my website https://example.com', subject: 'Look what I made!');
                                          },
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 5.sp),
                                            child: Icon(Icons.share,color: const Color(0xff5f1e80),size:  userMobile(context)?20.sp:30.sp,),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap:(){
                                            printCatelog(context,data);
                                           },
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 5.sp),
                                            child: Text("Print",style: TextStyle(color: const Color(0xff5f1e80),fontSize: userMobile(context)? 15.sp:18.sp,fontWeight: FontWeight.w800),),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),),
    );
  }

  TextEditingController controller = TextEditingController();
  List gender=["PDF","Excel"];
  String? select="PDF";
  
  shareDetails(BuildContext context,GetBarCodeCatalogNameList getCatalogReqColumn){
    showLoaderDialog(context);
    ApiService.getData("rfid/TA/result/getBarCodeCatalogShare/-1/-1/-1/-1/${getCatalogReqColumn.value}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1").then((value){
      if(value.statusCode==200){
          ShareModel shareModel = ShareModel.fromJson(jsonDecode(value.body));
          print("Data : ${shareModel.toJson()}");
          Navigator.pop(context);
          Share.share(shareModel.getBarCodeCatalogShare!.first.msg!);
      }
    });
  }

  openUpdateCatelog(BuildContext context,GetBarCodeCatalogNameList getCatalogReqColumn){

    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), //this right here
      child: Container(
        height: 42.w,
        width: 85.w,
        color: Colors.white,

        child: Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Update Catelog Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18.sp),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,size: 25.sp,))
                ],
              ),
            ),
            Container(
              height: 12.w,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Color(0xffdcdcdc),width: 2)
              ),
              child: TextField(
                controller: controller,
                maxLines: 2,
                style: TextStyle(fontSize: 20.sp),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 12,top: 5),
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
                      if(controller.text.trim().length>0){
                        print("List----${controller.text.trim().split("\n")}");
                        Navigator.pop(context);
                        updateCatelogName(getCatalogReqColumn.value!.toString(), controller.text.trim());
                      }
                       },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600),),
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



  updateCatelogName(String id, String name) async {
    setState(() {
      dataLoading = true;
    });
     var response = await ApiService.getData(
        'rfid/TA/kciUpdateCatalogName/{"catalogId":"$id","catalogName":"$name"}');
    print("----Response  : ${response.body}");
    getSelectCatelogData();
  }


  printCatelog(BuildContext context,GetBarCodeCatalogNameList getBarCodeCatalogNameList){


    showDialog(context: context, builder: (BuildContext context) { 
      return StatefulBuilder(
          builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), //this right here
            child: Container(
              height: 55.w,
              width: 85.w,
              color: Colors.white,

              child: Column(

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Report Format",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close,size: 25.sp,))
                      ],
                    ),
                  ),
                  Container(
                    height: 8.w,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${getBarCodeCatalogNameList.label}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_drop_down_outlined,size: 22.sp,color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                  Text("Output",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            activeColor: const Color(0xff5f1e80),

                            value: gender[0],
                            groupValue: select,
                            onChanged: (value){
                              setState(() {
                                print(value);
                                select=value;
                              });
                            },
                          ),
                          const Text("PDF")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            activeColor: const Color(0xff5f1e80),

                            value: gender[1],
                            groupValue: select,
                            onChanged: (value){
                              setState(() {
                                print(value);
                                select=value;
                              });
                            },
                          ),
                          const Text("Excel")
                        ],
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));

                          if(select=="PDF"){
                            showDialog(
                                context: context,
                                builder: (dialogcontext) {
                                  return DownloadProgressDialog(url: "http://10.20.1.41:2910/kgk/report/wsrprintapi.htm?reportName=PrestoBarcodeScan.jasper&digitalCatalogueId=${getBarCodeCatalogNameList.value.toString()}&cscId=${loginResponseModel.data!.first.cscId}&reporttype=pdf",pdf: true,);
                                });
                          }
                          else
                            {
                              showDialog(
                                  context: context,
                                  builder: (dialogcontext) {
                                    print("http://10.20.1.41:2910/kgk/report/wsrprintapi.htm?reportName=PrestoBarcodeScan.jasper&digitalCatalogueId=${getBarCodeCatalogNameList.value.toString()}&cscId=${loginResponseModel.data!.first.cscId}&reporttype=xls");
                                    return DownloadProgressDialog(url: "http://10.20.1.41:2910/kgk/report/wsrprintapi.htm?reportName=PrestoBarcodeScan.jasper&digitalCatalogueId=${getBarCodeCatalogNameList.value.toString()}&cscId=${loginResponseModel.data!.first.cscId}&reporttype=xlsx",pdf: false,);
                                  });
                            }

                          // bool result = await _permissionRequest();
                          // if (result) {
                          //   showDialog(
                          //       context: context,
                          //       builder: (dialogcontext) {
                          //         return DownloadProgressDialog();
                          //       });
                          // } else {
                          //   print("No permission to read and write.");
                          // }

                          //downloadPdf(context,getBarCodeCatalogNameList.value.toString());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xff5f1e80),width: 1)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 4),
                          alignment: Alignment.center,
                          child: Text("Print",style: TextStyle(fontSize: 12.sp,color:  const Color(0xff5f1e80),fontWeight: FontWeight.w500),),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xff6b6666),width: 1)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40,vertical:4),
                          alignment: Alignment.center,
                          child: Text("Cancel",style: TextStyle(fontSize: 12.sp,color:  const Color(0xff6b6666),fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        }
      );
    });}


  static Future<bool> _permissionRequest() async {
    PermissionStatus result;
    result = await Permission.storage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  downloadPdf(BuildContext context,String id) async {


    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    print("Url : ");
    print("http://10.20.1.41:2910/kgk/report/wsrprintapi.htm?reportName=PrestoBarcodeScan.jasper&digitalCatalogueId=$id&cscId=${loginResponseModel.data!.first.cscId}&reporttype=pdf");
    final taskId = await FlutterDownloader.enqueue(
      url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      headers: {},fileName: "abc.pdf",
      savedDir: '/storage/emulated/0/Download/',
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    print("Task iD $taskId");
    //
    // var file = File('');
    //
    // // Platform.isIOS comes from dart:io
    // if (Platform.isIOS) {
    //   final dir = await getApplicationDocumentsDirectory();
    //   //file = File('${dir.path}/$fileName');
    // }
    // if (Platform.isAndroid) {
    //   var status = await Permission.storage.status;
    //   if (status != PermissionStatus.granted) {
    //     status = await Permission.storage.request();
    //   }
    //   if (status.isGranted) {
    //     const downloadsFolderPath = '/storage/emulated/0/Download/';
    //     Directory dir = Directory(downloadsFolderPath);
    //    // file = File('${dir.path}/$fileName');
    //   }
    // }
  }
  
  }


