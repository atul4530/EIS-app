import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'CreateCatelog.dart';

class SingleCatelogScreen extends StatefulWidget {
  final String catelog;
   SingleCatelogScreen({super.key,required this.catelog});

  @override
  State<SingleCatelogScreen> createState() => _SingleCatelogScreenState();
}

class _SingleCatelogScreenState extends State<SingleCatelogScreen> with BackgroundDecoration {
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
                              child:  Icon(Icons.arrow_back,color: Colors.white,size: userMobile(context)?16.sp:25.sp,)),

                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(userMobile(context)? 8.0:16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.catelog,style: TextStyle(color: Colors.white,fontSize:  userMobile(context)?16.sp:25.sp),),
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
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/5.8,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  2,
                      mainAxisSpacing: userMobile(context)? 2:10,
                      childAspectRatio:userMobile(context)? .84:1,
                      crossAxisSpacing:  userMobile(context)? 2:10
                  ),
                  padding: const EdgeInsets.only(top: 10,left: 4,right: 4), // padding around the grid
                  itemCount: 20, // total number of items
                  itemBuilder: (context, index) {
                    return gridItem(context);
                  },
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
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen()));
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
                        child:  Text("CN/592410",style: TextStyle(fontSize: userMobile(context)?13.sp:18.sp),),
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
                 //openDigitalCatelog(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.delete,color: Color(0xffc93828),size: userMobile(context)?24.sp:27.sp,),
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
}
