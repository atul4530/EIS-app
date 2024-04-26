import 'dart:convert';

import 'package:eisapp/model/MemoAgeignLockModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart' as r;
import '../CreateCatelog.dart';
import '../design_consts/DecorationMixin.dart';
import 'details_call.dart';

class MemoAgeignLock extends StatefulWidget {
  r.Result result;
   MemoAgeignLock({super.key,required this.result});

  @override
  State<MemoAgeignLock> createState() => _MemoAgeignLockState();
}

class _MemoAgeignLockState extends State<MemoAgeignLock> with BackgroundDecoration{
  bool dataLoading = false;
  MemoAgeignLockModel? memoAgeignLockModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memo_ageign_lock(context);
  }

  memo_ageign_lock(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_approve_memo_ageing_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      setState(() {
        memoAgeignLockModel = MemoAgeignLockModel.fromJson(jsonDecode(response.body));
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
    return memoAgeignLockModel!.result!.isEmpty?Container(child: Center(child: Text("No Data Available",style: TextStyle(fontSize: font_Size),),),): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${memoAgeignLockModel!.result!.first.invNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("Invoice NO", "${memoAgeignLockModel!.result!.first.invNo ?? '-'}",context),
            detailsLabeling("Invoice Date", memoAgeignLockModel!.result!.first.invDt?? '-',context),
            detailsLabeling("Party Name", memoAgeignLockModel!.result!.first.invPartyName?? '-',context),
            detailsLabeling("Currency", memoAgeignLockModel!.result!.first.curCode?? '-',context),
            ListView.builder(
                itemCount: memoAgeignLockModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,memoAgeignLockModel!.result![index]);
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(result.memoInvNo ?? '',style: TextStyle(color: Colors.deepPurple,fontSize: font_Size),),
                  Text(result.memoInvDt ?? '',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: font_Size),),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Memo Days",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                      Text(result.memoMemoDays.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                          Text("Pending Qty",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.pendingQty.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                          Text("Pending Amount",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.pendingAmount.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                  //Text(result.mcpAmtIntl.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.transparent),)
                ],
              ),
            )
          ],
        ),
      ),);
  }
}
