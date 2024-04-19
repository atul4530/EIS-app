import 'dart:convert';

import 'package:eisapp/model/MeltingLockModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart'as r;
import '../CreateCatelog.dart';
import 'details_call.dart';

class MeltingLock extends StatefulWidget {
    r.Result result;
   MeltingLock({super.key,required this.result});

  @override
  State<MeltingLock> createState() => _MeltingLockState();
}

class _MeltingLockState extends State<MeltingLock> {
  bool dataLoading = false;
  MeltingLockModel? meltingLockModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    melting_lock_call(context);
  }

  melting_lock_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_approve_po_metal_rate/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
        print("response : ${response.body}");
        meltingLockModel=MeltingLockModel.fromJson(jsonDecode(response.body));
        setState(() {
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
    print("-> Melting Lock $dataLoading");
    if(dataLoading){
      return Container(child: Center(child: CircularProgressIndicator(),),);
    }
    return meltingLockModel!.result!.isEmpty?Container(child: Center(child: Text("No Data Available",style: TextStyle(fontSize: font_Size),),),): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("${meltingLockModel!.result!.first.poId ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
              detailsLabeling("PO NO", "${meltingLockModel!.result!.first.poId ?? '-'}",context),
              detailsLabeling("PO Date", meltingLockModel!.result!.first.poDt?? '-',context),
              detailsLabeling("PO Type", meltingLockModel!.result!.first.poType?? '-',context),
              detailsLabeling("Customer", meltingLockModel!.result!.first.customerCode?? '-',context),
              detailsLabeling("Title", meltingLockModel!.result!.first.customerAliasName?? '-',context),
              detailsLabeling("Shipment Date", meltingLockModel!.result!.first.shipmentDt?? '-',context),
              detailsLabeling("Head Salesman", meltingLockModel!.result!.first.headSalesman?? '-',context),
              detailsLabeling("Market", meltingLockModel!.result!.first.market?? '-',context),
            ListView.builder(
                itemCount: meltingLockModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
              return orderCard(context,meltingLockModel!.result![index]);
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
      child: Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(result.prodOrderNo ?? '',style: TextStyle(color: Colors.deepPurple,fontSize: font_Size),),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Qty",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                    Text(result.orderQty.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
                  ],
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
                        Text("Metal Type",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                        Text(result.metalType.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                        Text("Metal Weight",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                        Text(result.metalWt.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),);
  }

}
