
import 'dart:convert';

import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:eisapp/view/vf_stage/MemoAgeignLock.dart';
import 'package:eisapp/view/vf_stage/POGpLock.dart';
import 'package:eisapp/view/vf_stage/POType.dart';
import 'package:eisapp/view/vf_stage/SalesReturnLock.dart';
import 'package:eisapp/view/vf_stage/debtor_aging_lock.dart';
import 'package:eisapp/view/vf_stage/expenses_budget.dart';
import 'package:eisapp/view/vf_stage/gp_lock.dart';
import 'package:eisapp/view/vf_stage/melting_lock.dart';
import 'package:eisapp/view/vf_stage/pp_to_jcp_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../helper/pref_data.dart';
import '../../model/GetVfStageDetaulsModel.dart';
import '../../model/LoginResponeModel.dart';
import '../CreateCatelog.dart';
import '../SingleApprovalScreen.dart';





class VfStageDetails extends StatefulWidget {
  Result result;
  String name;
   VfStageDetails({super.key,required this.result,required this.name});

  @override
  State<VfStageDetails> createState() => _VfStageDetailsState();
}

class _VfStageDetailsState extends State<VfStageDetails>
    with BackgroundDecoration {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  approveDialogue(BuildContext context) {
    controller.clear();
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //this right here
      child: Container(
        height: userMobile(context) ? 51.w : 30.w,
        width: userMobile(context) ? 75.w : 60.w,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Approve",
                style: TextStyle(
                    color: Color(0xff74219f),
                    fontWeight: FontWeight.w700,
                    fontSize: userMobile(context) ? 20.sp : 25.sp),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 0),
              child: Text(
                "Do You want Approve!",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.2),
                    fontWeight: FontWeight.w700,
                    fontSize: userMobile(context) ? 16.sp : 21.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.2),
                  border:
                  Border.all(color: Colors.grey.withOpacity(0.5), width: 1)),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  hintText: "Comments",
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp),
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          color: Color(0xffff402a),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: userMobile(context) ? 13.sp : 18.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if(controller.text.trim().length>0){
                        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
                            jsonDecode(
                                (await PreferenceHelper().getStringValuesSF("data")).toString()));

                        approveCall(context,"catalog/vfapprove/a/${widget.result.vfStageId}/${await loginResponseModel.data!.first.empId}?comment=${controller.text.trim()}");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          color: Color(0xff0fd587),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "APPROVE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: userMobile(context) ? 13.sp : 18.sp),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);
  }

  Widget VfStageDetails(BuildContext context,String name){
    switch(name.toUpperCase()){
      case "GP LOCK" :
        return GpLock(result: widget.result);
      case "MELTING LOCK" :
        return MeltingLock(result: widget.result);
      case "DEBTOR AGING LOCK" :
        return DebtorAgingLock(result: widget.result);
      case "EXPENSES BUDGET" :
        return ExpensesBudget(result: widget.result);
      case "PO GP LOCK" :
        return POGpLock(result: widget.result);
      case "SALES RETURN LOCK" :
        return SalesReturnLock(result: widget.result);
      case "PO TYPE" :
        return PoType(result: widget.result);
      case "PP TO JCP LOCK" :
        return PPToJCPLock(result: widget.result);
      case "MEMO AGEING LOCK" :
        return MemoAgeignLock(result: widget.result);
      default :
        return MeltingLock(result: widget.result);
    }
  }

  @override
  Widget build(BuildContext context) {
    double font_Size = userMobile(context) ? 16.sp : 20.sp;
    print("Vf Stage Id : ${widget.result.vfStageId}");
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 50,
          color: Colors.transparent,
          margin: EdgeInsets.all(12),
          child: GestureDetector(
          onTap: () {
            approveDialogue(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 15, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF562162),
                    Color(0xFF553BDF),
                  ],

                  begin:  FractionalOffset(1.0, 0.0),
                  end:  FractionalOffset(0.0, 0.5),
                  stops: [0.0, 1.0,],
                  tileMode: TileMode.mirror),
            ),
            child: Center(
              child: Text(
                "APPROVE",
                style: TextStyle(
                    color: Colors.white, fontSize: font_Size),
              ),
            ),
          ),
        ),),
        body: Container(
          decoration: bgDecoration(),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height / 9,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                            GestureDetector(
                              onTap: () async {
                                // await getSelectCatelogData();
                                // openOptions(context);
                              },
                              child:  Icon(Icons.logout,color: Colors.white,),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Business Control Approval",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  userMobile(context) ? 16.sp : 20.sp),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFF9F9AAF).withOpacity(0.7),
                            const Color(0xFFFFFFFF),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 0.7  ),
                          stops: const [
                            0.0,
                            0.28,
                          ],
                          tileMode: TileMode.clamp),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height /3.8,
                  width: MediaQuery.of(context).size.width,
                  child: VfStageDetails(context,widget.name),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




}

