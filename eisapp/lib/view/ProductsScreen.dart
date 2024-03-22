import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/material.dart';

import 'DashboardScreen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with BackgroundDecoration{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: bgDecoration(),
      child: Column(
        children: [
          Container(
            //color: Colors.black,
            height: MediaQuery.of(context).size.height/9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width/4.5,)),
                    Image.asset("assets/images/logout.png",width: MediaQuery.of(context).size.width/6,),
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
            height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/4.19,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buttonTile(context,"catalog.jpg","Catelog",(){}),
                    buttonTile(context,"barcode-scan.png","Barcode\nScan",(){}),
                    Container(
                      height: MediaQuery.of(context).size.width/3.4,
                      width: MediaQuery.of(context).size.width/3.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
