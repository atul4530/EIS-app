import 'package:flutter/material.dart';

mixin BackgroundDecoration{
  BoxDecoration bgDecoration(){
    return const BoxDecoration(
      gradient: LinearGradient(
          colors: [
             Color(0xFF3366FF),
             Color(0xFF00CCFF),
          ],
          begin:  FractionalOffset(0.0, 0.0),
          end:  FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
    );
  }
}