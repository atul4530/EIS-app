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
bool singleApprove = false;

class _ApprovalScreenState extends State<ApprovalScreen>
    with BackgroundDecoration {
  GetAllBcAccountModel? getAllBcAccountModel;
  Result? result;

  bool dataLoading = true;
  String? is_approval_req = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      singleApprove=false;
    });
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
          "api/a/sql/get_all_bc_count/all/${loginResponseModel.data!.first.empId!}",fromApproval: true);
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

  var dataTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: bgDecoration(),
      child: Column(
        children: [
          Container(
            //color: Colors.black,
            // height: MediaQuery.of(context).size.height /(userMobile(context)? 10:(dataTablet>700?10:8.9)),
            height: MediaQuery.of(context).size.height /(userMobile(context)? 10:(dataTablet>700?10:7.8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: singleApprove?EdgeInsets.only(left: userMobile(context) ? 8 : 16,top: userMobile(context) ? 10 : 16,bottom: userMobile(context) ? 8.0 : 16): EdgeInsets.only(
                            left: 8, top: 0),
                        child: singleApprove
                            ? GestureDetector(
                            onTap: () {

                              setState(() {
                                singleApprove = false;
                              });
                              getAllBcAccountData();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 25.sp,
                            ))
                            : logo(context)),
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
                    (userMobile(context) ? 7 : 6),
            width: 100.w,
            child: dataLoading
                ? Center(
              child:  Image.asset("assets/images/loader.gif",height:userMobile(context)?50:80,),
            )
                :getAllBcAccountModel==null?is_approval_req!.toLowerCase() == "n"
                ? Center(
              child: Text(
                "Access not Available! \n Contact EIS Team!",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ):Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ): is_approval_req!.toLowerCase() == "n"
                ? Center(
                    child: Text(
                      "Access not Available! \n Contact EIS Team!",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )
                : singleApprove
                    ? SingleApprovalScreen(result: result!)
                    : Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).size.height /
                                  (userMobile(context) ? 5: 5.4))-(userMobile(context)?20: 40),
                          child: ListView.builder(
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
                                                    color: Color(0xff41CB8B),fontWeight: FontWeight.w600,
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
                        ),
                        SizedBox(height: userMobile(context)?30: 30,),
                      ],
                    ),
          )
        ],
      ),
    );
  }



}
