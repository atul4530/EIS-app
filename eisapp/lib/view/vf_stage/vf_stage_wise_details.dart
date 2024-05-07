
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
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/ApproveLoaderHelper.dart';
import '../../helper/pref_data.dart';
import '../../model/GetVfStageDetaulsModel.dart';
import '../../model/LoginResponeModel.dart';
import '../../network/ApiService.dart';
import '../CreateCatelog.dart';
import '../LoginScreen.dart';
import '../SingleApprovalScreen.dart';
import '../loader/loader.dart';





class VfStageDetails extends StatefulWidget {
  Result result;
  String name;
   VfStageDetails({super.key,required this.result,required this.name});

  @override
  State<VfStageDetails> createState() => _VfStageDetailsState();
}

class _VfStageDetailsState extends State<VfStageDetails>
    with BackgroundDecoration {

  ApproveoaderHelper approveoaderHelper = Get.put(ApproveoaderHelper());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  approveDialogue(BuildContext context,String id) {
    controller.clear();
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //this right here
      child: Container(
        height: userMobile(context) ? 51.w : 43.w,
        width: userMobile(context) ? 75.w : 65.w,
        color: Colors.white,
        padding: EdgeInsets.all(userMobile(context) ?0:4.w),
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
                      padding: EdgeInsets.symmetric(horizontal: userMobile(context) ?15:25, vertical: 8),
                      decoration: BoxDecoration(
                          color: Color(0xffff402a),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: userMobile(context) ? 13.sp : 18.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GetBuilder(
                    init: ApproveoaderHelper(),
                    builder: (cn) {

                      return GestureDetector(
                        onTap: () async {
                          LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
                              jsonDecode(
                                  (await PreferenceHelper().getStringValuesSF("data")).toString()));

                          approveCall(context,"catalog/vfapprove/a/$id/${await loginResponseModel.data!.first.empId}?comment=${controller.text.trim()}");

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: userMobile(context) ?15:25, vertical: 8),
                          decoration: BoxDecoration(
                              color: Color(0xff0fd587),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "APPROVE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: userMobile(context) ? 13.sp : 18.sp),
                          ),
                        ),
                      );
                    }
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

  var dataTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;


  @override
  Widget build(BuildContext context) {
    double font_Size = userMobile(context) ? 16.sp : 20.sp;
    print("Vf Stage Id : ${widget.result.vfStageId}");
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgDecoration(),
          child: Column(
            children: [
              SizedBox(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height /(userMobile(context)? 10:(dataTablet>700?10:8.9)),
                child:Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height /(userMobile(context)? 10:(8.9)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: userMobile(context) ? 8 : 16,top: userMobile(context) ? 10 : 16,bottom: userMobile(context) ? 8.0 : 16),
                              child: GestureDetector(
                                  onTap: () {

                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 25.sp,
                                  ))),
                          logout_icon(context)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                        child: Text(
                          "Business Control Approvals",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: userMobile(context) ? 14.sp : 22.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      )

                      // SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: decorationCommon(),
                alignment: Alignment.topCenter,
                height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height /(userMobile(context)? 6.25:dataTablet>700?8.35:7.18)),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                        height:  (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.height /(userMobile(context)? 8:dataTablet>700?7:5.96)),
                        child: VfStageDetails(context,widget.name)),
                    GetBuilder(
                        init: ApproveoaderHelper(),
                        builder: (cn) {
                          if(cn.approveLoading){
                            return Container();
                          }
                        return Container(
                          height: 50,
                          color: Colors.transparent,
                          margin: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                          child: GestureDetector(
                            onTap: () {
                              approveDialogue(context,widget.result.vfId.toString());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6D287B),
                                      Color(0xFF584AEF),
                                    ],
                                    begin: FractionalOffset(1.0, 0.0),
                                    end: FractionalOffset(0.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: Center(
                                child: Text(
                                  "APPROVE",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: font_Size,fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),);
                      }
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  approveCall(BuildContext context,String url) async {
    Navigator.pop(context);
    showLoaderDialog(context);
    var response = await ApiService.getData(url);
    print("Reponse : ${response.body}");
    Navigator.pop(context);

    if (response.body.contains("SUCCESS")) {
      var snackBar =  SnackBar(
        content: Text(
          "Approved!!!!",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w800),),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
     // get_bc_vf_stage_details(context);
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }



}

