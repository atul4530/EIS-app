
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import 'view/SplashScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  FlutterSizer(
        builder: (context, orientation, screenType) {
        return  GetMaterialApp(
          home: const SplashScreen(),
          theme: ThemeData(fontFamily: 'Mulish',primaryColor: Color(0xff5338B4)),
        );
      }
    );
  }
}
