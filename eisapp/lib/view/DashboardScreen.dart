import 'dart:convert';

import 'package:eisapp/model/LoginResponeModel.dart';
import 'package:eisapp/view/ApprovalScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/pref_data.dart';
import 'LoginScreen.dart';
import 'ProductsScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with BackgroundDecoration {
  int selectedIndex=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);
  }

  getData(BuildContext context){
    PreferenceHelper().getStringValuesSF("data").then((value) {
      print("---Value----$value");
      LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode(value!));
      print("------${loginResponseModel.data!.first.digitalCatalogueReg}");

    });
  }

  @override
  Widget build(BuildContext context) {

    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    return SafeArea(
      child: Scaffold(
        body: selectedIndex==1?ProductsScreen():selectedIndex==2?ApprovalScreen():selectedIndex==3?Container(): dashBoardView(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 5,
          selectedItemColor: Color(0xff3B1CAD),
          unselectedItemColor: Color(0xff7882A9),
          selectedLabelStyle: TextStyle(
            color: Color(0xff3B1CAD)
          ),
          type: BottomNavigationBarType.fixed,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Image.asset(selectedIndex==0?"assets/images/dashboard.png":"assets/images/dashboard_black.png",height: 22.sp,width: 22.sp,fit: BoxFit.fill,), label: "Dashboard"),
            BottomNavigationBarItem(icon: Image.asset(selectedIndex==1?"assets/images/products.png":"assets/images/products_black.png",height: 22.sp,width: 22.sp,fit: BoxFit.fill,), label: "Products"),
            BottomNavigationBarItem(icon: Image.asset(selectedIndex==2?"assets/images/approval.png":"assets/images/approval_black.png",height: 22.sp,width: 22.sp,fit: BoxFit.fill,), label: "Approval"),
            BottomNavigationBarItem(icon: Image.asset(selectedIndex==3?"assets/images/settings.png":"assets/images/settings_black.png",height: 22.sp,width: 22.sp,fit: BoxFit.fill,), label: "Settings"),
          ],
          currentIndex: selectedIndex,
          //fixedColor: Colors.deepPurple,
          onTap: (val){
            setState(() {
              selectedIndex=val;
            });
          },
        ),
      ),
    );
  }

  Widget dashBoardView(){
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: bgDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height/4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width/4.5,)),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.clear();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              LoginScreen()), (Route<dynamic> route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.logout,size: 6.w,color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      Text("Welcome",style: TextStyle(color: Colors.white,fontSize: useMobileLayout?16.sp:22.sp),),
                      Text("Kathigeyan M",style: TextStyle(color: Colors.white,fontSize: useMobileLayout?18.sp:26.sp),),
                    ],
                  ),
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
              height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonTile(context,"sales.png","Sales",(){}),
                          buttonTile(context,"pdd.png","PDD",(){}),
                          buttonTile(context,"rm_inventory.png","RM Inventory",(){})
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonTile(context,"fg_inventory.png","FG Inventory",(){}),
                          buttonTile(context,"prod_stat.png","Production Status",(){}),
                          buttonTile(context,"expenses.png","Expenses",(){})
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buttonTile(context,"financial.png","Financial",(){}),
                          buttonTile(context,"account.png","Accounting",(){}),
                          buttonTile(context,"warehouse.png","Warehouse",(){})
                        ],
                      ),
                    ],
                  ),
                  Text("V 1.3.dev",style: TextStyle(color:  Color(0xff7882A9)),)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}

Widget buttonTile(BuildContext context,String image,String name,dynamic onTap){

  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Container(
        height: MediaQuery.of(context).size.width/3.4,
        width: MediaQuery.of(context).size.width/3.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/"+image,height: 10.w,),
            SizedBox(height: 8,),
            Text(name,style: TextStyle(fontSize: useMobileLayout?16.sp:20.sp),textAlign: TextAlign.center,)
          ],
        ),
      ),
    ),
  );
}
