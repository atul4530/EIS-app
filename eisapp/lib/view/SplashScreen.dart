import 'dart:convert';

import 'package:eisapp/helper/pref_data.dart';
import 'package:eisapp/model/LoginResponeModel.dart';
import 'package:eisapp/view/LoginScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'DashboardScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with BackgroundDecoration{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);

  }

  getData(BuildContext context){
    PreferenceHelper().getStringValuesSF("data").then((value) {
      print("---Value----$value");
      try{
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode(value.toString()));
        if(loginResponseModel.result.toString() == "true"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
        }
        else
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        }
      }
      catch(e){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: bgDecoration(),
        child: Center(child: Image.asset("assets/images/logo.png",height: 30.w,),),
      ),
    );
  }
}
