import 'dart:convert';

import 'package:eisapp/view/SingleApprovalScreen.dart';
import 'package:flutter/cupertino.dart';
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

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with BackgroundDecoration {
  GetAllBcAccountModel? getAllBcAccountModel;
  Result? result;

  bool singleApprove = false;

  bool dataLoading = false;
  String? is_approval_req = "";
  LoginResponseModel? loginResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBcAccountData();
  }

  getAllBcAccountData() async {
    loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
  setState(() {

  });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration(),
      child: Column(
        children: [
          Container(
            //color: Colors.black,
            height: MediaQuery.of(context).size.height /(userMobile(context)? 10:7.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: 8, top: 4),
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
                    logout_icon(context),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: userMobile(context) ? 16.sp : 22.sp,
                        fontWeight: FontWeight.w600),
                  ),
                )

                // SizedBox(height: 30,),
              ],
            ),
          ),
          loginResponseModel==null?Container():   Container(
            decoration: decorationCommon(),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height /
                    (userMobile(context) ? 5.2 : 5.6),
            width: 100.w,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Name ",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                      Text(loginResponseModel!.data!.first.fullName ?? '',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: Color(0xff696969)),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Id ",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                      Text(loginResponseModel!.data!.first.empId!.toString(),style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: Color(0xff696969)),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("CSC Name ",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                      Text(loginResponseModel!.data!.first.cscName ?? '',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: Color(0xff696969)),),
                    ],
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.clear();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          LoginScreen()), (Route<dynamic> route) => false);

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      width: userMobile(context)? 35.w:20.w,
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout,color: Colors.white,),
                          SizedBox(width: userMobile(context)?10: 10,),
                          Text("Logout",style: TextStyle(fontSize: 17.sp,color: Colors.white),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



}
