

import 'dart:convert';

import 'package:eisapp/model/GetVfStageDetaulsModel.dart' as r;
import 'package:eisapp/model/GoLockModel.dart';
import 'package:eisapp/view/vf_stage/details_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../CreateCatelog.dart';


class GpLock extends StatefulWidget {
  r.Result result;
   GpLock({super.key,required this.result});

  @override
  State<GpLock> createState() => _GpLockState();
}

class _GpLockState extends State<GpLock> {
  bool dataLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gp_lock_call(context);
  }
  
  GpLockModel? gpLockModel;

  gp_lock_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_approve_prc_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      setState(() {
        gpLockModel = GpLockModel.fromJson(jsonDecode(response.body));
        dataLoading=false;
      });
    }
    else
    {
      setState(() {
        dataLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double font_Size = userMobile(context) ? 18.sp : 22.sp;
    print("-> PO Type $dataLoading");
    if(dataLoading){
      return Container();
    }
    return gpLockModel!.result!.isEmpty?Container(): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${gpLockModel!.result!.first.pricingNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("Invoice NO", "${gpLockModel!.result!.first.pricingNo ?? '-'}",context),
            detailsLabeling("Customer", gpLockModel!.result!.first.customer?? '-',context),
            detailsLabeling("Invoice Date", gpLockModel!.result!.first.pricingDate?? '-',context),
            detailsLabeling("Head Salesman", gpLockModel!.result!.first.headSalesman?? '-',context),
            detailsLabeling("Market", gpLockModel!.result!.first.market?? '-',context),
            ListView.builder(
                itemCount: gpLockModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,gpLockModel!.result![index]);
                })
          ],
        ),
      ),
    );
  }

  Widget orderCard(BuildContext context,Result result){
    double font_Size = userMobile(context) ? 16.sp : 20.sp;
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(result.contNo ?? '',style: TextStyle(color: Colors.deepPurple,fontSize: font_Size),),
                 // Text("Markup:${result.lotMargin}",style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: font_Size),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(color: Colors.black.withOpacity(0.2),thickness: 1,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //width: 30.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cost Amount",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                        Text(result.chargeAmt.toString().trim(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Colors.black.withOpacity(0.4)))
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("SP Amount",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.spAmt.toString().trim(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Colors.black.withOpacity(0.5)))
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("GP%",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.ocpgm.toString().trim(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                  //Text(result.a.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.transparent),)
                ],
              ),
            )
          ],
        ),
      ),);
  }
}


