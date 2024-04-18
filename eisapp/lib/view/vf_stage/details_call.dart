import 'dart:convert';

import 'package:eisapp/model/LoginResponeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart';

import '../../helper/pref_data.dart';
import '../../network/ApiService.dart';
import '../CreateCatelog.dart';

Future<Response> details_call(String url) async {


  LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
      jsonDecode(
          (await PreferenceHelper().getStringValuesSF("data")).toString()));
  print("-------------API Call :  $url${loginResponseModel.data!.first.empId}");
  var response = await ApiService.getData(
      "$url${loginResponseModel.data!.first.empId}");

  return response;
}

Widget detailsLabeling(String label,String value,BuildContext context){
  double font_Size = userMobile(context) ? 15.sp : 20.sp;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 30.w,
            child: Text(label+":  ",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: font_Size),)),
        Container(
            width: 60.w,
            child: Text(value,style: TextStyle(color: Colors.black,fontSize: 16),maxLines: null,)),
      ],
    ),
  );
}