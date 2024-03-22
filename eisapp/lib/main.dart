
import 'package:eisapp/view/LoginScreen.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

void main() {
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       // ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
  //       // ChangeNotifierProvider<VersionCheckProvider>(create: (_) => VersionCheckProvider()),
  //       // ChangeNotifierProvider<GetBarcodeNameListProvider>(create: (_) => GetBarcodeNameListProvider()),
  //       // ChangeNotifierProvider<GetBarcodeCatelogListProvider>(create: (_) => GetBarcodeCatelogListProvider()),
  //       // ChangeNotifierProvider<GetCatelogReqColumnProvider>(create: (_) => GetCatelogReqColumnProvider()),
  //       // ChangeNotifierProvider<SaveBarcodeScanProvider>(create: (_) => SaveBarcodeScanProvider()),
  //       // ChangeNotifierProvider<GetFinishedProductMainInfoProvider>(create: (_) => GetFinishedProductMainInfoProvider()),
  //       // ChangeNotifierProvider<KciUpdateCatelogNameProvider>(create: (_) => KciUpdateCatelogNameProvider()),
  //     ],
  //     child: MyApp(),
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}
