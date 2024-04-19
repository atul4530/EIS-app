import 'dart:convert';

import 'package:eisapp/model/ExpenseBudgetModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart' as e;
import '../CreateCatelog.dart';
import 'details_call.dart';

class ExpensesBudget extends StatefulWidget {
  e.Result result;
  ExpensesBudget({super.key,required this.result});

  @override
  State<ExpensesBudget> createState() => _ExpensesBudgetState();
}

class _ExpensesBudgetState extends State<ExpensesBudget> {
  bool dataLoading = false;
  ExpenseBudgetModel? expenseBudgetModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expenses_budget_call(context);
  }

  expenses_budget_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_approve_expense_budget_details/csc/${widget.result.vfId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
      setState(() {
        expenseBudgetModel = ExpenseBudgetModel.fromJson(jsonDecode(response.body));
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
      return Container(child: Center(child: CircularProgressIndicator(),),);
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
            ListView.builder(
                itemCount: expenseBudgetModel!.result!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return orderCard(context,expenseBudgetModel!.result![index]);
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
                  Text(result.accountName ?? '',style: TextStyle(color: Colors.deepPurple,fontSize: font_Size),),
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
                    width: 30.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("GSSG Name",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                        Text(result.gssgName.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                          Text("Dr/Cr",style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black.withOpacity(0.4)),),
                          Text(result.debitCredit.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
                          Text(result.amount.toString(),style: TextStyle(fontSize: font_Size-2.sp,color: Colors.black),)
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
