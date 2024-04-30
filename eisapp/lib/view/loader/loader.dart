import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Image.asset("assets/images/loader.gif",height: 20.w,width:20.w),
  );
  showDialog(barrierDismissible: false,
    context:context,

    builder:(BuildContext context){
      return alert;
    },
  );
}