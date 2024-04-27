import 'dart:convert';

import 'package:eisapp/model/PoTypeModel.dart';
import 'package:eisapp/view/vf_stage/debtor_aging_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../helper/ApproveLoaderHelper.dart';
import '../../model/GetVfStageDetaulsModel.dart' as r;
import '../CreateCatelog.dart';
import '../design_consts/DecorationMixin.dart';
import 'details_call.dart';
import 'package:get/get.dart' as getter;

class PoType extends StatefulWidget {
  r.Result result;
  PoType({super.key,required this.result});

  @override
  State<PoType> createState() => _PoTypeState();
}

class _PoTypeState extends State<PoType> with BackgroundDecoration{
  bool dataLoading = false;
  PoTypeModel? poTypeModel;

  ApproveoaderHelper approveoaderHelper = getter.Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    po_type_call(context);
  }

  po_type_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
      approveoaderHelper.approveLoading=true;
      approveoaderHelper.update();
    });
    Response response = await details_call("api/a/sql/get_vf_po_type_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      poTypeModel= PoTypeModel.fromJson(jsonDecode(response.body));
      setState(() {
        dataLoading=false;
        if(poTypeModel!.result!.isNotEmpty){
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
    return poTypeModel!.result!.isEmpty?Container(child: Center(child: Text("No Data Available",style: TextStyle(fontSize: font_Size),),),): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${poTypeModel!.result!.first.poNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("PO NO", "${poTypeModel!.result!.first.poNo ?? '-'}",context),
            detailsLabeling("PO Type", poTypeModel!.result!.first.poType?? '-',context),
            detailsLabeling("Party Name", poTypeModel!.result!.first.partyGroupName?? '-',context),
            SizedBox(height: 10,),
            ListView.builder(
                itemCount: poTypeModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,poTypeModel!.result![index]);
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
              child: Text(result.stockType ?? '',style: TextStyle(color: label_color,fontSize: font_Size,fontWeight: FontWeight.w600),),
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
                          Text("Metal",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                          Text(result.metalKt.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
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
                          Text("Qty",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                          Text(result.qty.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
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
