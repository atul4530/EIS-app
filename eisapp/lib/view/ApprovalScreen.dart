import 'dart:convert';

import 'package:eisapp/view/SingleApprovalScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/pref_data.dart';
import '../model/GetAllBcCountModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';
import 'CreateCatelog.dart';
import 'LoginScreen.dart';
import 'design_consts/DecorationMixin.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen>
    with BackgroundDecoration {
  GetAllBcAccountModel? getAllBcAccountModel;
  Result? result;

  bool singleApprove = false;

  bool dataLoading = true;
  String? is_approval_req = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBcAccountData();
  }

  getAllBcAccountData() async {
    setState(() {
      dataLoading = true;
    });
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    print("******************${loginResponseModel.data!.first.isApprovalReq}");
    is_approval_req = loginResponseModel.data!.first.isApprovalReq ?? '';
    print("******************$is_approval_req");
    if (is_approval_req == "Y") {
      var response = await ApiService.getData(
          "api/a/sql/get_all_bc_count/all/${loginResponseModel.data!.first.empId!}");
      print("----Response  : ${response.body}");
      GetAllBcAccountModel data =
          GetAllBcAccountModel.fromJson(jsonDecode(response.body));
      if (data.status ?? false) {
        setState(() {
          getAllBcAccountModel = data;
          dataLoading = false;
        });
      } else {
        setState(() {
          dataLoading = false;
        });
      }
    } else {
      setState(() {
        dataLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: bgDecoration(),
      child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //color: Colors.black,
                    height: MediaQuery.of(context).size.height / 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 8, top: singleApprove ? 10 : 0),
                                child: singleApprove
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleApprove = false;
                                          });
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ))
                                    : Image.asset(
                                        "assets/images/logo.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                      )),
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
                  Container(
                    decoration: decorationCommon(),
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height /
                            (userMobile(context) ? 4.3 : 5.6),
                    width: 100.w,
                    child: dataLoading
                        ? Center(
                      child:  Image.asset("assets/images/loader.gif",height:userMobile(context)?50:80,),
                    )
                        :getAllBcAccountModel==null?Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ): is_approval_req == "false"
                        ? Center(
                            child: Text(
                              "Access not available \n Contact EIS Team!",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : singleApprove
                            ? SingleApprovalScreen(result: result!)
                            : ListView.builder(
                                itemCount: getAllBcAccountModel!.result!.length,
                                padding: EdgeInsets.only(top: 20),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        singleApprove = true;
                                        result = getAllBcAccountModel!
                                            .result![index];
                                      });
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleCatelogScreen(catelog: listCatelog[index],)));
                                    },
                                    child: Card(
                                      elevation: 6,
                                      margin: EdgeInsets.only(
                                          bottom: 8, left: 8, right: 8),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 14),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  getAllBcAccountModel!
                                                      .result![index].vfCode!
                                                      .trim()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          userMobile(context)
                                                              ? 14.sp
                                                              : 19.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "${getAllBcAccountModel!.result![index].bcCount!}",
                                                  style: TextStyle(
                                                      color: Color(0xff71f306),fontWeight: FontWeight.w600,
                                                      fontSize: 14.sp),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xff6a208f),
                                              size: 20.sp,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  )
                ],
              ),
            ),
    );
  }



}
