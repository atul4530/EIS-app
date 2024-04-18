import 'dart:convert';

import 'package:eisapp/model/SalesReturnLockModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart' as e;
import '../CreateCatelog.dart';
import 'details_call.dart';

class SalesReturnLock extends StatefulWidget {
  e.Result result;
  SalesReturnLock({super.key,required this.result});

  @override
  State<SalesReturnLock> createState() => _SalesReturnLockState();
}

class _SalesReturnLockState extends State<SalesReturnLock> {
  bool dataLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sales_return_lock_call(context);
  }
  
  SalesReturnLockModel? salesReturnLock;

  sales_return_lock_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_sales_return_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      salesReturnLock= SalesReturnLockModel.fromJson(jsonDecode(response.body));
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
    print("-> PO Type $dataLoading");
    if(dataLoading){
      return Container();
    }
    return salesReturnLock!.result!.isEmpty?Container(): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${salesReturnLock!.result!.first.invNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("Invoice NO", "${salesReturnLock!.result!.first.invNo ?? '-'}",context),
            detailsLabeling("Invoice Date", salesReturnLock!.result!.first.invDt?? '-',context),
            detailsLabeling("Party Name", salesReturnLock!.result!.first.invPartyName?? '-',context),
            detailsLabeling("Location", salesReturnLock!.result!.first.locationName?? '-',context),
            ListView.builder(
                itemCount: salesReturnLock!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,salesReturnLock!.result![index]);
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(result.locationName ?? '',style: TextStyle(color: Colors.deepPurple,fontSize: font_Size),),
            //          ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Divider(color: Colors.black.withOpacity(0.2),thickness: 1,),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product Code",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                      Text(result.productCode.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                          Text("Rate",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.mcpRateIntl.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                          Text("Amount",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.mcpAmtIntl.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
