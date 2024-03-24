
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:flutter/material.dart';

class ScanContact extends StatefulWidget {
  const ScanContact({super.key});

  @override
  State<ScanContact> createState() => _ScanContactState();
}

class _ScanContactState extends State<ScanContact> with BackgroundDecoration{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
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

              ],
            ),
          )

        ],
      ),
    ),);
  }
}
