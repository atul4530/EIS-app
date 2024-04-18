import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

mixin BackgroundDecoration{
  BoxDecoration bgDecoration(){
    return  BoxDecoration(

      gradient: LinearGradient(
          colors: [
             Color(0xFF562162),
             Color(0xFF553BDF),
          ],

          begin:  FractionalOffset(1.0, 0.0),
          end:  FractionalOffset(0.0, 0.5),
          stops: [0.0, 1.0,],
          tileMode: TileMode.mirror),
    );
  }
}