import 'dart:convert';

import 'package:eisapp/model/ExpenseBudgetModel.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:eisapp/view/vf_stage/debtor_aging_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../helper/ApproveLoaderHelper.dart';
import '../../model/GetVfStageDetaulsModel.dart' as e;
import '../CreateCatelog.dart';
import 'details_call.dart';
import 'package:get/get.dart' as getter;

class ExpensesBudget extends StatefulWidget {
  e.Result result;
  ExpensesBudget({super.key,required this.result});

  @override
  State<ExpensesBudget> createState() => _ExpensesBudgetState();
}

class _ExpensesBudgetState extends State<ExpensesBudget> with BackgroundDecoration{
  bool dataLoading = false;
  ExpenseBudgetModel? expenseBudgetModel;

  ApproveoaderHelper approveoaderHelper = getter.Get.find();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenses_budget_call(context);
  }

  expenses_budget_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
      approveoaderHelper.approveLoading=true;
      approveoaderHelper.update();
    });
    Response response = await details_call("api/a/sql/get_vf_approve_expense_budget_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      setState(() {
        expenseBudgetModel = ExpenseBudgetModel.fromJson(jsonDecode(response.body));
        dataLoading=false;
        if(expenseBudgetModel!.result!.isNotEmpty){
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
    return expenseBudgetModel!.result!.isEmpty?Container(child: Center(child: Text("No Data Available",style: TextStyle(fontSize: font_Size),),),): SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${expenseBudgetModel!.result!.first.invNo ?? '-'}",style: TextStyle(fontSize: font_Size,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
            detailsLabeling("Invoice NO", "${expenseBudgetModel!.result!.first.invNo ?? '-'}",context),
            detailsLabeling("Invoice Date", expenseBudgetModel!.result!.first.invDt?? '-',context),
            detailsLabeling("Narration", expenseBudgetModel!.result!.first.narration?? '-',context),
            SizedBox(height: 10,),
            ListView.builder(
                itemCount: expenseBudgetModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,expenseBudgetModel!.result![index]);
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(result.accountName ?? '',style: TextStyle(color:label_color,fontSize: font_Size,fontWeight: FontWeight.w600),),
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
                    width: 35.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("GSSG Name",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                        Text(result.gssgName.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Color(0xff9DA5BC)))
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dr/Cr",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                          Text(result.debitCredit.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 35.w,
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1,color: Color(0xff9DA5BC)))
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amount",style: TextStyle(fontSize: font_Size-2.sp,color: Color(0xff9DA5BC),fontWeight: FontWeight.w600),),
                          Text(result.amount.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black,fontWeight: FontWeight.w600),)
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
