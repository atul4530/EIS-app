import 'package:eisapp/view/design_consts/DecorationMixin.dart';
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
          physics: NeverScrollableScrollPhysics(),
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
                          Text("CN/592690",style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?16.sp:18.sp),),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Image.asset("assets/images/jewellery.png",height: 26.h,width: 26.h,),
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
