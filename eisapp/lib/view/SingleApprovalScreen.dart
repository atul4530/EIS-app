import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'CreateCatelog.dart';

class SingleApprovalScreen extends StatefulWidget {
  final String cat;
   SingleApprovalScreen({super.key,required this.cat});

  @override
  State<SingleApprovalScreen> createState() => _SingleApprovalScreenState();
}

class _SingleApprovalScreenState extends State<SingleApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.cat,style: TextStyle(color: const Color(0xff6a208f),fontSize:userMobile(context)?   16.sp:20.sp,fontWeight: FontWeight.w500),),
          ),
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(9.w),
            ),
            child: Container(
              height: 9.w,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.w),
                color: Colors.white
              ),
              child: Container(
                width: 70.w,
                height: 9.w,
                alignment: Alignment.centerLeft,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    hintText: "Search",
                    prefixIcon:  Container(
                        margin: EdgeInsets.only(left: userMobile(context)?  0:20),
                        child: Icon(Icons.search,color: Colors.black.withOpacity(0.2),size: userMobile(context)?20.sp:35.sp,)),
                    contentPadding: const EdgeInsets.only(bottom:11,left: 0),
                    hintStyle: TextStyle(fontSize:userMobile(context)?  16.sp:21.sp ,color: Colors.black.withOpacity(0.3))
                  ),
                ),
              ),
            ),
          ),
          Container(
            height:userMobile(context)? 63.h:70.h,
            child: ListView.builder(
              itemCount: 15,
              //physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (BuildContext context, int index) {
                double font_Size=  userMobile(context)?  16.sp:20.sp;
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.only(bottom: 8,left: 8,right: 8),

                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("FSIL-232044",style: TextStyle(color: const Color(0xff6a208f),fontSize: font_Size),),
                            Text("INEKIJK",style: TextStyle(color: Colors.black.withOpacity(0.2),fontSize: font_Size),),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Text("Invoice GP:-10.08%,Limit Not Allowed:-1000.0 % To:-5.0%",style: TextStyle(color: Colors.black.withOpacity(0.3),fontSize:font_Size-2.sp,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Approver Name:",style: TextStyle(color: const Color(0xff000000),fontSize: font_Size-3.sp,fontWeight: FontWeight.w600),),
                            Text("Prashant Surana",style: TextStyle(color: const Color(0xff6a208f),fontSize: font_Size-3.sp,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          children: [
                            Text("Remarks:.",style: TextStyle(color: const Color(0xff000000),fontSize: font_Size-3.sp,fontWeight: FontWeight.w600),),
                            Text("Angel Stocks.",style: TextStyle(color: const Color(0xff6a208f),fontSize: font_Size-3.sp,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Text("GP:-10.08 %",style: TextStyle(color: const Color(0xffcc2c2c),fontSize: font_Size,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("View More",style: TextStyle(fontSize: font_Size,fontWeight: FontWeight.w400,color: const Color(0xff6a208f),decoration: TextDecoration.underline)),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                approveDialogue(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                decoration: BoxDecoration(
                                    color: Color(0xff0fd587),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text("APPROVE",style: TextStyle(color: Colors.white,fontSize: font_Size),),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )


        ],
      ),
    );
  }
}

TextEditingController controller = TextEditingController();

approveDialogue(BuildContext context){
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), //this right here
    child: Container(
      height:userMobile(context)? 51.w:30.w,
      width:userMobile(context)? 75.w:60.w,
      color: Colors.white,

      child: Column(

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Approve",style: TextStyle(color: Color(0xff74219f),fontWeight: FontWeight.w700,fontSize:userMobile(context)? 20.sp:25.sp),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 0),
            child: Text("Do You want Approve!",style: TextStyle(color: Colors.black.withOpacity(0.2),fontWeight: FontWeight.w700,fontSize: userMobile(context)?16.sp:21.sp),),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.2),
                border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1)
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  hintText: "Comments",
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.2),fontWeight: FontWeight.w700,fontSize: 16.sp),
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
                  onTap: (){
                        Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    decoration: BoxDecoration(
                        color: Color(0xffff402a),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text("CANCEL",style: TextStyle(color: Color(0xffffffff),fontSize:userMobile(context)?13.sp:18.sp),),
                  ),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    decoration: BoxDecoration(
                        color: Color(0xff0fd587),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text("APPROVE",style: TextStyle(color: Colors.white,fontSize: userMobile(context)?13.sp:18.sp),),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);}
