import 'dart:convert';

import 'package:eisapp/model/PoGpLockModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart' as r;
import '../CreateCatelog.dart';
import '../design_consts/DecorationMixin.dart';
import 'details_call.dart';

class POGpLock extends StatefulWidget {
  r.Result result;
  POGpLock({super.key,required this.result});

  @override
  State<POGpLock> createState() => _POGpLockState();
}

class _POGpLockState extends State<POGpLock> with BackgroundDecoration{
  bool dataLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    po_gp_lock_call(context);
  }
  
  PoGpLockModel? poGpLockModel;

  po_gp_lock_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_approve_po_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      setState(() {
        poGpLockModel = PoGpLockModel.fromJson(jsonDecode(response.body));
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
      return loader_center(context);
    }
    return poGpLockModel!.result!.isEmpty?Container(child: Center(child: Text("No Data Available",style: TextStyle(fontSize: font_Size),),),): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${poGpLockModel!.result!.first.poNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("PO NO", "${poGpLockModel!.result!.first.poNo ?? '-'}",context),
            detailsLabeling("PO Date", poGpLockModel!.result!.first.poDt?? '-',context),
            detailsLabeling("PO Type", poGpLockModel!.result!.first.poType?? '-',context),
            detailsLabeling("Customer", poGpLockModel!.result!.first.customerAliasName?? '-',context),
            detailsLabeling("Shipment Date", poGpLockModel!.result!.first.shipmentDt?? '-',context),
            detailsLabeling("Head Salesman", poGpLockModel!.result!.first.headSalesman?? '-',context),
            detailsLabeling("Market", poGpLockModel!.result!.first.market?? '-',context),
            ListView.builder(
                itemCount: poGpLockModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,poGpLockModel!.result![index]);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(result.lotCode ?? '',style: TextStyle(color: Colors.deepPurple,fontSize: font_Size),),
                  Text("Markup:${result.lotMargin}",style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: font_Size),),
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
                        Text("MCP",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                        Text(result.lotMcp.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                          Text("SP",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.lotSp.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
                        ],
                      ),
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
                          Text("Total Qty1",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.totalQty1.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
