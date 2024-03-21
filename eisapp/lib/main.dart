import 'package:eisapp/provider/GetBarcodeCatelogListProvider.dart';
import 'package:eisapp/provider/GetBarcodeNameListProvider.dart';
import 'package:eisapp/provider/GetCatelogReqColumnProvider.dart';
import 'package:eisapp/provider/GetFinishedProductMainInfoProvider.dart';
import 'package:eisapp/provider/KciUpdateCatelogNameProvider.dart';
import 'package:eisapp/provider/LoginProvider.dart';
import 'package:eisapp/provider/SaveBarcodeScanProvider.dart';
import 'package:eisapp/provider/VersionCheckProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<VersionCheckProvider>(create: (_) => VersionCheckProvider()),
        ChangeNotifierProvider<GetBarcodeNameListProvider>(create: (_) => GetBarcodeNameListProvider()),
        ChangeNotifierProvider<GetBarcodeCatelogListProvider>(create: (_) => GetBarcodeCatelogListProvider()),
        ChangeNotifierProvider<GetCatelogReqColumnProvider>(create: (_) => GetCatelogReqColumnProvider()),
        ChangeNotifierProvider<SaveBarcodeScanProvider>(create: (_) => SaveBarcodeScanProvider()),
        ChangeNotifierProvider<GetFinishedProductMainInfoProvider>(create: (_) => GetFinishedProductMainInfoProvider()),
        ChangeNotifierProvider<KciUpdateCatelogNameProvider>(create: (_) => KciUpdateCatelogNameProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
