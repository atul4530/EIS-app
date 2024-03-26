import 'package:eisapp/view/ViewImageScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'CreateCatelog.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with BackgroundDecoration {
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
                          Text("CN/592690",style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?userMobile(context)?  16.sp:20.sp:18.sp),),
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
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/8,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            SizedBox(height: 10,),
                            GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewImageScreen(image:"assets/images/jewellery.png")));
                                },
                                child: Image.asset("assets/images/jewellery.png",height: 26.h,width: 26.h,)),
                            Container(height: 1,color: Colors.black.withOpacity(0.1),),
                            Container(
                              height: 8.h,
                              width: 90.w,
                              child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return Card(
                                      elevation: 2,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Container(
                                        //margin:EdgeInsets.only(left: 10),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset("assets/images/jewellery.png",height: 7.h,width: 7.h,)),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(height: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xffB3B1AB).withOpacity(0.5)
                                  ),
                                  child: Text("Product Information",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.black,width: 0.7))
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Style Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("618836",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.black,width: 0.7))
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Contact Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("CN/592690",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.black,width: 0.7))
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("KGK Collection",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("Diamond Classic Collection",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.black,width: 0.7))
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Customer Collection",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("Diamond Classic Collection",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Jewellery Type",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("Ring",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4),
                                  decoration: BoxDecoration(
                                      color: Color(0xffB3B1AB).withOpacity(0.5)
                                  ),
                                  child: Text("Certified Diamond",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.black,width: 0.7))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Weight",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("0.43",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.black,width: 0.7))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("No of Place",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("1",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.black,width: 0.7))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Color",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("Blue",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4,right: 8),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("MM Size",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                      Text("4.13",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.sp),textAlign: TextAlign.start,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 8,top: 4,bottom: 4),
                                  decoration: BoxDecoration(
                                      color: Color(0xffB3B1AB).withOpacity(0.5)
                                  ),
                                  child: Text("14KW",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: userMobile(context)?  16.sp:20.sp),textAlign: TextAlign.start,),
                                ),
                              ],
                            )

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.shopping_cart_checkout_outlined,size:userMobile(context)?  22.sp:35.sp,),
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),),
    );
  }
}
