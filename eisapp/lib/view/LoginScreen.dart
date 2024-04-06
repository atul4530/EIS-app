// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:eisapp/helper/pref_data.dart';
import 'package:eisapp/network/ApiService.dart';
import 'package:eisapp/view/DashboardScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:eisapp/view/loader/loader.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BackgroundDecoration {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/login_bg.webp",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Container(
                margin: EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/kgk.png",
                      height: MediaQuery.of(context).size.width / 4,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: TextField(
                          controller: userNameController,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontStyle: FontStyle.normal,
                            fontSize: useMobileLayout ? 15.sp : 17.sp,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 6),
                            hintText: "Username*",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: useMobileLayout ? 15.sp : 17.sp,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: TextField(
                          controller: passWordController,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontStyle: FontStyle.normal,
                            fontSize: useMobileLayout ? 15.sp : 17.sp,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password*",
                            contentPadding: const EdgeInsets.only(left: 6),
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontStyle: FontStyle.normal,
                              fontSize: useMobileLayout ? 15.sp : 17.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        loginData(context, userNameController.text.trim(),
                            passWordController.text.trim());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFF3366FF),
                                Color(0xFF00CCFF),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: useMobileLayout ? 17.sp : 20.sp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  loginData(BuildContext context, String userName, passWord) async {
    showLoaderDialog(context);
    var response = await ApiService.getData("smartservice/slogin/${userName}/$passWord");
    if(jsonDecode(response.body)["result"].toString()=="true") {
      await PreferenceHelper().addStringToSF("data", response.body);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
    }
    else
      {
        Navigator.pop(context);
        const snackBar = SnackBar(
          content: Text("Something Went Wrong!!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
  }
}
