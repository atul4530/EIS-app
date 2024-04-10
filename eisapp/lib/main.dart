
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'view/SplashScreen.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  FlutterSizer(
        builder: (context, orientation, screenType) {
        return  const MaterialApp(
          home: SplashScreen(),
        );
      }
    );
  }
}
