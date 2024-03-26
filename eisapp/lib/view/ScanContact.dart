
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'CreateCatelog.dart';

class ScanContact extends StatefulWidget {
  const ScanContact({super.key});

  @override
  State<ScanContact> createState() => _ScanContactState();
}

class _ScanContactState extends State<ScanContact>  with BackgroundDecoration {
  bool allowMultiple =false;
  List<String> listBarcode = [];
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(body: Container(
        decoration: bgDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height/7,
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back,color: Colors.white,)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35)
                            ),
                            child:  Row(
                              children: [
                                Text("Select Catelog",style: TextStyle(color: Colors.black,fontSize:  userMobile(context)?13.sp:16.sp),),
                                SizedBox(width: 5,),
                                Icon(Icons.arrow_drop_down,color: Colors.black,size: 15.sp,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Scan Contact",style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?16.sp:18.sp),),
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: const Color(0xff5F1E80FF),
                                  activeColor: const Color(0xffFFFFFF),
                                  focusColor: Colors.black,
                                  side: const BorderSide(color: Colors.white),
                                  value: allowMultiple,
                                  splashRadius: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      allowMultiple = value!;
                                    });
                                  },
                                ),
                                Text("Allow Duplicate",style: TextStyle(color: Colors.white,fontSize: 12.sp),),
                                SizedBox(width: 8,),
                                Icon(Icons.list,color: Colors.white,size: 22.sp,)

                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFF9F9AAF).withOpacity(0.7),
                          const Color(0xFFFFFFFF),
                        ],

                        begin:  const FractionalOffset(0.0, 0.0),
                        end:  const FractionalOffset(0.0, 0.9),
                        stops: const [0.0, 0.35,],
                        tileMode: TileMode.clamp),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight:  Radius.circular(20))
                ),
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/8,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          listBarcode.isEmpty?Container():   GestureDetector(
                            onTap: (){
                              openDialogue(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF562162),
                                      Color(0xFF553BDF),
                                    ],

                                    begin:  FractionalOffset(1.0, 0.0),
                                    end:  FractionalOffset(0.0, 0.5),
                                    stops: [0.0, 1.0,],
                                    tileMode: TileMode.mirror),
                              ),
                              child: Text("SAVE AS CATELOG",style: TextStyle(color: Colors.white,fontSize: 12.sp),),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                    openDialogue(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF562162),
                                          Color(0xFF553BDF),
                                        ],

                                        begin:  FractionalOffset(1.0, 0.0),
                                        end:  FractionalOffset(0.0, 0.5),
                                        stops: [0.0, 1.0,],
                                        tileMode: TileMode.mirror),
                                  ),
                                  child: Text("MANUAL",style: TextStyle(color: Colors.white,fontSize: 12.sp),),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF562162),
                                        Color(0xFF553BDF),
                                      ],

                                      begin:  FractionalOffset(1.0, 0.0),
                                      end:  FractionalOffset(0.0, 0.5),
                                      stops: [0.0, 1.0,],
                                      tileMode: TileMode.mirror),
                                ),
                                child: Text("BARCODE SCAN",style: TextStyle(color: Colors.white,fontSize: 12.sp),),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    listBarcode.isEmpty? Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text("Scan Barcode of Contact number\n to Create Catelog",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15.sp),),):  Expanded(
                      child: ListView.builder(
                        itemCount: listBarcode.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 6,
                            margin: EdgeInsets.only(bottom: 8,left: 8,right: 8),

                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(listBarcode[index].trim().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                                  GestureDetector(
                                      onTap: (){
                                        listBarcode.removeAt(index);
                                        setState(() {

                                        });
                                      },
                                      child: Icon(Icons.delete,size: 25.sp,color: Color( 0xff74219f),))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )

                  ],
                ),
              )

            ],
          ),
        ),
      ),),
    );
  }

  TextEditingController controller = TextEditingController();

  openDialogue(BuildContext context){
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), //this right here
      child: Container(
        height: 75.w,
        width: 85.w,

        child: Column(

          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Manual Entry",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18.sp),),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close,size: 25.sp,))
                    ],
                  ),
                ),
      Container(
        height: 40.w,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
        ),
        child: TextField(
          controller: controller,
          maxLines: null,
          expands: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.transparent
          ),
          keyboardType: TextInputType.multiline,
        ),
      ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      print("List----${controller.text.trim().split("\n")}");
                      listBarcode.addAll(controller.text.trim().split("\n").toList());
                      controller.clear();
                      Navigator.pop(context);
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text("ADD",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
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
  }

