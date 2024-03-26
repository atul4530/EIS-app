import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:share_plus/share_plus.dart';

import 'CreateCatelog.dart';
import 'SingleCatelogScreen.dart';
import 'design_consts/DecorationMixin.dart';

class CatelogListScreen extends StatefulWidget {
  const CatelogListScreen({super.key});

  @override
  State<CatelogListScreen> createState() => _CatelogListScreenState();
}

class _CatelogListScreenState extends State<CatelogListScreen>  with BackgroundDecoration {
  List<String> listCatelog = [
    "Catename(1)",
    "Document(1)",
    "Catelog Name(3)"
  ];

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
                height: MediaQuery.of(context).size.height/9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:  Icon(Icons.arrow_back,color: Colors.white,size:  userMobile(context)?22.sp:27.sp,)),

                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Catelog List",style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?16.sp:22.sp),),
                          Container()
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
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                child:ListView.builder(
                  itemCount: listCatelog.length,
                  padding: EdgeInsets.only(top: 20),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleCatelogScreen(catelog: listCatelog[index],)));
                      },
                      child: Card(
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
                              Text(listCatelog[index].trim().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: userMobile(context)? 15.sp:20.sp),),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      controller.clear();
                                      controller.text = listCatelog[index];

                                      openUpdateCatelog(context,index);
                                    },
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 2.5.sp),
                                      child: Icon(Icons.edit_note_sharp,color: const Color(0xff5f1e80),size: userMobile(context)?20.sp:30.sp,),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                     // Share.share('check out my website https://example.com', subject: 'Look what I made!');
                                    },
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.sp),
                                      child: Icon(Icons.share,color: const Color(0xff5f1e80),size:  userMobile(context)?20.sp:30.sp,),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap:(){
                                      printCatelog(context,index);
                                     },
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.sp),
                                      child: Text("Print",style: TextStyle(color: const Color(0xff5f1e80),fontSize: userMobile(context)? 15.sp:18.sp,fontWeight: FontWeight.w800),),
                                    ),
                                  ),
                                ],
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
      ),),
    );
  }

  TextEditingController controller = TextEditingController();
  List gender=["PDF","Excel"];
  String? select;

  openUpdateCatelog(BuildContext context,int index){

    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), //this right here
      child: Container(
        height: 45.w,
        width: 85.w,

        child: Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Update Catelog Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18.sp),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,size: 25.sp,))
                ],
              ),
            ),
            Container(
              height: 12.w,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
              ),
              child: TextField(
                controller: controller,
                maxLines: 2,
                style: TextStyle(fontSize: 20.sp),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5),
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
                      Navigator.pop(context);
                      setState(() {
                        listCatelog[index]=controller.text.trim();
                      });



                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
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

  Row addRadioButton(BuildContext context,int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Color(0xff5f1e80),

          value: gender[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              print(value);
              select=value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  printCatelog(BuildContext context,int index){


    showDialog(context: context, builder: (BuildContext context) { 
      return StatefulBuilder(
          builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), //this right here
            child: Container(
              height: 55.w,
              width: 85.w,
              color: Colors.white,

              child: Column(

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Report Format",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close,size: 25.sp,))
                      ],
                    ),
                  ),
                  Container(
                    height: 8.w,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${listCatelog[index]}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.w500),),
                          Icon(Icons.arrow_drop_down_outlined,size: 22.sp,color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                  Text("Output",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16.sp),),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            activeColor: Color(0xff5f1e80),

                            value: gender[0],
                            groupValue: select,
                            onChanged: (value){
                              setState(() {
                                print(value);
                                select=value;
                              });
                            },
                          ),
                          Text("PDF")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            activeColor: Color(0xff5f1e80),

                            value: gender[1],
                            groupValue: select,
                            onChanged: (value){
                              setState(() {
                                print(value);
                                select=value;
                              });
                            },
                          ),
                          Text("Excel")
                        ],
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xff5f1e80),width: 1)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 4),
                        alignment: Alignment.center,
                        child: Text("Print",style: TextStyle(fontSize: 12.sp,color:  Color(0xff5f1e80),fontWeight: FontWeight.w500),),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xff6b6666),width: 1)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40,vertical:4),
                          alignment: Alignment.center,
                          child: Text("Cancel",style: TextStyle(fontSize: 12.sp,color:  Color(0xff6b6666),fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        }
      );
    });}
  
  }


