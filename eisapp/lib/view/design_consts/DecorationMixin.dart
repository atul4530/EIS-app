import 'package:eisapp/view/CreateCatelog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LoginScreen.dart';

mixin BackgroundDecoration{
  BoxDecoration bgDecoration(){
    return  BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/toolbar_new.webp"),
        fit: BoxFit.fill
      ),
      // gradient: LinearGradient(
      //     colors: [
      //        Color(0xFF562162),
      //        Color(0xFF553BDF),
      //     ],
      //
      //     begin:  FractionalOffset(1.0, 0.0),
      //     end:  FractionalOffset(0.0, 0.5),
      //     stops: [0.0, 1.0,],
      //     tileMode: TileMode.mirror),
    );
  }

  BoxDecoration decorationCommon(){
    return BoxDecoration(
        color:  const Color(0xFFFBFCFF),
        gradient: LinearGradient(
            colors: [
              const Color(0xFFFBFCFF),
              const Color(0xFFFBFCFF),
              //const Color(0xFFFBFCFF),
              const Color(0xFFD1C6FE),
            ],
            begin: const FractionalOffset(0.0, 0.5),
            end: const FractionalOffset(0.0, 0.0),
            stops: const [
              0.0,
              0.05,
              0.35,
            ],
            tileMode: TileMode.clamp),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)));
  }

  Widget logout_icon(BuildContext context){
    return GestureDetector(
      onTap: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            LoginScreen()), (Route<dynamic> route) => false);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.logout,size: userMobile(context)?6.w: 5.w,color: Colors.white,),
      ),
    );
  }

  Widget loader_center(BuildContext context){
    return Center(child:  Image.asset("assets/images/loader.gif",height:userMobile(context)?50:80,),);
  }

}