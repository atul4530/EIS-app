import 'package:eisapp/view/ProductDetailsScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'CatelogListScreen.dart';

class CreateCatelog extends StatefulWidget {
  const CreateCatelog({super.key});

  @override
  State<CreateCatelog> createState() => _CreateCatelogState();
}

class _CreateCatelogState extends State<CreateCatelog> with BackgroundDecoration {
  bool light = false;
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
                          Text("Create Catelog",style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?16.sp:20.sp),),
                           Row(
                            children: [
                              Icon(Icons.search,color: Colors.white,size:  userMobile(context)?22.sp:27.sp,),
                              SizedBox(width: 10,),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CatelogListScreen()));
                                  },
                                  child: Icon(Icons.list,color: Colors.white,size:  userMobile(context)?22.sp:27.sp,))],
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(width: 1,color: const Color(0xff32B7C6))
                                  ),
                                  child: Container(
                                    height: 14,
                                    width: 14,
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color:  const Color(0xff32B7C6),
                                      border: Border.all(color:  const Color(0xff32B7C6))
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                 Text("CONTRACT",style: TextStyle(color: Colors.black,fontSize: userMobile(context)?15.sp:20.sp),),

                              ],
                            ),
                            Row(
                              children: [
                                 Text("In Stock",style: TextStyle(color: Colors.black,fontSize:  userMobile(context)?15.sp:20.sp),),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: light,

                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      light = value;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      Expanded(
                        child: GridView.builder(
                         // physics: NeverScrollableScrollPhysics(),
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:  2,
                            mainAxisSpacing: userMobile(context)? 2:10,
                            childAspectRatio:userMobile(context)? .84:1,
                            crossAxisSpacing:  userMobile(context)? 2:10
                          ),
                          padding: const EdgeInsets.all(0), // padding around the grid
                          itemCount: 20, // total number of items
                          itemBuilder: (context, index) {
                            return gridItem(context);
                          },
                        ),
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

  Widget gridItem(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen()));
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: MediaQuery.of(context).size.width/2.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [

              Column(
                children: [
                  Column(
                    children: [
                        Container(
                            width: MediaQuery.of(context).size.width/2.1,

                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                            ),
                            alignment: Alignment.center,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                child: Image.asset("assets/images/jewellery.png",height: MediaQuery.of(context).size.width/5.5,width: MediaQuery.of(context).size.width/6.5,fit: BoxFit.cover,))),
                        Container(
                          width: MediaQuery.of(context).size.width/2.1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: const Color(0xff8953a8).withOpacity(0.5)
                          ),
                          child:  Text("CN/592410",style: TextStyle(fontSize: userMobile(context)?13.sp:20.sp),),
                        )

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4,right: 4,bottom: 8,top: 3),
                    child: Column(
                      children: [
                        detailedWidget("099033"),
                        detailedWidget("Pendant"),
                        detailedWidget("Diamond Classic Collection"),
                        detailedWidget("Diamond Classic"),
                        detailedWidget("Diamond 0.43 Cts."),
                        detailedWidget("14k White Gold: 8.95 Gms"),
                      ],
                    ),
                  ),
                ],
              ),
               GestureDetector(
                 onTap: (){
                   openDigitalCatelog(context);
                 },
                 child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add_shopping_cart_outlined,color: Color(0xff6a208f),size: userMobile(context)?24.sp:27.sp,),
                             ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailedWidget(String name){
    return Row(
      children: [
        const Icon(Icons.circle_outlined,color: Colors.black,size: 12,),
        const SizedBox(width: 3,),
        Text(name,style:  TextStyle(fontSize: userMobile(context)? 11.sp:18.sp,fontWeight: FontWeight.w500),)
      ],
    );
  }

  openDigitalCatelog(BuildContext context){
    showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Container(
            height: 70.h,
            width: 98.w,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Digital Catelog",style: TextStyle(color: Color(0xff6a208f),fontSize: 22.sp,fontWeight: FontWeight.w400),),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                            )
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Catelog Name*",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13.sp),textAlign: TextAlign.start,)),
                      Container(
                        height: 30.sp,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withOpacity(0.5),width: 0.5),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                        ),
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Remarks",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13.sp),textAlign: TextAlign.start,)),
                      Container(
                        height: 30.sp,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withOpacity(0.5),width: 0.5),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                        ),
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                   height: 30.sp,
                   width: 100.w,
                   margin: EdgeInsets.symmetric(horizontal: 12),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black.withOpacity(0.5),width: 0.5),
                     borderRadius: BorderRadius.circular(10)
                   ),
                   alignment: Alignment.centerLeft,
                   child:  Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: Text("Select Columns Required*",style: TextStyle(fontSize: 15.sp,color: Colors.black.withOpacity(0.5)),),
                   ),
                                        ),
                ),
                  ],
            ),
          ),
        ));
  }

}

bool userMobile(BuildContext context){
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;
  return useMobileLayout;
}