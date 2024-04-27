import 'dart:convert';

import 'package:eisapp/model/DebtorAgeignLockModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../helper/ApproveLoaderHelper.dart';
import '../../model/GetVfStageDetaulsModel.dart' as r;
import '../CreateCatelog.dart';
import '../design_consts/DecorationMixin.dart';
import 'details_call.dart';
import 'package:get/get.dart' as getter;

class DebtorAgingLock extends StatefulWidget{
  r.Result result;
  DebtorAgingLock({super.key,required this.result});

  @override
  State<DebtorAgingLock> createState() => _DebtorAgingLockState();
}

class _DebtorAgingLockState extends State<DebtorAgingLock>  with BackgroundDecoration {
  bool dataLoading = false;
  DebtorAgeignLockModel? debtorAgeignLockModel;

  ApproveoaderHelper approveoaderHelper = getter.Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debtor_aging_lock_call(context);
  }

  debtor_aging_lock_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
      approveoaderHelper.approveLoading=true;
      approveoaderHelper.update();
    });
    Response response = await details_call("api/a/sql/get_vf_approve_debtor_ageing_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      setState(() {
        debtorAgeignLockModel = DebtorAgeignLockModel.fromJson(jsonDecode(response.body));
        dataLoading=false;
        if(debtorAgeignLockModel!.result!.isNotEmpty){
          approveoaderHelper.approveLoading=false;
          approveoaderHelper.update();
        }
      });
    }
    else
    {
      setState(() {
        dataLoading=false;
        approveoaderHelper.approveLoading=true;
        approveoaderHelper.update();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double font_Size = userMobile(context) ? 18.sp : 22.sp;
    print("-> PO Type $dataLoading");
    if(dataLoading){
      return loader_center(context);
    }
    return debtorAgeignLockModel!.result!.isEmpty?Container(child: Center(child: Text("No Data Available",style: TextStyle(fontSize: font_Size),),),): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${debtorAgeignLockModel!.result!.first.invNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("Invoice NO", "${debtorAgeignLockModel!.result!.first.invNo ?? '-'}",context),
            detailsLabeling("Invoice Date", debtorAgeignLockModel!.result!.first.invDt?? '-',context),
            detailsLabeling("Currency Code", debtorAgeignLockModel!.result!.first.curCode?? '-',context),
            detailsLabeling("Party Name", debtorAgeignLockModel!.result!.first.partyName?? '-',context),
            SizedBox(height: 10,),
            ListView.builder(
                itemCount: debtorAgeignLockModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,debtorAgeignLockModel!.result![index]);
                }),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }

  Widget orderCard(BuildContext context,Result result){
    double font_Size = userMobile(context) ? 15.sp : 19.sp;
    return Card(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Total Due :${result.totalDue}",style: TextStyle(color:label_color,fontSize: font_Size,fontWeight: FontWeight.w600),),
                     ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28.w,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1,color: Color(0xff9DA5BC)),
                              top: BorderSide(width: 1,color: Color(0xff9DA5BC)),

                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Days 30",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                              Text("${result.days30 ?? 0}",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 28.w,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Days 120",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                              Text("${result.days120 ?? 0}",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28.w,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1,color: Color(0xff9DA5BC)),
                                left:  BorderSide(width: 1,color: Color(0xff9DA5BC)),
                              top: BorderSide(width: 1,color: Color(0xff9DA5BC)),
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Days 60",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                              Text("${result.days60 ?? 0}",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 28.w,
                        decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 1,color: Color(0xff9DA5BC)),

                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Above 120",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                              Text("${result.above120 ?? 0}",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28.w,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 1,color: Color(0xff9DA5BC)),
                              left:  BorderSide(width: 1,color: Color(0xff9DA5BC)),
                              top: BorderSide(width: 1,color: Color(0xff9DA5BC)),
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Days 90",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                              Text("${result.days90 ?? 0}",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 28.w,
                        decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 1,color: Color(0xff9DA5BC)),

                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Not Due",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                              Text(result.notDue.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Text(result.mcpAmtIntl.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.transparent),)
                ],
              ),
            ),
          ],
        ),
      ),);
  }
}

Color label_color = Color(0xff5338B4);
