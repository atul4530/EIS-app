import 'package:eisapp/view/SingleApprovalScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'CreateCatelog.dart';
import 'design_consts/DecorationMixin.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> with BackgroundDecoration{
  List<String> listApproval = [
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE",
    "ABC",
    "DVVE"
  ];

  bool singleApprove=false;
  String cat="";

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
              height: MediaQuery.of(context).size.height/9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 8,top: singleApprove?10:0),
                          child:singleApprove?GestureDetector(
                              onTap: (){
                                setState(() {
                                  singleApprove=false;
                                });
                              },
                              child: Icon(Icons.arrow_back,color: Colors.white,size: 25.sp,)): Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width/4.5,)),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.logout,size: 6.w,color: Colors.white,),
                      ) ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 8),
                    child: Text("Business Control Approvals",style: TextStyle(color: Colors.white,fontSize: userMobile(context)?  14.sp:22.sp,fontWeight: FontWeight.w500),),
                  )

                  // SizedBox(height: 30,),
                ],
              ),
            ),
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF9F9AAF).withOpacity(0.7),
                        Color(0xFFFFFFFF),
                      ],

                      begin:  FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(0.0, 0.9),
                      stops: [0.0, 0.35,],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:  Radius.circular(20))
              ),
              height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/(userMobile(context)?  4.3:5.6),
              width: 100.w,
              child: listApproval.isEmpty?Center(child: Text("Access not available \n Contact EIS Team!",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),):singleApprove?SingleApprovalScreen(cat: cat): ListView.builder(
                itemCount: listApproval.length,
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        singleApprove=true;
                        cat=listApproval[index];
                      });
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleCatelogScreen(catelog: listCatelog[index],)));
                    },
                    child: Card(
                      elevation: 6,
                      margin: EdgeInsets.only(bottom: 8,left: 8,right: 8),

                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 14),

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 15,),
                                Text(listApproval[index].trim().toUpperCase(),style: TextStyle(color: Colors.black,fontSize:userMobile(context)?  14.sp:19.sp ),),
                                SizedBox(width: 8,),
                                Text("$index",style: TextStyle(color: Color(0xff71f306),fontSize: 14.sp),),

                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: Color(0xff6a208f),size: 20.sp,)
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

