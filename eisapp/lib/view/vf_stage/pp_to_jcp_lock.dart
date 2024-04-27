import 'dart:convert';

import 'package:eisapp/helper/ApproveLoaderHelper.dart';
import 'package:eisapp/model/PpToJcpModel.dart';
import 'package:eisapp/view/vf_stage/debtor_aging_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart' as e;
import '../CreateCatelog.dart';
import '../design_consts/DecorationMixin.dart';
import 'details_call.dart';
import 'package:get/get.dart' as getter;

class PPToJCPLock extends StatefulWidget {
  e.Result result;
  PPToJCPLock({super.key,required this.result});

  @override
  State<PPToJCPLock> createState() => _PPToJCPLockState();
}

class _PPToJCPLockState extends State<PPToJCPLock> with BackgroundDecoration {
  bool dataLoading = false;
  PpToJcpModel? ppToJcpModel;

  ApproveoaderHelper approveoaderHelper = getter.Get.find();

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pp_to_jcp_lock(context);
  }

  pp_to_jcp_lock(BuildContext context) async {
    setState(() {
      dataLoading=true;
      approveoaderHelper.approveLoading=true;
      approveoaderHelper.update();
    });
    Response response = await details_call("api/a/sql/get_vf_approve_pp_vs_jcp_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      setState(() {
        ppToJcpModel = PpToJcpModel.fromJson(jsonDecode(response.body));
        dataLoading=false;
        if(ppToJcpModel!.result!.isNotEmpty){
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
    return ppToJcpModel!.result!.isEmpty?Container(child: Center(child: Text("No Data Available",style: TextStyle(fontSize: font_Size),),),): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${ppToJcpModel!.result!.first.invNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("Invoice NO", "${ppToJcpModel!.result!.first.invNo ?? '-'}",context),
            detailsLabeling("Invoice Date", ppToJcpModel!.result!.first.invDt?? '-',context),
            detailsLabeling("Currency", ppToJcpModel!.result!.first.curCode?? '-',context),
            SizedBox(height: 10,),
            ListView.builder(
                itemCount: ppToJcpModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,ppToJcpModel!.result![index]);
                }),
            SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }

  Widget orderCard(BuildContext context,Result result){
    double font_Size = userMobile(context) ? 15.sp : 20.sp;
    return Card(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(result.lotCode ?? '',style: TextStyle(color: label_color,fontSize: font_Size,fontWeight: FontWeight.w600),),
                  Text(
                    "Margin: ${result.margin ?? ''}",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: font_Size,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(color: Color(0xff9DA5BC),thickness: 1,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 30.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                        Text(result.locationName.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),
                  Container(
                    width: 30.w,
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Color(0xff9DA5BC)))
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("JCP",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                          Text(result.jcpRate.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 30.w,
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Color(0xff9DA5BC)))
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PP",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                          Text(result.ppRate.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  //Text(result.ppJcpPct.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.transparent),)
                ],
              ),
            )
          ],
        ),
      ),);
  }
}
